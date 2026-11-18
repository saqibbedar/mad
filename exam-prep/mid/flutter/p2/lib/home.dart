import 'package:material_ui/material_ui.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'),),
      body: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 8,
            children: [
              Text("1", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),), 
              Text("2")
              ],
          ),
          const SizedBox(height: 16,),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10)
            ),
            height: 30,
          )
        ],)
        
      ),
    );
  }
}