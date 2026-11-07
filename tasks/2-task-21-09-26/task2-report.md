# Task 2 Report: Course Roster Console App

**Name:** Muhammad Saqib (04072313037)
**Lab:** Lab 1 - Dart Fundamentals

## Completed Parts

I have successfully completed the following sections of the lab [task](Week_2_Dart_Fundamentals_Course_Roster_Console_App%20(1).pdf):

* Part 1: Setup & Welcome
* Part 2: Course & Roster Data
* Part 3: Null-Safe Instructor Info
* Part 4: Formatting Strings
* Part 5: Operators in Action
* Part 6: Enrollment Logic
* Part 7: Reports & Loops
* Part 8: Optional (not completed)

## Dart Analyze Output

```text
Analyzing course_roster.dart...
No issues found!
```

## Console Outputs

```txt
=== Course Roster Manager ===
CS201: Mobile App Development | Capacity: 4 | Enrolled: 3
TBA
Enrollment code: CS101
Instructor email length: null
This course covers Dart fundamentals.
It includes types, control flow, and null safety.

Seats left: 1
Full groups of 3: 1, leftover: 0
This is text!
Report: CS201: Mobile App Development | Cap: 4 | Roster: 3
Extra notes: null
Bonus seats: 0
You're in! Welcome aboard.
Enrolled
OPEN
Aiden
Maria
Jamal
Aiden: 3
Maria: 4
Jamal: 2
Welcome to CS201: Mobile App Development
Reminder: Priya, please confirm attendance
Reminder: Noah, please confirm attendance
```

## Extras

```bash
saqibbedar@saqibbedar:~/Desktop/mad/tasks/2-task-21-09-26$ dart format course_roster.dart 
# Output: Formatted 1 file (0 changed) in 0.01 seconds.

saqibbedar@saqibbedar:~/Desktop/mad/tasks/2-task-21-09-26$ dart analyze course_roster.dart 

# Output:
# Analyzing course_roster.dart...        0.1s

# warning • course_roster.dart:9:18 • The value of the local variable 'createdAt' isn't used.
#           Try removing the variable or using it. • unused_local_variable
# warning • course_roster.dart:12:10 • The value of the local variable 'creditHours' isn't
#           used. Try removing the variable or using it. • unused_local_variable
# warning • course_roster.dart:31:52 • Dead code. Try removing the code, or fixing the code
#           before it so that it can be reached. • dead_code
# warning • course_roster.dart:69:13 • Dead code. Try removing the code, or fixing the code
#           before it so that it can be reached. • dead_code
# warning • course_roster.dart:96:40 • Dead code. Try removing the code, or fixing the code
#           before it so that it can be reached. • dead_code
# warning • course_roster.dart:110:18 • Dead code. Try removing the code, or fixing the code
#           before it so that it can be reached. • dead_code

# 6 issues found.
```