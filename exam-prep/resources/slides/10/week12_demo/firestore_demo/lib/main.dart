// Week 12: Firestore completion. Same app as Week 10, plus rename, filter (where),
// limit, batch delete and a sorted list. Auth screens are unchanged.
// Setup (see Firebase_Setup_Checklist.docx), then:
//   flutter pub add firebase_core firebase_auth cloud_firestore flutter_riverpod freezed_annotation json_annotation
//   flutter pub add --dev build_runner freezed json_serializable
//   flutterfire configure          (creates lib/firebase_options.dart)
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Drift_Offline_Firestore/week12_demo/firestore_demo/lib/firebase_options.dart';
import 'task.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MaterialApp(home: AuthGate())));
}

// ---- Auth: a stream of "who is signed in" ----
final authStateProvider = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authStateProvider);
    return auth.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (user) => user == null ? const LoginScreen() : const TasksScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  String? _error;

  Future<void> _run(Future<void> Function() action) async {
    try {
      await action();
    } on FirebaseAuthException catch (e) {
      setState(() => _error = e.code); // e.g. wrong-password, weak-password
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _run(() => auth.signInWithEmailAndPassword(
                      email: _email.text.trim(), password: _password.text)),
                  child: const Text('Sign in'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () => _run(() =>
                      auth.createUserWithEmailAndPassword(
                          email: _email.text.trim(), password: _password.text)),
                  child: const Text('Sign up'),
                ),
              ],
            ),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}

// ---- Firestore: users/{uid}/tasks/{taskId} ----
CollectionReference<Map<String, dynamic>> _tasksCol() {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('tasks');
}

enum TaskFilter { all, open, done }

class TaskRepository {
  // READ with a query: where + limit.
  // (where on one field + orderBy on ANOTHER field needs a composite index,
  //  so we sort the small list in Dart instead.)
  Stream<List<Task>> watchTasks(TaskFilter filter) {
    Query<Map<String, dynamic>> q = _tasksCol();
    if (filter == TaskFilter.open) q = q.where('done', isEqualTo: false);
    if (filter == TaskFilter.done) q = q.where('done', isEqualTo: true);
    return q.limit(50).snapshots().map((snap) {
      final list = snap.docs.map((d) => Task.fromJson(d.data())).toList();
      list.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
      return list;
    });
  }

  // CREATE
  Future<void> add(String title) {
    final doc = _tasksCol().doc();
    return doc.set(Task(id: doc.id, title: title).toJson());
  }

  // UPDATE: only the fields we name change
  Future<void> setDone(Task t, bool done) =>
      _tasksCol().doc(t.id).update({'done': done});

  Future<void> rename(Task t, String title) =>
      _tasksCol().doc(t.id).update({'title': title});

  // DELETE one
  Future<void> remove(Task t) => _tasksCol().doc(t.id).delete();

  // DELETE many in one all-or-nothing batch
  Future<void> clearDone() async {
    final snap = await _tasksCol().where('done', isEqualTo: true).get();
    final batch = FirebaseFirestore.instance.batch();
    for (final d in snap.docs) {
      batch.delete(d.reference);
    }
    await batch.commit();
  }
}

final taskRepoProvider = Provider((ref) => TaskRepository());

class FilterNotifier extends Notifier<TaskFilter> {
  @override
  TaskFilter build() => TaskFilter.all;

  void set(TaskFilter f) => state = f;
}

final filterProvider =
    NotifierProvider<FilterNotifier, TaskFilter>(FilterNotifier.new);

final tasksProvider = StreamProvider<List<Task>>((ref) {
  ref.watch(authStateProvider); // restart the stream if the user changes
  final filter = ref.watch(filterProvider); // and when the filter changes
  return ref.watch(taskRepoProvider).watchTasks(filter);
});

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  Future<String?> _askTitle(BuildContext context, String initial) {
    final controller = TextEditingController(text: initial);
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Task title'),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    final filter = ref.watch(filterProvider);
    final repo = ref.read(taskRepoProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          IconButton(
            tooltip: 'Clear completed',
            icon: const Icon(Icons.cleaning_services),
            onPressed: () => repo.clearDone(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              children: [
                for (final f in TaskFilter.values)
                  ChoiceChip(
                    label: Text(f.name),
                    selected: filter == f,
                    onSelected: (_) => ref.read(filterProvider.notifier).set(f),
                  ),
              ],
            ),
          ),
          Expanded(
            child: tasks.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (list) => ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final t = list[i];
                  return Dismissible(
                    key: ValueKey(t.id),
                    background: Container(color: Colors.red),
                    onDismissed: (_) => repo.remove(t),
                    child: CheckboxListTile(
                      title: Text(t.title),
                      value: t.done,
                      onChanged: (v) => repo.setDone(t, v ?? false),
                      secondary: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          final name = await _askTitle(context, t.title);
                          if (name != null && name.isNotEmpty) {
                            await repo.rename(t, name);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final name = await _askTitle(context, '');
          if (name != null && name.isNotEmpty) await repo.add(name);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
