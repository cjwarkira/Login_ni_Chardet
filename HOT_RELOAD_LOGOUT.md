# Hot Reload Logout Feature

## What This Does
When you perform a hot reload or hot restart in debug mode, the app will automatically sign out the current user and return to the login screen. This is specifically designed for development testing.

## How It Works

### Automatic Logout on App Start (Debug Mode Only)
- Every time the app starts in debug mode, it automatically signs out any logged-in user
- This happens in `main.dart` using `DevAuthHelper.handleDevSignOut()`
- You'll see a debug message in the console: "DEV: Auto-signed out user [email] for testing"

### Manual Dev Logout Button
On the home screen (debug mode only), you'll see two additional buttons:
1. **Bug Report Icon** - Prints current auth state to console
2. **Orange Logout Icon** - Manually triggers development logout

## Testing the Feature

### Method 1: Hot Reload/Restart
1. Login to your app
2. You should be on the home screen
3. Press `r` in terminal (hot reload) or `R` (hot restart)
4. The app should automatically return to login screen

### Method 2: Manual Dev Logout
1. Login to your app
2. On the home screen, tap the orange logout icon (debug mode only)
3. You'll see a notification and be returned to login screen

## Production Behavior
- In production builds (`flutter build apk --release`), this feature is disabled
- Users will stay logged in normally across app restarts
- The debug buttons won't appear in production

## Console Output
You'll see debug messages like:
```
DEV: Auto-signed out user test@example.com for testing
DEBUG: Signed out user for development testing
AUTH EVENT: Login attempt - test@example.com
AUTH EVENT: Login successful - test@example.com
```

## Disabling This Feature
To disable the automatic logout during development, comment out this line in `main.dart`:
```dart
// await DevAuthHelper.handleDevSignOut();
```

This feature makes it much easier to test the login flow repeatedly during development!
