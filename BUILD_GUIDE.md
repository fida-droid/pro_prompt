# Pro Prompt - APK Build Guide

Follow these steps to build the APK for the Pro Prompt app.

## Prerequisites
1. **Flutter SDK**: Install the latest Flutter SDK from [flutter.dev](https://docs.flutter.dev/get-started/install).
2. **Android Studio**: Install Android Studio and set up the Android SDK.
3. **Java Development Kit (JDK)**: Ensure JDK 11 or higher is installed.

## Step-by-Step Build Instructions

### 1. Clone or Extract Source Code
Extract the provided source code into a folder on your computer.

### 2. Install Dependencies
Open your terminal/command prompt in the project root directory and run:
```bash
flutter pub get
```

### 3. Generate Localization Files
The app uses ARB files for English and Urdu support. Generate the necessary Dart files by running:
```bash
flutter gen-l10n
```

### 4. Configure Android Signing (Optional for Release)
To create a signed release APK:
1. Create a keystore file using `keytool`.
2. Create a `key.properties` file in the `android/` folder with your keystore details.
3. Update `android/app/build.gradle` to use the signing configuration.

### 5. Build the APK
Run the following command to build a release APK:
```bash
flutter build apk --release
```
The generated APK will be located at:
`build/app/outputs/flutter-apk/app-release.apk`

### 6. Install on Device
Connect your Android device via USB (with USB Debugging enabled) and run:
```bash
flutter install
```
Or manually copy the `app-release.apk` to your phone and install it.
