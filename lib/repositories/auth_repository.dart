import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_auth_service.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;
  User? get currentUser;
  bool get isLoggedIn;
  
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password);
  Future<UserCredential?> createUserWithEmailAndPassword(String email, String password, String displayName);
  Future<UserCredential?> signInWithGoogle();
  Future<UserCredential?> signInWithApple();
  Future<UserCredential?> signInWithFacebook();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
}

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuthService _authService;

  FirebaseAuthRepository({FirebaseAuthService? authService})
      : _authService = authService ?? FirebaseAuthService();

  @override
  Stream<User?> get authStateChanges => _authService.authStateChanges;

  @override
  User? get currentUser => _authService.currentUser;

  @override
  bool get isLoggedIn => _authService.isLoggedIn;

  @override
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) {
    return _authService.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<UserCredential?> createUserWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) {
    return _authService.createUserWithEmailAndPassword(email, password, displayName);
  }

  @override
  Future<UserCredential?> signInWithGoogle() {
    return _authService.signInWithGoogle();
  }

  @override
  Future<UserCredential?> signInWithApple() {
    return _authService.signInWithApple();
  }

  @override
  Future<UserCredential?> signInWithFacebook() {
    return _authService.signInWithFacebook();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _authService.sendPasswordResetEmail(email);
  }

  @override
  Future<void> signOut() {
    return _authService.signOut();
  }
}
