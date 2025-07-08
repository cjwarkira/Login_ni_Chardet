# Firebase Quick Setup Script for Flutter (PowerShell)
# This script helps you quickly set up Firebase for your Flutter project

Write-Host "🔥 Firebase Setup Script for Flutter 🔥" -ForegroundColor Yellow
Write-Host "=======================================" -ForegroundColor Yellow

# Check if Flutter is installed
try {
    flutter --version | Out-Null
    Write-Host "✅ Flutter is installed" -ForegroundColor Green
} catch {
    Write-Host "❌ Flutter is not installed or not in PATH" -ForegroundColor Red
    exit 1
}

# Check if FlutterFire CLI is installed
try {
    flutterfire --version | Out-Null
    Write-Host "✅ FlutterFire CLI is already installed" -ForegroundColor Green
} catch {
    Write-Host "📦 Installing FlutterFire CLI..." -ForegroundColor Blue
    dart pub global activate flutterfire_cli
}

# Run Flutter pub get to ensure dependencies are installed
Write-Host "📦 Installing dependencies..." -ForegroundColor Blue
flutter pub get

# Configure Firebase
Write-Host "🔧 Configuring Firebase..." -ForegroundColor Blue
Write-Host "This will open a browser window to select your Firebase project" -ForegroundColor Yellow
Write-Host "Make sure you have created a Firebase project at https://console.firebase.google.com" -ForegroundColor Yellow
Read-Host "Press Enter to continue..."

flutterfire configure

Write-Host ""
Write-Host "✅ Firebase configuration complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Enable Authentication methods in Firebase Console:"
Write-Host "   - Go to https://console.firebase.google.com"
Write-Host "   - Select your project"
Write-Host "   - Go to Authentication > Sign-in method"
Write-Host "   - Enable Email/Password and any social providers you want"
Write-Host ""
Write-Host "2. (Optional) Set up Firestore Database:"
Write-Host "   - Go to Firestore Database in Firebase Console"
Write-Host "   - Create database in test mode"
Write-Host ""
Write-Host "3. Test your app:"
Write-Host "   flutter run"
Write-Host ""
Write-Host "📚 For detailed setup instructions, see FIREBASE_SETUP.md" -ForegroundColor Cyan
