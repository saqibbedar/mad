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