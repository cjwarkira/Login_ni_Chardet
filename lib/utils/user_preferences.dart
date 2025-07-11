class UserPreferences {
  static const String _keyRememberMe = 'remember_me';
  static const String _keyUserEmail = 'user_email';

  // In a real app, you would use SharedPreferences
  static final Map<String, dynamic> _prefs = {};

  static bool getRememberMe() {
    return _prefs[_keyRememberMe] ?? false;
  }

  static void setRememberMe(bool value) {
    _prefs[_keyRememberMe] = value;
  }

  static String? getSavedEmail() {
    return _prefs[_keyUserEmail];
  }

  static void setSavedEmail(String email) {
    _prefs[_keyUserEmail] = email;
  }

  static void clearUserData() {
    _prefs.clear();
  }
}
