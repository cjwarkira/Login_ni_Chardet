import 'package:equatable/equatable.dart';

class SignupFormState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final String displayName;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isDisplayNameValid;
  final bool isFormValid;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool acceptTerms;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final String? displayNameError;

  const SignupFormState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.displayName = '',
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isConfirmPasswordValid = false,
    this.isDisplayNameValid = false,
    this.isFormValid = false,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.acceptTerms = false,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.displayNameError,
  });

  SignupFormState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? displayName,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
    bool? isDisplayNameValid,
    bool? isFormValid,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    bool? acceptTerms,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    String? displayNameError,
  }) {
    return SignupFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      displayName: displayName ?? this.displayName,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isDisplayNameValid: isDisplayNameValid ?? this.isDisplayNameValid,
      isFormValid: isFormValid ?? this.isFormValid,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      acceptTerms: acceptTerms ?? this.acceptTerms,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
      displayNameError: displayNameError ?? this.displayNameError,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        confirmPassword,
        displayName,
        isEmailValid,
        isPasswordValid,
        isConfirmPasswordValid,
        isDisplayNameValid,
        isFormValid,
        obscurePassword,
        obscureConfirmPassword,
        acceptTerms,
        emailError,
        passwordError,
        confirmPasswordError,
        displayNameError,
      ];
}
