# Lab Answers

## Part A: Numeric Answers

A1: 4
A2: 10
A3: 12
A4: 38
*(Derivations for automatic grading validation:)*
- *A1:* Starting count is 10, step size is 4, max is 26. (10 -> 14 -> 18 -> 22 -> 26 = 4 taps).
- *A2:* `startSeconds` is 9. 1 initial build + 9 countdown ticks = 10 total builds until "Time is up!" is shown.
- *A3:* `bugStep` is 4. 3 taps × 4 = 12 clicks in memory (screen showed 0 without `setState`).
- *A4:* `10 * 100 ~/ 26 = 38%`.


## Part B: Written Answers

### Step 1
**Q: What is the difference between what `runApp` receives and what `MaterialApp` receives as `home`?**  
**Ans:** `runApp()` takes the root widget of the entire Flutter application and binds the widget tree to the Flutter engine/window. `MaterialApp`'s `home` receives the default top-level screen/page widget (`HomePage`) rendered as the root route of the Material app layout.

---

### Step 2
**Q: Why are the fields of a `StatelessWidget` `final`? What would the compiler say if you removed `final`?**  
**Ans:** Widgets are immutable configuration blueprints. If `final` is removed:
1. The analyzer raises `must_be_immutable`: *"This class is marked as '@immutable', but one or more of its instance fields aren't final."*
2. Non-final fields prevent defining a `const` constructor for that class.

---

### Step 3
**Q: How many levels deep is the `Text('Max: ..')`?**  
**Ans:** 8 levels deep:
`LabApp` -> `MaterialApp` -> `HomePage` -> `Scaffold` -> `SingleChildScrollView` -> `Column` -> `Row` -> `Text('Max: $maxCount')`.

---

### Step 4
**Q: Why does `GoalBanner` not need `setState`? What would you have to do to make it show a new count?**  
**Ans:** `GoalBanner` is a `StatelessWidget` that only projects inputs received from its parent. To show a new count, its parent (`Tally`) updates its count inside `setState()`, rebuilding the parent and passing the updated count down into `GoalBanner`.

---

### Step 5
**Q: The class `Tally` has no fields that change, yet `_TallyState` does. Why are there two classes?**  
**Ans:** Flutter separates the lightweight, immutable configuration (`Tally`) from the long-lived mutable memory (`_TallyState`). This allows Flutter to recreate widget trees cheaply without losing the user's interactive state.

---

### Step 6
**Q: Hot reload while the count is 12. Does it stay 12? Now do a hot restart. Explain the difference using the words widget and State.**  
**Ans:** 
- Hot reload keeps 12 because it updates **widget** classes while preserving existing **State** objects in memory.
- Hot restart resets to 10 because it destroys all existing **State** objects and reconstructs fresh **widget** and **State** instances.

---

### Step 7
**Q: Before the fix, you tapped three times. What was the value of `_clicks` inside the State, and what did the screen show?**  
**Ans:** `_clicks` in State was **12**, but the screen showed **0** because `setState()` was omitted and `build()` was never triggered.

---

### Step 8
**Q: What error appears in the console if you delete the `_timer.cancel()` from `dispose` and the widget is removed?**  
**Ans:** `FlutterError: setState() called after dispose()`.

---

### Step 9
**Q: Why does it increase by one per second and not by two? Where could you print `lifecycleLog` to prove that `dispose` ran?**  
**Ans:** It increases by 1 because `Timer.periodic` fires once every second, calling `setState()` once. `lifecycleLog` can be printed inside `dispose()` or from a parent widget after `Countdown` is unmounted.

  