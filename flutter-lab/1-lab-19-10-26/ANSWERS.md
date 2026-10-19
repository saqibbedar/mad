# Lab Answers

### Step 1

**Q**: What is the difference between what runApp receives and what MaterialApp receives as home?

**Ans**: runApp() takes the root widget of the entire application tree and attaches it to the Flutter engine/window for rendering. In contrast, MaterialApps home property receives the primary screen/route widget (e.g., HomePage) that serves as the default top-level page of the application UI.

---

### Step 2

**Q: Why are the fields of a `StatelessWidget` `final`? What would the compiler say if you removed `final`?**

**Ans:** Flutter widgets are immutable blueprints that describe the UI at a specific moment. A `StatelessWidget` does not maintain any mutable state across rebuilds; once created, its properties should not change. If `final` is removed:
1. The analyzer triggers the `must_be_immutable` warning: *"This class is marked as '@immutable', but one or more of its instance fields aren't final."*
2. A constructor cannot be `const` if any instance field is non-final (*"Can't define a const constructor for a class with non-final fields"*).

---

### Step 3

**Q: Draw the widget tree of your screen on paper, from `LabApp` down to the three `Text` widgets. How many levels deep is the `Text('Max: ..')`?**  
**Ans:** It is **8 levels deep** (7 steps down from the root):
```text
1. LabApp
└── 2. MaterialApp
    └── 3. HomePage
        └── 4. Scaffold
            └── 5. SingleChildScrollView
                └── 6. Column
                    └── 7. Row
                        └── 8. Text('Max: $maxCount')
```

---

### Step 4

**Q: Why does `GoalBanner` not need `setState`? What would you have to do to make it show a new count?**

**Ans:** `GoalBanner` is a `StatelessWidget` whose job is solely to render whatever properties (`count`, `max`) it receives from its parent. It does not store or manage state. To show an updated count, a parent `StatefulWidget` must modify its state variable inside `setState()`, which rebuilds the parent and passes the new count value down into `GoalBanner`.

---

### Step 5

**Q: The class `Tally` has no fields that change, yet `_TallyState` does. Why are there two classes?**  

**Ans:** Flutter separates immutable UI configuration from mutable state lifecycle. The `Tally` widget is an immutable configuration blueprint that Flutter can create, throw away, and rebuild at low cost. The `_TallyState` object persists in memory across widget rebuilds, maintaining the active state (`_count`) and surviving rebuilds of the parent widget tree.

---

### Step 6

**Q: Hot reload while the count is 12. Does it stay 12? Now do a hot restart. Explain the difference using the words widget and State.**  

**Ans:**
- **Hot Reload:** The count stays 12. Hot reload updates widget definitions and triggers a rebuild while **preserving existing State instances** in memory. Because `_count` is stored in the `State` object (`_TallyState`), it is maintained.
- **Hot Restart:** The count resets to `startCount` (10). Hot restart destroys and cleans up all existing **State** objects and rebuilds the entire **widget** hierarchy from scratch, re-initializing all state variables.

---

### Step 7

**Q: Before the fix, you tapped three times. What was the value of `_clicks` inside the State, and what did the screen show?**  

**Ans:** 
- Value of `_clicks` inside State: **12** (since `bugStep = 4`, 3 taps × 4 = 12)
- Value shown on screen: **0** (`Bug clicks: 0`) because `build()` is only triggered when `setState()` tells the framework the state has changed.

*(Note for final wrap-up: **A3: 12**)*