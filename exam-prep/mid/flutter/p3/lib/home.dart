import 'package:material_ui/material_ui.dart';
import 'components/card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6ECF2),
      // appBar: AppBar(title: Text("Home"),),
      body: Center(
        child: Card(
          imgUrl: "",
          tags: const ['Nature', 'Lake'],
          title: 'Lorem ipsum dollar amit...',
          description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Consectetur sodales morbi dignissim sed diam pharetra vitae ipsum odio.",
          onReadMore: () {
            debugPrint('Read More clicked');
          }
        ),
      ),
    );
  }
}
