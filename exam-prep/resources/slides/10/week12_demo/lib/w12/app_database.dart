// The whole local database: two tables and the queries we need.
// After saving, run:  dart run build_runner build --delete-conflicting-outputs
// (that creates app_database.g.dart next to this file)
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part '../../../Drift_Offline_Firestore/week12_demo/lib/w12/app_database.g.dart';

// TABLE 1: our own to-do items (the user creates these)
class TodoItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 80)();
  BoolColumn get done => boolean().withDefault(const Constant(false))();
}

// TABLE 2: a saved copy of the posts from the web API (our cache)
class CachedPosts extends Table {
  IntColumn get id => integer()(); // same id as on the server
  IntColumn get userId => integer()();
  TextColumn get title => text()();
  TextColumn get body => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [TodoItems, CachedPosts])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // ---- to-do items ----
  Stream<List<TodoItem>> watchTodos() =>
      (select(todoItems)..orderBy([(t) => OrderingTerm.desc(t.id)])).watch();

  Future<int> addTodo(String title) =>
      into(todoItems).insert(TodoItemsCompanion.insert(title: title));

  Future<void> setDone(int id, bool done) =>
      (update(todoItems)..where((t) => t.id.equals(id)))
          .write(TodoItemsCompanion(done: Value(done)));

  Future<void> removeTodo(int id) =>
      (delete(todoItems)..where((t) => t.id.equals(id))).go();

  // ---- cached posts ----
  Stream<List<CachedPost>> watchPosts(String query) {
    final q = select(cachedPosts);
    if (query.isNotEmpty) {
      q.where((p) => p.title.contains(query));
    }
    q.orderBy([(p) => OrderingTerm.asc(p.id)]);
    return q.watch();
  }

  // Replace the whole saved copy in one step (all or nothing)
  Future<void> replaceAllPosts(List<CachedPostsCompanion> rows) {
    return batch((b) {
      b.deleteAll(cachedPosts);
      b.insertAll(cachedPosts, rows);
    });
  }
}

// Where the database file lives. On the web it needs two extra files in the
// web/ folder: sqlite3.wasm and drift_worker.dart.js (see the setup slide).
QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'w12_app_db',
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.dart.js'),
    ),
  );
}
