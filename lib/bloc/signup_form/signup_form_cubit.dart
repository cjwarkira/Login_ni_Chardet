import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/validators.dart';
import 'signup_form_state.dart';

class SignupFormCubit extends Cubit<SignupFormState> {
  SignupFormCubit() : super(const SignupFormState());

  void emailChanged(String email) {
    final isValid = AppValidators.isValidEmail(email);
    final error = _getEmailError(email);

    emit(
      state.copyWith(
        email: email,
        isEmailValid: isValid,
        emailError: error,
        isFormValid: _calculateFormValidity(isEmailValid: isValid),
      ),
    );
  }

  void passwordChanged(String password) {
    final isValid = AppValidators.isValidPassword(password);
    final error = _getPasswordError(password);

    // Also validate confirm password when password changes
    final isConfirmPasswordValid = _isConfirmPasswordValid(
      password,
      state.confirmPassword,
    );
    final confirmPasswordError = _getConfirmPasswordError(
      password,
      state.confirmPassword,
    );

    emit(
      state.copyWith(
        password: password,
        isPasswordValid: isValid,
        passwordError: error,
        isConfirmPasswordValid: isConfirmPasswordValid,
        confirmPasswordError: confirmPasswordError,
        isFormValid: _calculateFormValidity(
          isPasswordValid: isValid,
          isConfirmPasswordValid: isConfirmPasswordValid,
        ),
      ),
    );
  }

  void confirmPasswordChanged(String confirmPassword) {
    final isValid = _isConfirmPasswordValid(state.password, confirmPassword);
    final error = _getConfirmPasswordError(state.password, confirmPassword);

    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        isConfirmPasswordValid: isValid,
        confirmPasswordError: error,
        isFormValid: _calculateFormValidity(isConfirmPasswordValid: isValid),
      ),
    );
  }

  void displayNameChanged(String displayName) {
    final isValid = displayName.trim().isNotEmpty;
    final error = _getDisplayNameError(displayName);

    emit(
      state.copyWith(
        displayName: displayName,
        isDisplayNameValid: isValid,
        displayNameError: error,
        isFormValid: _calculateFormValidity(isDisplayNameValid: isValid),
      ),
    );
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  void toggleAcceptTerms() {
    emit(
      state.copyWith(
        acceptTerms: !state.acceptTerms,
        isFormValid: _calculateFormValidity(acceptTerms: !state.acceptTerms),
      ),
    );
  }

  void clearForm() {
    emit(const SignupFormState());
  }

  bool _calculateFormValidity({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
    bool? isDisplayNameValid,
    bool? acceptTerms,
  }) {
    return (isEmailValid ?? state.isEmailValid) &&
        (isPasswordValid ?? state.isPasswordValid) &&
        (isConfirmPasswordValid ?? state.isConfirmPasswordValid) &&
        (isDisplayNameValid ?? state.isDisplayNameValid) &&
        (acceptTerms ?? state.acceptTerms);
  }

  bool _isConfirmPasswordValid(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) return false;
    return password == confirmPassword;
  }

  String? _getEmailError(String email) {
    if (email.isEmpty) return null;
    if (!AppValidators.isValidEmail(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _getPasswordError(String password) {
    if (password.isEmpty) return null;
    if (!AppValidators.isValidPassword(password)) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _getConfirmPasswordError(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) return null;
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _getDisplayNameError(String displayName) {
    if (displayName.isEmpty) return null;
    if (displayName.trim().isEmpty) {
      return 'Display name cannot be empty';
    }
    return null;
  }
}
