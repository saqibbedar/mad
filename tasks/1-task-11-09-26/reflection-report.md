# CS 442 - Week 1 Lab Task

 ## Enhance the Counter App

 **Name:** Muahmmad Saqib\
 **Registration No:** 04072313037

 ### Personal Parameters

 - `myThreshold = 15`
- `mySeedColor = Colors.blue`

 ### Features

 - Increment counter button using the `+` icon
- Reset counter button using the refresh icon
- Reset usage tracker that counts how many times the counter has been reset
- **"You're on a roll!"** message appears when the counter exceeds 15
- Personalized blue app theme
- Student name and registration number displayed in the app
- Counter value updates dynamically using Flutter's `setState()`
- Hot reload demo title displayed in the app bar

 ### Screenshot

 <img width="1363" height="684" alt="image" src="https://github.com/user-attachments/assets/1eb3f2ed-2432-4207-9927-382d8b2a9e5e" />

 ### Reflection

 `setState()` is used whenever a value in the application changes and the user interface needs to be updated. In this app, it is used in both the increment and reset functions. When the increment button is pressed, `_counter` increases by 1 and `setState()` rebuilds the screen so the new counter value is displayed. When the reset button is pressed, `_counter` is set back to 0 and `_resetCount` increases by 1, and `setState()` updates both values on the screen.

 The app also uses a threshold value of `15`. When the counter becomes greater than 15, the **"You're on a roll!"** message is displayed in green. The app uses `Colors.blue` as its seed color to provide a personalized theme. This lab helped demonstrate how Flutter manages changing data and dynamically updates the user interface.
