import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  late StreamSubscription<User?> _authStreamSubscription;

  AuthBloc({AuthRepository? authRepository})
      : _authRepository = authRepository ?? FirebaseAuthRepository(),
        super(AuthInitial()) {
    
    // Listen to authentication state changes
    _authStreamSubscription = _authRepository.authStateChanges.listen(
      (user) => add(AuthUserChanged(user: user)),
    );

    // Register event handlers
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthSignInRequested>(_onAuthSignInRequested);
    on<AuthSignUpRequested>(_onAuthSignUpRequested);
    on<AuthGoogleSignInRequested>(_onAuthGoogleSignInRequested);
    on<AuthAppleSignInRequested>(_onAuthAppleSignInRequested);
    on<AuthFacebookSignInRequested>(_onAuthFacebookSignInRequested);
    on<AuthPasswordResetRequested>(_onAuthPasswordResetRequested);
    on<AuthSignOutRequested>(_onAuthSignOutRequested);
    on<AuthUserChanged>(_onAuthUserChanged);
  }

  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    return super.close();
  }

  // Check current authentication status
  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final user = _authRepository.currentUser;
    if (user != null) {
      emit(AuthAuthenticated(user: user));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  // Handle email/password sign in
  Future<void> _onAuthSignInRequested(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthSigningIn());

    try {
      final userCredential = await _authRepository.signInWithEmailAndPassword(
        event.email,
        event.password,
      );

      if (userCredential?.user != null) {
        emit(AuthAuthenticated(user: userCredential!.user!));
      } else {
        emit(const AuthError(message: 'Sign in failed'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // Handle email/password sign up
  Future<void> _onAuthSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthSigningUp());

    try {
      final userCredential = await _authRepository.createUserWithEmailAndPassword(
        event.email,
        event.password,
        event.displayName,
      );

      if (userCredential?.user != null) {
        emit(AuthAuthenticated(user: userCredential!.user!));
      } else {
        emit(const AuthError(message: 'Sign up failed'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // Handle Google sign in
  Future<void> _onAuthGoogleSignInRequested(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthSigningIn());

    try {
      final userCredential = await _authRepository.signInWithGoogle();

      if (userCredential?.user != null) {
        emit(AuthAuthenticated(user: userCredential!.user!));
      } else {
        // User cancelled the sign-in
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // Handle Apple sign in
  Future<void> _onAuthAppleSignInRequested(
    AuthAppleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthSigningIn());

    try {
      final userCredential = await _authRepository.signInWithApple();

      if (userCredential?.user != null) {
        emit(AuthAuthenticated(user: userCredential!.user!));
      } else {
        emit(const AuthError(message: 'Apple sign in failed'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // Handle Facebook sign in
  Future<void> _onAuthFacebookSignInRequested(
    AuthFacebookSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthSigningIn());

    try {
      final userCredential = await _authRepository.signInWithFacebook();

      if (userCredential?.user != null) {
        emit(AuthAuthenticated(user: userCredential!.user!));
      } else {
        emit(const AuthError(message: 'Facebook sign in failed'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // Handle password reset
  Future<void> _onAuthPasswordResetRequested(
    AuthPasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await _authRepository.sendPasswordResetEmail(event.email);
      emit(AuthPasswordResetSent(email: event.email));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // Handle sign out
  Future<void> _onAuthSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthSigningOut());

    try {
      await _authRepository.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // Handle auth state changes from Firebase
  void _onAuthUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) {
    if (event.user != null) {
      emit(AuthAuthenticated(user: event.user));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
