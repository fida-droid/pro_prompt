# Pro Prompt - AdMob Integration Guide

This guide explains how to integrate real Google AdMob ads into the Pro Prompt app.

## Prerequisites
1. **AdMob Account**: Create an account at [admob.google.com](https://admob.google.com).
2. **App Registration**: Register your Android app in the AdMob dashboard.

## Step-by-Step Integration

### 1. Get Your Ad Unit IDs
In your AdMob dashboard, create three ad units:
- **Banner Ad**: For the bottom of the home screen.
- **Interstitial Ad**: For the copy button click event.
- **Rewarded Ad**: For unlocking premium prompts.

### 2. Update Android Manifest
Open `android/app/src/main/AndroidManifest.xml` and add your **AdMob App ID** inside the `<application>` tag:
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy"/>
```
*Replace `ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy` with your actual App ID.*

### 3. Update AdService.dart
Open `lib/services/ad_service.dart` and replace the test IDs with your real Ad Unit IDs:
```dart
static String get bannerAdUnitId => Platform.isAndroid
    ? 'ca-app-pub-xxxxxxxxxxxxxxxx/zzzzzzzzzz' // Your Real Banner ID
    : '...';

static String get interstitialAdUnitId => Platform.isAndroid
    ? 'ca-app-pub-xxxxxxxxxxxxxxxx/aaaaaaaaaa' // Your Real Interstitial ID
    : '...';

static String get rewardedAdUnitId => Platform.isAndroid
    ? 'ca-app-pub-xxxxxxxxxxxxxxxx/bbbbbbbbbb' // Your Real Rewarded ID
    : '...';
```

### 4. Test Before Release
Always use **Test IDs** during development to avoid account suspension. Only switch to real IDs when you are ready to publish the app to the Google Play Store.

### 5. App-ads.txt
Don't forget to set up your `app-ads.txt` file on your developer website to ensure your ad revenue is not impacted.
