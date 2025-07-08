import 'package:firebase_auth/firebase_auth.dart';
import '../utils/validators.dart';
import '../utils/user_preferences.dart';
import '../services/firebase_auth_service.dart';

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
      throw Exception('Google login not available: ${e.toString()}');
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
