// Simple auth service without Firebase dependencies
// This can be easily replaced with actual Firebase implementation later

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Mock user data
  String? _currentUserEmail;
  bool _isLoggedIn = false;

  // Get current user email
  String? get currentUserEmail => _currentUserEmail;

  // Check if user is logged in
  bool get isLoggedIn => _isLoggedIn;

  // Email/Password Sign In
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // For demo purposes, accept any valid email/password combination
      if (email.isNotEmpty && password.length >= 6) {
        _currentUserEmail = email;
        _isLoggedIn = true;
        return true;
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Create User with Email and Password
  Future<bool> createUserWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // For demo purposes, accept any valid email/password combination
      if (email.isNotEmpty && password.length >= 6) {
        _currentUserEmail = email;
        _isLoggedIn = true;
        return true;
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Google Sign In
  Future<bool> signInWithGoogle() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      _currentUserEmail = 'google.user@gmail.com';
      _isLoggedIn = true;
      return true;
    } catch (e) {
      rethrow;
    }
  }

  // Apple Sign In
  Future<bool> signInWithApple() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      _currentUserEmail = 'apple.user@icloud.com';
      _isLoggedIn = true;
      return true;
    } catch (e) {
      rethrow;
    }
  }

  // Facebook Sign In
  Future<bool> signInWithFacebook() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      _currentUserEmail = 'facebook.user@facebook.com';
      _isLoggedIn = true;
      return true;
    } catch (e) {
      rethrow;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      _currentUserEmail = null;
      _isLoggedIn = false;
    } catch (e) {
      rethrow;
    }
  }

  // Send Password Reset Email
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // For demo purposes, always return success for valid emails
      if (email.isNotEmpty && email.contains('@')) {
        return true;
      } else {
        throw Exception('Invalid email address');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Get user data (mock implementation)
  Map<String, dynamic>? getUserData() {
    if (_isLoggedIn && _currentUserEmail != null) {
      return {
        'email': _currentUserEmail,
        'displayName': _currentUserEmail!.split('@')[0],
        'createdAt': DateTime.now().millisecondsSinceEpoch,
        'lastLoginAt': DateTime.now().millisecondsSinceEpoch,
      };
    }
    return null;
  }
}
