# Firebase Authentication Setup Guide

This guide will walk you through setting up Firebase Authentication for your Flutter app step by step.

## Prerequisites

- Flutter SDK installed
- A Google account
- Firebase project (we'll create this in Step 1)

## Step 1: Create a Firebase Project

1. Go to the [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter your project name (e.g., "login-ni-chardet")
4. Enable Google Analytics (optional but recommended)
5. Click "Create project"

## Step 2: Configure Firebase for Your Platforms

### For Android:

1. In the Firebase Console, click on "Android" icon
2. Enter your Android package name: `com.example.login_ni_chardet` (or your actual package name)
3. Download the `google-services.json` file
4. Place it in `android/app/` directory
5. Add the following to `android/build.gradle` (project-level):
   ```gradle
   dependencies {
       classpath 'com.google.gms:google-services:4.4.0'
   }
   ```
6. Add the following to `android/app/build.gradle`:
   ```gradle
   apply plugin: 'com.google.gms.google-services'
   
   dependencies {
       implementation 'com.google.firebase:firebase-auth'
       implementation 'com.google.firebase:firebase-firestore'
   }
   ```

### For iOS:

1. In the Firebase Console, click on "iOS" icon
2. Enter your iOS bundle ID: `com.example.loginNiChardet`
3. Download the `GoogleService-Info.plist` file
4. Open `ios/Runner.xcworkspace` in Xcode
5. Drag the `GoogleService-Info.plist` file into the Runner project
6. Make sure "Copy items if needed" is checked
7. Select the Runner target

### For Web:

1. In the Firebase Console, click on "Web" icon
2. Enter an app nickname
3. Copy the Firebase config object
4. We'll use this config in Step 4

## Step 3: Install FlutterFire CLI (Recommended)

The FlutterFire CLI makes configuration much easier:

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase for your project
flutterfire configure
```

This will automatically generate the `firebase_options.dart` file with the correct configuration.

## Step 4: Manual Configuration (Alternative to Step 3)

If you prefer manual configuration, update `lib/firebase_options.dart` with your actual Firebase configuration values:

```dart
// Replace the placeholder values with your actual Firebase config
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'your-android-api-key',
  appId: 'your-android-app-id',
  messagingSenderId: 'your-messaging-sender-id',
  projectId: 'your-project-id',
  storageBucket: 'your-project-id.appspot.com',
);

// Do the same for other platforms (ios, web, etc.)
```

## Step 5: Enable Authentication Methods

1. In the Firebase Console, go to "Authentication" → "Sign-in method"
2. Enable the sign-in methods you want to use:
   - **Email/Password**: Enable this for basic email authentication
   - **Google**: Enable and configure OAuth consent screen
   - **Apple**: Enable for iOS apps (requires Apple Developer account)
   - **Facebook**: Enable and add Facebook App ID and App Secret

## Step 6: Configure Firestore Database (Optional)

1. In the Firebase Console, go to "Firestore Database"
2. Click "Create database"
3. Choose "Start in test mode" for development
4. Select a location close to your users
5. The app will automatically create user documents in the `users` collection

## Step 7: Set Up Security Rules

### Firestore Security Rules:
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### Firebase Storage Rules (if using):
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## Step 8: Test Your Setup

1. Run your Flutter app:
   ```bash
   flutter run
   ```

2. Try the following test scenarios:
   - Create a new account with email/password
   - Sign in with existing credentials
   - Test password reset functionality
   - Test social login (if configured)
   - Test logout functionality

## Step 9: Production Considerations

### Security:
- Update Firestore security rules for production
- Enable App Check for additional security
- Use Firebase App Distribution for beta testing

### Performance:
- Enable offline persistence for Firestore
- Implement proper error handling
- Add loading states for better UX

### Monitoring:
- Enable Firebase Crashlytics
- Set up Firebase Performance Monitoring
- Configure Firebase Analytics

## Troubleshooting

### Common Issues:

1. **"No Firebase App" Error**:
   - Ensure Firebase is initialized in `main()` before `runApp()`
   - Check that `firebase_options.dart` has correct configuration

2. **Android Build Errors**:
   - Ensure `google-services.json` is in the correct location
   - Check that Gradle plugins are added correctly
   - Update Gradle and Android SDK if needed

3. **iOS Build Errors**:
   - Ensure `GoogleService-Info.plist` is added to the Xcode project
   - Check iOS deployment target (minimum iOS 11.0)
   - Update CocoaPods if needed

4. **Authentication Errors**:
   - Check that the sign-in method is enabled in Firebase Console
   - Verify API keys and configuration
   - Check network connectivity

### Getting Help:

- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Support](https://firebase.google.com/support)

## Next Steps

After Firebase is set up and working:

1. **Add Social Login**: Implement Google, Apple, and Facebook sign-in
2. **User Profiles**: Add user profile management
3. **Email Verification**: Implement email verification for new accounts
4. **Multi-factor Authentication**: Add extra security layers
5. **Custom Claims**: Implement role-based access control
6. **Cloud Functions**: Add server-side logic for advanced features

## Sample Firebase Console Screenshots

[Include screenshots of key steps for visual guidance]

---

**Important**: Keep your Firebase configuration files secure and never commit sensitive API keys to version control in production apps.
