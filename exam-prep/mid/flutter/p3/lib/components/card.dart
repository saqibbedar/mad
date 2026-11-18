import 'package:material_ui/material_ui.dart';

class Card extends StatelessWidget {
  // props
  final String imgUrl;
  final List<String> tags;
  final String title;
  final String description;
  final VoidCallback? onReadMore;

  Card({
    super.key,
    required this.imgUrl,
    required this.tags,
    required this.title,
    required this.description,
    this.onReadMore,
  });

  @override
  Widget build(BuildContext ctx) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x00000025), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(imgUrl, fit: BoxFit.cover,),
          )
      ],),
    );
  }
}
