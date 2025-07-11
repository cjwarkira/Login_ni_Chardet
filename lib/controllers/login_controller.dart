import '../utils/validators.dart';
import '../utils/user_preferences.dart';
import '../services/firebase_auth_service.dart';
import '../utils/auth_debug.dart';

class LoginController {
  static final LoginController _instance = LoginController._internal();
  factory LoginController() => _instance;
  LoginController._internal();

  final FirebaseAuthService _authService = FirebaseAuthService();

  Future<bool> login(
    String email,
    String password, {
    bool rememberMe = false,
  }) async {
    AuthDebug.logAuthEvent('Login attempt', email);

    // Validate input
    if (!AppValidators.isValidEmail(email)) {
      throw Exception('Invalid email format');
    }

    if (!AppValidators.isValidPassword(password)) {
      throw Exception('Invalid password format');
    }

    try {
      // Use Firebase authentication
      final userCredential = await _authService.signInWithEmailAndPassword(
        email,
        password,
      );

      if (userCredential != null && userCredential.user != null) {
        AuthDebug.logAuthEvent('Login successful', email);
        AuthDebug.printAuthState();

        // Save user preferences if remember me is checked
        if (rememberMe) {
          UserPreferences.setRememberMe(true);
          UserPreferences.setSavedEmail(email);
        } else {
          UserPreferences.setRememberMe(false);
        }

        return true;
      }

      return false;
    } catch (e) {
      AuthDebug.logAuthEvent('Login failed', e.toString());
      // Re-throw the error to be handled by the UI
      throw Exception(e.toString());
    }
  }

  Future<bool> register(
    String email,
    String password,
    String displayName,
  ) async {
    // Validate input
    if (!AppValidators.isValidEmail(email)) {
      throw Exception('Invalid email format');
    }

    if (!AppValidators.isValidPassword(password)) {
      throw Exception('Invalid password format');
    }

    if (displayName.trim().isEmpty) {
      throw Exception('Display name cannot be empty');
    }

    try {
      final userCredential = await _authService.createUserWithEmailAndPassword(
        email,
        password,
        displayName,
      );

      return userCredential != null && userCredential.user != null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> loginWithGoogle() async {
    try {
      final userCredential = await _authService.signInWithGoogle();
      return userCredential != null && userCredential.user != null;
    } catch (e) {
      String errorMessage = e.toString();

      // Don't throw an exception for cancelled sign-in
      if (errorMessage.contains('cancelled')) {
        return false;
      }

      throw Exception('Google login failed: $errorMessage');
    }
  }

  Future<bool> loginWithApple() async {
    try {
      final userCredential = await _authService.signInWithApple();
      return userCredential != null && userCredential.user != null;
    } catch (e) {
      throw Exception('Apple login not available: ${e.toString()}');
    }
  }

  Future<bool> loginWithFacebook() async {
    try {
      final userCredential = await _authService.signInWithFacebook();
      return userCredential != null && userCredential.user != null;
    } catch (e) {
      throw Exception('Facebook login not available: ${e.toString()}');
    }
  }

  Future<bool> forgotPassword(String email) async {
    if (!AppValidators.isValidEmail(email)) {
      throw Exception('Invalid email format');
    }

    try {
      await _authService.sendPasswordResetEmail(email);
      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> logout() async {
    try {
      await _authService.signOut();
      UserPreferences.clearUserData();
      return true;
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }
}
