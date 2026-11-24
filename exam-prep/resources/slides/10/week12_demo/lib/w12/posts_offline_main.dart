// Demo 2: the full offline pattern.
// The screen ONLY reads from the database. A sync step copies the API into it.
// Run:  flutter run -d edge --web-port=5000 -t lib/w12/posts_offline_main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

void main() {
  runApp(const ProviderScope(child: MaterialApp(home: OfflinePostsScreen())));
}

class OfflinePostsScreen extends ConsumerStatefulWidget {
  const OfflinePostsScreen({super.key});

  @override
  ConsumerState<OfflinePostsScreen> createState() => _OfflinePostsScreenState();
}

class _OfflinePostsScreenState extends ConsumerState<OfflinePostsScreen> {
  @override
  void initState() {
    super.initState();
    // try to refresh once when the screen opens
    Future.microtask(() => ref.read(syncProvider.notifier).sync());
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(savedPostsProvider);
    final sync = ref.watch(syncProvider);
    final offline = ref.watch(offlineSwitchProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts (offline-ready)'),
        actions: [
          const Center(child: Text('Offline')),
          Switch(
            value: offline,
            onChanged: (v) => ref.read(offlineSwitchProvider.notifier).set(v),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(syncProvider.notifier).sync(),
          ),
        ],
      ),
      body: Column(
        children: [
          if (sync.syncing) const LinearProgressIndicator(),
          if (sync.error != null)
            Container(
              width: double.infinity,
              color: Colors.amber,
              padding: const EdgeInsets.all(8),
              child: Text('Offline: showing saved data. ${sync.error}'),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Search saved titles',
              ),
              onChanged: (v) => ref.read(searchQueryProvider.notifier).set(v),
            ),
          ),
          Expanded(
            child: posts.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Database error: $e')),
              data: (list) => list.isEmpty
                  ? const Center(child: Text('No saved posts yet.'))
                  : ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, i) => ListTile(
                        leading: Text('${list[i].id}'),
                        title: Text(list[i].title),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
