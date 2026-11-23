# Crop And Weather Advisor | Term Project

**Crop and Weather Advisor** is an offline-first mobile application built using **Flutter** and **Firebase**, integrated with the **Open-Meteo REST API** and native smartphone hardware (**GPS** and **Camera**). The application empowers small-scale, low-literacy farmers with hyper-local weather forecasts, plain-language agricultural advice, a stage-based crop calendar, and a visual photo log of field/crop problems.

# Docs

Please refer to docs for deatiled information on project implementation.

- [**Wireframes**](./docs/Crop_and_Weather_Advisor_Wireframes.pdf)
- [**SRS**](./docs/software_requirements_specification_crop_and_weather_advisor.md)
- [**`/tasks`** directory](./docs/tasks/): All tasks for term project.

# Project Folder Structure

```bash
├── app
│   ├── router.dart                 # routers
│   ├── sample_data.dart            # fake data
│   └── theme.dart                  # theme management
├── main.dart                       # entry point
└── presentation
    ├── screens                     # all screens
    │   └── Home.dart
    └── widgets                     # separate widgets
        └── dummy.dart
```

# Get Started 

```bash
# clone and cd to term-project
git clone https://github.com/saqibbedar/mad.git && cd mad/term-project

# regenerate project
flutter create .

# install dependencies
flutter pub get 

# run app
flutter run -d chrome
```

# Project Metadata

- **Group Members**:
    - **Saqib Bedar**
    - **Muqadas Sabir**
    - **Fatima Anam**

- **Supervised by**:
    - [**Dr. Muddassar Azam Sindhu**](https://cs.qau.edu.pk/profiles/muddassar.htm)