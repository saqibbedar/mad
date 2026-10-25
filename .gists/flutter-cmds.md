# Basic flutter commands

```bash
# verify flutter version
flutter --version

# list all available devices
flutter devices

# Initialize the framework: check status of your env
flutter doctor

# create a project
flutter create --project-name <project-name> .

# Run project as a web server
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080

# Run using chrome (default)
flutter run -d chrome -t ../main.dart
```