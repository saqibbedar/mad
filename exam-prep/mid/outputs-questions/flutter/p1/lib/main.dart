import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext ctx) {
    return const MaterialApp(
      title: 'Counter App',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext ctx) {
    return const Scaffold(
      body: Center(
        child: Counter(), // Renders your Counter component
      ),
    );
  }
}

// 1. Public Component (like <Counter /> in React)
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

// 2. Component State & Render Logic (persists across re-renders)
class _CounterState extends State<Counter> {
  // Equivalent to: const [count, setCount] = useState(0);
  int _count = 0;

  void _increment() {
    // Equivalent to: setCount(prev => prev + 1)
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      _count--;
    });
  }

  // Equivalent to the return (...) block of your React component
  @override
  Widget build(BuildContext ctx) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$_count',
          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _decrement, // Like onClick={decrement}
              child: const Text('-'),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: _increment, // Like onClick={increment}
              child: const Text('+'),
            ),
          ],
        ),
      ],
    );
  }
}
