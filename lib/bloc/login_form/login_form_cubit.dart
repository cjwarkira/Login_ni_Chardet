import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/validators.dart';
import '../../utils/user_preferences.dart';
import 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginFormState> {
  LoginFormCubit() : super(const LoginFormState()) {
    _loadSavedCredentials();
  }

  void emailChanged(String email) {
    final isValid = AppValidators.isValidEmail(email);
    final error = _getEmailError(email);
    
    emit(state.copyWith(
      email: email,
      isEmailValid: isValid,
      emailError: error,
      isFormValid: isValid && state.isPasswordValid,
    ));
  }

  void passwordChanged(String password) {
    final isValid = AppValidators.isValidPassword(password);
    final error = _getPasswordError(password);
    
    emit(state.copyWith(
      password: password,
      isPasswordValid: isValid,
      passwordError: error,
      isFormValid: state.isEmailValid && isValid,
    ));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void toggleRememberMe() {
    emit(state.copyWith(rememberMe: !state.rememberMe));
  }

  void clearForm() {
    emit(const LoginFormState());
  }

  void _loadSavedCredentials() async {
    final rememberMe = await UserPreferences.getRememberMe();
    if (rememberMe) {
      final savedEmail = await UserPreferences.getSavedEmail();
      if (savedEmail != null && savedEmail.isNotEmpty) {
        emit(state.copyWith(
          email: savedEmail,
          isEmailValid: AppValidators.isValidEmail(savedEmail),
          rememberMe: true,
        ));
      }
    }
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
}
