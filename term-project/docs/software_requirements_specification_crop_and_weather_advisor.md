# Software Requirements Specification (SRS)

## Project: Crop and Weather Advisor (Mobile Application)

**Team Members:** Fatima Anam, Muqaddas Sabir, Saqib Bedar

---

## 1. System Overview & Architectural Baseline

**Crop and Weather Advisor** is an offline-first mobile application built using **Flutter** and **Firebase**, integrated with the **Open-Meteo REST API** and native smartphone hardware (**GPS** and **Camera**). The application empowers small-scale, low-literacy farmers with hyper-local weather forecasts, plain-language agricultural advice, a stage-based crop calendar, and a visual photo log of field/crop problems.

Because rural farming areas frequently experience weak or intermittent mobile data connectivity, the system implements a **Local-First Repository Architecture** coupled with a **Low-Literacy Visual Interface**:

* **Local Data Store:** SQLite (via `sqflite` or `drift`) and local device storage act as the primary source of truth for the UI, guaranteeing instant reads/writes and full offline continuity.
* **Cloud Data Store:** **Firebase Authentication** manages friction-free user sessions, **Cloud Firestore** synchronizes farm profiles, crop calendars, and problem metadata, and **Firebase Storage** backs up compressed crop problem photos asynchronously.
* **External Weather API:** **Open-Meteo Forecast API** (`https://api.open-meteo.com/v1/forecast`) supplies real-time and 7-day weather forecasts without requiring API keys.
* **Low-Literacy UX Baseline:** All screens prioritize large, unmistakable icons, short Right-to-Left (RTL) **Urdu** text labels, high-contrast outdoor readability, and a maximum of 2–3 taps per core task.

---

## 2. Functional Requirements

Requirements are prioritized using the MoSCoW scale: **M** (Must Have), **S** (Should Have), and **C** (Could Have).

### 2.1 Low-Literacy Onboarding & Authentication (Firebase Auth)

* **FR-1.1 (M) – Zero-Friction Guest Launch:** The system shall automatically sign users in via **Firebase Anonymous Authentication** on first launch so farmers can use the app immediately without typing emails or passwords.
* **FR-1.2 (S) – Optional Account Linking:** The system shall allow users to link their anonymous profile to a permanent account via Phone Number (OTP) or Google Sign-In so their crop calendar and photo logs can be restored across devices.
* **FR-1.3 (M) – Visual-First Urdu Interface:** The system shall render all navigation labels, weather alerts, and action buttons using large, recognizable icons paired with concise Urdu text (`2` to `5` words per label) in an RTL layout.

### 2.2 Farm Location Management (GPS Hardware & Fallback)

* **FR-2.1 (M) – One-Tap GPS Farm Pinning:** The system shall access the device's **GPS sensor** (`geolocator`) to capture the farm's latitude and longitude coordinates with a single tap.
* **FR-2.2 (M) – Manual District/Tehsil Fallback:** If GPS permission is denied or satellite lock fails, the system shall allow the farmer to pick their district/tehsil from a pre-bundled offline list of agricultural regions with preset coordinates.
* **FR-2.3 (M) – Persistent Location Sync:** The system shall cache the selected farm coordinates locally in SQLite and sync them to `/users/{userId}` in Cloud Firestore.

### 2.3 Weather Forecast & Plain-Language Farming Advice (Open-Meteo API)

* **FR-3.1 (M) – Today's Weather Dashboard:** Using the farm's coordinates, the system shall query the **Open-Meteo API** for current temperature, daily high/low temperatures, rainfall probability, precipitation volume, humidity, and wind speed.
* **FR-3.2 (M) – Rule-Based Urdu Farming Advice:** The system shall translate raw Open-Meteo metrics into simple, color-coded Urdu advisory cards using deterministic agronomic rules, such as:
  * High rain probability ($\ge 60\%$): *"آج بارش کا امکان ہے، آبپاشی روک دیں"* (Rain expected today; delay irrigation).
  * High wind speed ($\ge 20\text{ km/h}$): *"تیز ہوا چلے گی، سپرے نہ کریں"* (Strong winds; avoid spraying).
  * Extreme heat ($\ge 40^\circ\text{C}$): *"شدید گرمی ہے، فصل کو پانی دیں"* (Extreme heat; irrigate crops).
* **FR-3.3 (M) – 7-Day Visual Forecast:** The system shall display a 7-day daily weather outlook using large weather pictograms, temperature ranges, and rain drop indicators.
* **FR-3.4 (M) – Offline Forecast Caching:** The system shall cache the most recent Open-Meteo API response locally with a `lastUpdated` timestamp so farmers can view weather data offline alongside a clear indicator showing when it was last refreshed.

### 2.4 Crop Calendar & Growth Tracking

* **FR-4.1 (M) – Visual Crop Selection:** The system shall allow farmers to add active crops (e.g., Wheat / گندم, Cotton / کپاس, Rice / چاول, Maize / مکئی, Sugarcane / گنا) by tapping a large crop icon and selecting an approximate sowing date.
* **FR-4.2 (M) – Automated Growth Stage Calculation:** Based on the sowing date and a local crop-lifecycle reference table, the system shall calculate and display the crop's current stage (e.g., Sowing / بوائی, Growth / بڑھوتری, Flowering / پھول آنا, Harvest / کٹائی).
* **FR-4.3 (M) – Non-Chemical Milestone Prompts:** The system shall display upcoming general care milestones (e.g., irrigation timing, weeding, field inspection, harvest preparation) using simple icons and short Urdu prompts.
* **FR-4.4 (S) – Local Milestone Notifications:** The system shall schedule local device notifications (`flutter_local_notifications`) for upcoming irrigation or harvest milestones without needing internet access.

### 2.5 Crop Problem Photo Log (Camera Hardware & Cloud Backup)

* **FR-5.1 (M) – Quick Camera Capture:** The system shall allow farmers to open the device's rear **Camera** within 1–2 taps from the Home screen or Problem Log screen to photograph affected leaves, stems, pests, or soil.
* **FR-5.2 (M) – One-Tap Visual Problem Tagging:** After capturing a photo, the system shall prompt the farmer to select a problem category via large visual icons—such as Yellow Leaves (پتے پیلے ہونا), Insects/Pests (کیڑے مکوڑے), Wilting/Dryness (مرجھانا), Leaf Spots (دھبے), or Other (دیگر)—with an optional short voice/text note.
* **FR-5.3 (M) – Problem Log History List:** The system shall display all logged problems in a chronological card feed showing the photo thumbnail, crop icon, problem category, date logged, and cloud sync status icon.
* **FR-5.4 (M) – Problem Detail & Recorded Context:** Tapping any logged entry shall open a detail view displaying the full photo, the weather conditions recorded on that date, general preventive field hygiene tips, and a prominent button/prompt to consult a local agriculture extension officer.

### 2.6 Domain Safety & Content Guardrails

* **FR-6.1 (M) – Strict Prohibition of Chemical Dosage & Medical Advice:** The system shall **never** recommend specific pesticide/herbicide brands, chemical formulations, dosage measurements, mixing ratios, or medical/veterinary treatments.
* **FR-6.2 (M) – Mandatory Extension Officer Disclaimer:** All weather advisories and problem detail screens shall include a concise Urdu notice advising the farmer to consult a certified local agricultural expert (*زرعی ماہر سے مشورہ کریں*) before applying any chemical inputs.

### 2.7 Offline-First Cloud Synchronization (Firebase)

* **FR-7.1 (M) – Local Persistence & Sync Queue:** Every new crop entry or problem photo log shall save immediately to SQLite and local storage with a `syncStatus` flag (`PENDING` or `SYNCED`).
* **FR-7.2 (M) – Background Firestore & Storage Sync:** When internet connectivity is detected (`connectivity_plus`), the system shall automatically upload compressed photos to **Firebase Storage** and sync structured crop/log documents to **Cloud Firestore** (`/users/{uid}/crops` and `/users/{uid}/problem_logs`).

---

## 3. Non-Functional Requirements

### 3.1 Low-Literacy Usability & Accessibility

* **NFR-1.1 – Minimal Task Depth:** Core loop actions (checking today's weather/advice and logging a crop problem photo) shall require $\le 3$ taps from the Home screen.
* **NFR-1.2 – Touch Target & Typography Sizing:** Interactive buttons and category cards shall maintain a minimum touch area of $56 \times 56\text{ dp}$, high-contrast colors for outdoor sunlight visibility, and large Urdu typography ($\ge 18\text{ sp}$ body text, $\ge 22\text{ sp}$ headings).
* **NFR-1.3 – Dual-Cue Visual Encoding:** Every system state (sync status, weather severity, crop growth stage) shall pair color coding with distinct icons and short Urdu text labels.

### 3.2 Offline Reliability & Data Efficiency

* **NFR-2.1 – Zero-Connectivity Core Operation:** Viewing cached weather, managing the crop calendar, and capturing/saving crop problem photos shall operate with $100\%$ functionality offline.
* **NFR-2.2 – Rural Bandwidth Optimization:** Captured problem photos shall be automatically compressed to $\le 500\text{ KB}$ JPEG files before queuing for Firebase Storage upload.

### 3.3 Performance

* **NFR-3.1 – Fast Application Startup:** The app shall render the interactive Home screen with cached weather and primary action icons within $2.0\text{ seconds}$ on entry-level Android devices (API 24+).
* **NFR-3.2 – Graceful API Timeouts:** Open-Meteo API calls shall enforce an $8\text{-second}$ timeout, seamlessly displaying cached data or a clear visual retry state if the network is unreachable.

### 3.4 Security, Privacy & API Compliance

* **NFR-4.1 – Tenant Data Isolation:** Firebase Firestore and Storage Security Rules shall strictly enforce user-level isolation so authenticated users can only read and write data under `/users/{request.auth.uid}/**`.
* **NFR-4.2 – Contextual Hardware Permissions:** `ACCESS_FINE_LOCATION` and `CAMERA` permissions shall be requested only when the user initiates farm pinning or photo logging, degrading gracefully to manual district selection or gallery/note entry if denied.
* **NFR-4.3 – Open-Meteo Fair Use & Attribution:** Weather responses shall be cached locally for at least $3\text{ hours}$ per farm coordinate pair, and Open-Meteo attribution shall be displayed on the App Info/Help screen.

---

## 4. Screen & Architecture Mapping (Wireframe Reference)

To support UI wireframing and Flutter route planning, the functional requirements above map directly to **9 distinct screens**:

| # | Screen Name | One-Line Purpose | Hardware / Firebase / API |
| :--- | :--- | :--- | :--- |
| **1** | **Onboarding & Sign-In** | Introduces the app with visual icons and starts a guest or linked session. | **Firebase Auth** (Anonymous / Phone) |
| **2** | **Farm Location Setup** | Pins the farmer's field via GPS or selects a district from an offline list. | **Hardware (GPS)**, **Firebase Firestore** |
| **3** | **Home (Weather & Advice)** *(Main Screen)* | Displays today's weather, simple Urdu farming advice, and quick-action buttons *(drawn in Loading, Empty, Error, and Data states)*. | **Open-Meteo API**, **Firebase Firestore** |
| **4** | **7-Day Forecast** | Shows a 7-day visual daily weather forecast with rain and temperature icons. | **Open-Meteo API** (Local Cache) |
| **5** | **Crop Calendar** | Lists the farmer's active crops, current growth stage, and upcoming care tasks. | **Firebase Firestore** (Local-First) |
| **6** | **Add Crop** | Lets the farmer pick a crop icon and sowing date to add to their calendar. | **Firebase Firestore** |
| **7** | **Problem Photo Log** | Displays a visual history of logged crop problems with sync status badges. | **Firebase Firestore & Storage** |
| **8** | **Log Crop Problem** | Captures a crop photo via camera and tags the problem using large category icons. | **Hardware (Camera)**, **Firebase Storage** |
| **9** | **Problem Detail & Guidance** | Shows the full photo, recorded weather, safe general tips, and expert referral notice. | **Firebase Firestore & Storage** |