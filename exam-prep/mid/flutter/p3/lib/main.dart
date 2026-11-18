import 'package:material_ui/material_ui.dart';
import 'home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext ctx) {
    return const MaterialApp(
      title: 'Card App',
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}
