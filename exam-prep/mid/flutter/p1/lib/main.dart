// lightweight app
import 'package:flutter/widgets.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext ctx) {
    return Center(
      child: Text("Hello, world", textDirection: TextDirection.ltr),
    );
  }
}
