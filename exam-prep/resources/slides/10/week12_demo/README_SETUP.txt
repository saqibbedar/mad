WEEK 12 DEMOS (run inside your counter_app folder)

PART A: Drift  (stand-alone: no Week 11 files needed)
1) Copy lib/w12 into counter_app/lib/
2) Packages:
   flutter pub add drift drift_flutter
   flutter pub add --dev drift_dev build_runner
3) Generate code (creates app_database.g.dart):
   dart run build_runner build --delete-conflicting-outputs
4) WEB ONLY (Edge): put two files in counter_app/web/
     sqlite3.wasm
     drift_worker.dart.js
   Download both from the drift GitHub releases page (github.com/simolus3/drift/releases).
   Use the release that matches the drift version in pubspec.lock.
   (Not on Windows/Android? Run on a phone or Windows desktop instead: no extra files.)
5) Run:
   flutter run -d edge --web-port=5000 -t lib/w12/drift_todo_main.dart
   flutter run -d edge --web-port=5000 -t lib/w12/posts_offline_main.dart

PART B: Firestore completion (your Week 10 Firebase project)
1) Copy firestore_demo/lib/main.dart over lib/main.dart of the project that
   already has Firebase set up. task.dart stays the same.
2) Paste firestore_demo/firestore.rules into Firebase console > Firestore > Rules > Publish.
3) flutter run -d edge
