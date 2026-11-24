import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';
import 'fake_web_service.dart';

// One database for the whole app. Close it when the provider is disposed.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

// ---- to-do list: the screen just watches this stream ----
final todosProvider = StreamProvider<List<TodoItem>>((ref) {
  return ref.watch(databaseProvider).watchTodos();
});

// ---- posts: search text, then the matching saved posts ----
class SearchQuery extends Notifier<String> {
  @override
  String build() => '';

  void set(String value) => state = value;
}

final searchQueryProvider =
    NotifierProvider<SearchQuery, String>(SearchQuery.new);

final savedPostsProvider = StreamProvider<List<CachedPost>>((ref) {
  final query = ref.watch(searchQueryProvider);
  return ref.watch(databaseProvider).watchPosts(query);
});

// ---- the web service (fake, for class) and an "offline" switch ----
class OfflineSwitch extends Notifier<bool> {
  @override
  bool build() => false;

  void set(bool value) => state = value;
}

final offlineSwitchProvider =
    NotifierProvider<OfflineSwitch, bool>(OfflineSwitch.new);

final webServiceProvider = Provider<FakeWebService>((ref) {
  return FakeWebService(isOffline: () => ref.read(offlineSwitchProvider));
});

// ---- sync: ask the web service, write the answer into the database ----
class SyncState {
  const SyncState({this.syncing = false, this.error, this.lastSync});
  final bool syncing;
  final String? error; // null means the last sync worked
  final DateTime? lastSync;
}

class SyncNotifier extends Notifier<SyncState> {
  @override
  SyncState build() => const SyncState();

  Future<void> sync() async {
    state = SyncState(syncing: true, lastSync: state.lastSync);
    try {
      final posts = await ref.read(webServiceProvider).fetchPosts();
      final rows = posts
          .map((p) => CachedPostsCompanion.insert(
                id: p.id,
                userId: p.userId,
                title: p.title,
                body: p.body,
              ))
          .toList();
      await ref.read(databaseProvider).replaceAllPosts(rows);
      state = SyncState(lastSync: DateTime.now());
    } on WebServiceException catch (e) {
      // keep the old data, just remember why the sync failed
      state = SyncState(error: e.message, lastSync: state.lastSync);
    }
  }
}

final syncProvider = NotifierProvider<SyncNotifier, SyncState>(SyncNotifier.new);
