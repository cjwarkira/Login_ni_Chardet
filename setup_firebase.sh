#!/bin/bash

# Firebase Quick Setup Script for Flutter
# This script helps you quickly set up Firebase for your Flutter project

echo "🔥 Firebase Setup Script for Flutter 🔥"
echo "======================================="

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    exit 1
fi

echo "✅ Flutter is installed"

# Check if FlutterFire CLI is installed
if ! command -v flutterfire &> /dev/null; then
    echo "📦 Installing FlutterFire CLI..."
    dart pub global activate flutterfire_cli
else
    echo "✅ FlutterFire CLI is already installed"
fi

# Run Flutter pub get to ensure dependencies are installed
echo "📦 Installing dependencies..."
flutter pub get

# Configure Firebase
echo "🔧 Configuring Firebase..."
echo "This will open a browser window to select your Firebase project"
echo "Make sure you have created a Firebase project at https://console.firebase.google.com"
read -p "Press Enter to continue..."

flutterfire configure

echo ""
echo "✅ Firebase configuration complete!"
echo ""
echo "Next steps:"
echo "1. Enable Authentication methods in Firebase Console:"
echo "   - Go to https://console.firebase.google.com"
echo "   - Select your project"
echo "   - Go to Authentication > Sign-in method"
echo "   - Enable Email/Password and any social providers you want"
echo ""
echo "2. (Optional) Set up Firestore Database:"
echo "   - Go to Firestore Database in Firebase Console"
echo "   - Create database in test mode"
echo ""
echo "3. Test your app:"
echo "   flutter run"
echo ""
echo "📚 For detailed setup instructions, see FIREBASE_SETUP.md"
