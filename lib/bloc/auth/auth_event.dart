import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

// Check authentication status
class AuthCheckRequested extends AuthEvent {}

// Email/Password authentication
class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String displayName;

  const AuthSignUpRequested({
    required this.email,
    required this.password,
    required this.displayName,
  });

  @override
  List<Object?> get props => [email, password, displayName];
}

// Social authentication
class AuthGoogleSignInRequested extends AuthEvent {}

class AuthAppleSignInRequested extends AuthEvent {}

class AuthFacebookSignInRequested extends AuthEvent {}

// Password reset
class AuthPasswordResetRequested extends AuthEvent {
  final String email;

  const AuthPasswordResetRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

// Sign out
class AuthSignOutRequested extends AuthEvent {}

// Authentication state changed (from Firebase auth stream)
class AuthUserChanged extends AuthEvent {
  final dynamic user; // User? from Firebase

  const AuthUserChanged({required this.user});

  @override
  List<Object?> get props => [user];
}
