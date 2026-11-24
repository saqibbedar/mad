// A pretend web service for the class demo. It answers after one second and
// can be switched to "offline" so we can watch what the app does when the
// connection fails. In a real project this class is replaced by your real
// web/API code; nothing else in the app has to change.
class RemotePost {
  const RemotePost({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  final int id;
  final int userId;
  final String title;
  final String body;
}

class WebServiceException implements Exception {
  const WebServiceException(this.message);
  final String message;
}

class FakeWebService {
  FakeWebService({required this.isOffline});

  final bool Function() isOffline;

  static const _topics = [
    'Learning Flutter step by step',
    'Why databases matter on a phone',
    'Queries, filters and sorting',
    'Streams keep the screen fresh',
    'Working without internet',
    'Designing a clean list screen',
  ];

  Future<List<RemotePost>> fetchPosts() async {
    await Future.delayed(const Duration(seconds: 1)); // pretend it is slow
    if (isOffline()) {
      throw const WebServiceException('No internet connection.');
    }
    return List.generate(30, (i) {
      final n = i + 1;
      return RemotePost(
        id: n,
        userId: 1,
        title: _topics[i % _topics.length] + ' #' + n.toString(),
        body: 'Sample text for post ' + n.toString(),
      );
    });
  }
}
