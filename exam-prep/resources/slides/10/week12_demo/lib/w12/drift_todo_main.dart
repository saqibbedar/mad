// Demo 1: Drift basics. A to-do list stored in a real database on the device.
// Run:  flutter run -d edge --web-port=5000 -t lib/w12/drift_todo_main.dart
// (web needs sqlite3.wasm + drift_worker.dart.js in the web/ folder)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

void main() {
  runApp(const ProviderScope(child: MaterialApp(home: TodoScreen())));
}

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _add() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    await ref.read(databaseProvider).addTodo(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todosProvider);
    final db = ref.read(databaseProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Drift to-do')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(labelText: 'New item'),
                    onSubmitted: (_) => _add(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _add, child: const Text('Add')),
              ],
            ),
          ),
          Expanded(
            child: todos.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Database error: $e')),
              data: (list) => list.isEmpty
                  ? const Center(child: Text('Nothing yet. Add an item.'))
                  : ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, i) {
                        final t = list[i];
                        return CheckboxListTile(
                          title: Text(t.title),
                          value: t.done,
                          onChanged: (v) => db.setDone(t.id, v ?? false),
                          secondary: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => db.removeTodo(t.id),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
