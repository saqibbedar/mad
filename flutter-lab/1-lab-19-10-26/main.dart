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
// Stateless: Root application configuration widget that never changes its internal state.
class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Study Tracker', home: HomePage());
  }
}

// Think: What is the difference between what runApp receives and what MaterialApp receives as home?
// Answer: runApp() takes the root widget of the Flutter widget tree and attaches it to the screen rendering pipeline.
// MaterialApp's home receives the top-level route/screen widget displayed inside the Material app environment.
//
// Think: Draw the widget tree of your screen on paper, from LabApp down to the three Text widgets.
// How many levels deep is the Text('Max: ..')?
// Answer: 8 levels deep:
// Level 1: LabApp -> Level 2: MaterialApp -> Level 3: HomePage -> Level 4: Scaffold ->
// Level 5: SingleChildScrollView -> Level 6: Column -> Level 7: Row -> Level 8: Text('Max: $maxCount')
//
// Stateless: Represents the static screen layout containing child widgets; it does not store mutable state.
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
            const Countdown(),
            const SizedBox(height: 12),
            const BuggyCounter(),
          ],
        ),
      ),
    );
  }
}

// Think: Why are the fields of a StatelessWidget final? What would the compiler say if you removed final?
// Answer: Widgets are immutable configurations. If final is removed, the compiler warns:
// "This class is marked as '@immutable', but one or more of its instance fields aren't final (must_be_immutable)"
// and a const constructor cannot be defined with non-final fields.
//
// Stateless: Immutable card that displays static student details passed via constructor arguments.
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

// Think: Why does GoalBanner not need setState? What would you have to do to make it show a new count?
// Answer: GoalBanner is a StatelessWidget whose build() is a pure function of its arguments. To show
// a new count, its parent StatefulWidget must update its state via setState(), triggering a rebuild that
// supplies the new count value to GoalBanner.
//
// Stateless: Computes and renders progress percentage strictly from properties passed by its parent.
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

// Think: The class Tally has no fields that change, yet _TallyState does. Why are there two classes?
// Answer: Tally is the immutable configuration widget recreated at low cost during rebuilds, while
// _TallyState is the persistent object in memory that preserves state across rebuilds.
//
// Think: Hot reload while the count is 12. Does it stay 12? Now do a hot restart. Explain the difference using the words widget and State.
// Answer: Hot reload keeps 12 because State instances persist in memory across widget rebuilds. Hot restart
// resets to 10 because it destroys all existing State instances and rebuilds the app from scratch.
//
// Stateful: Manages interactive mutable state (_count) updated via button clicks and bounds checks.
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

// Think: What error appears in the console if you delete the _timer.cancel() from dispose and the widget is removed?
// Answer: Flutter throws "FlutterError: setState() called after dispose()" causing a memory leak and crash.
//
// Think: Why does it increase by one per second and not by two? Where could you print lifecycleLog to prove that dispose ran?
// Answer: The periodic timer triggers once each second, invoking setState() once to schedule a single rebuild.
// lifecycleLog can be printed inside dispose() or from a parent widget after Countdown is unmounted.
//
// Stateful: Tracks active countdown state, build counts, and an asynchronous periodic Timer.
class Countdown extends StatefulWidget {
  const Countdown({super.key});

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late int _left;
  late Timer _timer;
  int _builds = 0;

  @override
  void initState() {
    super.initState();
    lifecycleLog.add('initState');
    _left = startSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _left--);
      if (_left <= 0) timer.cancel(); // stop at zero
    });
  }

  @override
  void dispose() {
    lifecycleLog.add('dispose');
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _builds++;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _left > 0
            ? Text('Time left: $_left s', key: const Key('time-left'))
            : const Text('Time is up!', key: Key('time-left')),
        Text('Builds: $_builds', key: const Key('builds')),
      ],
    );
  }
}

// Think: Before the fix, you tapped three times. What was the value of _clicks inside the State,
// and what did the screen show? Write both numbers.
// Answer: Value inside State: 12. Screen showed: 0.
//
// Stateful: Maintains a mutable click count (_clicks) updated by button presses.
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
