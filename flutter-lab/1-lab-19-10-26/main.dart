// main.dart - Study Tracker lab
import 'dart:async';

import 'package:flutter/material.dart';

const String studentName = 'Saqib Bedar';
const String rollNo = '04072313037'; // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> courses = [
  'Mobile Dev',
  'Data Structures',
  'Operating Systems',
  'Databases',
  'Networks',
  'Software Eng',
  'AI',
  'Web Engineering',
  'Graphics',
  'Security',
];

final String course = courses[u]; // your course name
final int startCount = 3 + u; // where the tally starts
final int stepSize = 1 + t % 4; // how much + and - change the tally
final int maxCount = 20 + 2 * t; // the tally may never go above this
final int startSeconds = 5 + (t + u) % 6; // where the countdown starts
final int bugStep = 1 + u % 4; // used by BuggyCounter in Step 7
// ===========================================================================

// Step 9 writes to this list from initState and dispose.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Keep the name LabApp and its const constructor: the checker uses them.
class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Study Tracker', home: HomePage());
  }
}

// Think: Hot reload while the count is 12. Does it stay 12? Now do a hot restart.
// Explain the difference using the words widget and State.
// Answer:
// 1. Hot reload: The count stays 12. Hot reload injects updated widget code and rebuilds
//    the widget tree while preserving existing State objects in memory. Because _count is
//    held in _TallyState, its value is not lost.
// 2. Hot restart: The count resets to startCount (10). Hot restart destroys the entire application
//    state, clears all State objects, and re-instantiates new widget and State instances from scratch.
class Tally extends StatefulWidget {
  const Tally({super.key});

  @override
  State<Tally> createState() => _TallyState();
}

class _TallyState extends State<Tally> {
  int _count = startCount;

  void _plus() {
    setState(() {
      _count += stepSize;
      if (_count > maxCount) _count = maxCount;
    });
  }

  void _minus() {
    setState(() {
      _count -= stepSize;
      if (_count < 0) _count = 0;
    });
  }

  void _reset() {
    setState(() {
      _count = startCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Count: $_count', key: const Key('count')),
        GoalBanner(count: _count, max: maxCount),
        Row(
          children: [
            ElevatedButton(
              key: const Key('plus'),
              onPressed: _plus,
              child: Text('+$stepSize'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              key: const Key('minus'),
              onPressed: _minus,
              child: Text('-$stepSize'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              key: const Key('reset'),
              onPressed: _reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}

// Think: What is the difference between what runApp receives and what MaterialApp receives as home?
// Answer: runApp() receives the root widget of the entire Flutter application and attaches the widget tree
// to the screen/engine. MaterialApp's home receives the top-level widget/screen (HomePage) that is rendered
// as the default route of the Material design layout.

// Think: Draw the widget tree of your screen on paper, from LabApp down to the three Text widgets.
// How many levels deep is the Text('Max: ..')?
// Answer: 8 levels deep:
// Level 1: LabApp
// Level 2:   MaterialApp
// Level 3:     HomePage
// Level 4:       Scaffold
// Level 5:         SingleChildScrollView
// Level 6:           Column
// Level 7:             Row
// Level 8:               Text('Max: $maxCount')
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Study Tracker: $course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StudentCard(name: studentName, roll: rollNo, course: course),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start: $startCount', key: const Key('info-start')),
                Text('Step: $stepSize', key: const Key('info-step')),
                Text('Max: $maxCount', key: const Key('info-max')),
              ],
            ),
            const SizedBox(height: 12),
            const Tally(),
            const SizedBox(height: 12),
            const BuggyCounter(),
          ],
        ),
      ),
    );
  }
}

// Think: Why does GoalBanner not need setState? What would you have to do to make it show a new count?
// Answer: GoalBanner is a StatelessWidget without internal mutable state; its build() is a pure
// function of the inputs (count and max) passed into it. To display a new count, its parent widget
// (a StatefulWidget) must update its own state via setState(), triggering a rebuild that re-instantiates
// GoalBanner with the new count value.
class GoalBanner extends StatelessWidget {
  final int count;
  final int max;

  const GoalBanner({super.key, required this.count, required this.max});

  @override
  Widget build(BuildContext context) {
    final percent = count * 100 ~/ max;
    return Text(
      'Progress: $count of $max ($percent%)',
      key: const Key('progress'),
    );
  }
}

// Think: Why are the fields of a StatelessWidget final? What would the compiler say if you removed final?
// Answer: Widgets in Flutter are immutable configurations that represent a snapshot of the UI.
// StatelessWidget instances cannot change over time; their data must remain constant once instantiated.
// If 'final' is removed, the compiler/analyzer warns: "This class is marked as '@immutable',
// but one or more of its instance fields aren't final (must_be_immutable)" and you cannot have
// a 'const' constructor for a class with non-final fields.
class StudentCard extends StatelessWidget {
  final String name;
  final String roll;
  final String course;

  const StudentCard({
    super.key,
    required this.name,
    required this.roll,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $name', key: const Key('student-name')),
            Text('Roll no: $roll', key: const Key('student-roll')),
            Text('Course: $course', key: const Key('student-course')),
          ],
        ),
      ),
    );
  }
}

// ---- Provided for Step 7. It has a bug on purpose. Do not rename anything.
// Think: Before the fix, you tapped three times. What was the value of _clicks inside the State,
// and what did the screen show? Write both numbers.
// Answer:
// Value inside State: 12 (3 taps * bugStep of 4 = 12)
// Screen showed: 0 (because without setState(), Flutter never called build() to refresh the UI)
class BuggyCounter extends StatefulWidget {
  const BuggyCounter({super.key});

  @override
  State<BuggyCounter> createState() => _BuggyCounterState();
}

class _BuggyCounterState extends State<BuggyCounter> {
  int _clicks = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Bug clicks: $_clicks', key: const Key('bug-text')),
        const SizedBox(width: 12),
        ElevatedButton(
          key: const Key('bug-button'),
          onPressed: () {
            setState(() {
              _clicks += bugStep;
            });
          },
          child: Text('+$bugStep'),
        ),
      ],
    );
  }
}
