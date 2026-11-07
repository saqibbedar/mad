# Dart Null Safety and Variable Initialization

In Dart, a variable must have a value before you read it, or its type must allow `null`. Here's how Dart enforces this rule.

## 1. Non-nullable types

By default, types are non-nullable. A local variable must be assigned before it is read.

```dart
int age; // Declared, but not initialized.

// print(age);
// Compile-time error: The local variable 'age' must be assigned before it can be used.

age = 25;
print(age);
```

## 2. Nullable types

Add `?` to a type to allow it to hold `null`. A nullable local variable still must be assigned before it is read.

```dart
int? points;
points = null;

print(points); // Prints: null

// print(points + 5);
// Compile-time error: Check for null before using points as an int.
```

## 3. The `late` keyword

Use `late` when you intend to initialize a variable before reading it, but Dart cannot verify that at compile time. If you read it before initialization, a runtime error occurs.

```dart
late String username;

void login() {
  username = 'Alice';
}

void welcome() {
  print(username); // Runtime error if login() has not initialized username.
}
```

## Summary

- **Non-nullable:** Assign a value before reading the variable.
- **Nullable (`?`):** The type allows `null`; check for `null` before using it as a non-null value.
- **`late`:** Defers initialization, so reading the variable too early can cause a runtime error.

These rules also apply when working with Flutter widgets, such as initializing state in `initState` or handling API data.
