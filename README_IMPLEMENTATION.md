# Login Screen Implementation

This Flutter app implements a real estate login screen based on the Figma design provided.

## Assets Setup

### Background Image
You need to add a background image to the project:

1. **Location**: Place your background image in `assets/images/` directory
2. **Filename**: Name it `background.jpg` (or update the path in `login_screen.dart` if using a different name)
3. **Recommended**: Use a high-quality building/real estate image that matches the Figma design

### Icons (Optional)
You can also add custom icons to `assets/icons/` directory if you want to replace the default Material icons used for social login buttons.

## Design Features Implemented

✅ **Colors from Figma Design:**
- Primary Green: `#0ACF83`
- Dark Background: `#111110`
- Light Grey: `#D8D8DD`
- Medium Grey: `#A09F99`
- Dark Grey: `#484848`
- White: `#FFFFFF`

✅ **UI Components:**
- Background image with gradient overlay
- Email and password input fields
- Remember me toggle switch
- Forgot password link
- Primary login button
- Social login buttons (Google, Apple, Facebook)
- Sign up link
- Bottom indicator bar

✅ **Typography:**
- Lato font family for most text
- Roboto font for sign-up text
- Proper font weights and sizes

✅ **Interactive Elements:**
- Password visibility toggle
- Remember me switch animation
- Clickable buttons and links

## Running the App

1. Ensure you have Flutter installed
2. Add your background image to `assets/images/background.jpg`
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the app

## Customization

### Changing the Background Image
Update line 33 in `lib/screens/login_screen.dart`:
```dart
image: AssetImage('assets/images/your_image_name.jpg'),
```

### Adding Custom Fonts
If you want to use the exact Lato and Roboto fonts from Google Fonts, add them to `pubspec.yaml` in the fonts section.

### Social Login Integration
The social login buttons are ready for integration. Add your authentication logic in the respective `onPressed` callbacks in `login_screen.dart`.

## File Structure
```
lib/
├── main.dart              # App entry point
└── screens/
    └── login_screen.dart  # Login screen implementation

assets/
├── images/
│   └── background.jpg     # Background image (add this)
└── icons/
    └── (custom icons)     # Optional custom icons
```
