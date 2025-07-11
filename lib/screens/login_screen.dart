import 'package:flutter/material.dart';
import '../widgets/background_container.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_toggle_switch.dart';
import '../widgets/social_login_section.dart';
import '../constants/app_constants.dart';
import '../controllers/login_controller.dart';
import '../utils/validators.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginController = LoginController();
  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Reusable toast message method
  void _showToastMessage({
    required String message,
    required BuildContext context,
    Color? color,
    Widget? icon,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[icon, const SizedBox(width: 12)],
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: color ?? Colors.red,
        duration: duration ?? const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _handleLogin() async {
    // Ensure the form validation doesn't cause UI issues
    FocusScope.of(context).unfocus();

    // Check for empty fields and show user-friendly messages
    if (_emailController.text.trim().isEmpty) {
      _showToastMessage(
        message: 'Please enter your email address',
        context: context,
      );
      return;
    }

    if (_passwordController.text.isEmpty) {
      _showToastMessage(
        message: 'Please enter your password',
        context: context,
      );
      return;
    }

    // Additional validation
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        final email = _emailController.text.trim();
        final password = _passwordController.text;

        final success = await _loginController.login(
          email,
          password,
          rememberMe: _rememberMe,
        );

        if (success && mounted) {
          // AuthWrapper will handle navigation automatically
          _showToastMessage(
            message: 'Welcome back! Login successful!',
            context: context,
            color: Colors.green,
            icon: const Icon(Icons.check_circle, color: Colors.white),
            duration: const Duration(seconds: 3),
          );
        }
      } catch (e) {
        if (mounted) {
          _showToastMessage(
            message: 'Login failed: ${e.toString()}',
            context: context,
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  void _handleForgotPassword() async {
    final email = _emailController.text;
    if (email.isEmpty) {
      _showToastMessage(
        message: 'Please enter your email first',
        context: context,
      );
      return;
    }

    try {
      await _loginController.forgotPassword(email);
      if (mounted) {
        _showToastMessage(
          message: 'Password reset email sent! Check your inbox.',
          context: context,
          color: Colors.blue,
          icon: const Icon(Icons.email, color: Colors.white),
          duration: const Duration(seconds: 4),
        );
      }
    } catch (e) {
      if (mounted) {
        _showToastMessage(message: 'Error: ${e.toString()}', context: context);
      }
    }
  }

  void _handleSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

  void _handleGoogleLogin() async {
    try {
      final success = await _loginController.loginWithGoogle();
      if (mounted && success) {
        _showToastMessage(
          message: 'Google login successful! Welcome!',
          context: context,
          color: Colors.green,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      if (mounted) {
        _showToastMessage(
          message: 'Google login failed: ${e.toString()}',
          context: context,
        );
      }
    }
  }

  void _handleAppleLogin() async {
    try {
      final success = await _loginController.loginWithApple();
      if (mounted && success) {
        _showToastMessage(
          message: 'Apple login successful! Welcome!',
          context: context,
          color: Colors.green,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      if (mounted) {
        _showToastMessage(
          message: 'Apple login failed: ${e.toString()}',
          context: context,
        );
      }
    }
  }

  void _handleFacebookLogin() async {
    try {
      final success = await _loginController.loginWithFacebook();
      if (mounted && success) {
        _showToastMessage(
          message: 'Facebook login successful!',
          context: context,
          color: Colors.green,
        );
      }
    } catch (e) {
      if (mounted) {
        _showToastMessage(
          message: 'Facebook login failed: ${e.toString()}',
          context: context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BackgroundContainer(
        backgroundImagePath: 'assets/images/building_estate.jpg',
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
              vertical: 20,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 60),
                  _buildTitle(),
                  const SizedBox(height: 30),
                  _buildEmailField(),
                  const SizedBox(height: AppConstants.elementSpacing),
                  _buildPasswordField(),
                  _buildRememberMeAndForgotPassword(),
                  const SizedBox(height: 25),
                  _buildLoginButton(),
                  const SizedBox(height: AppConstants.sectionSpacing),
                  _buildSocialLoginSection(),
                  const SizedBox(height: AppConstants.sectionSpacing),
                  _buildSignupSection(),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text('Login', style: AppConstants.titleTextStyle);
  }

  Widget _buildEmailField() {
    return CustomTextField(
      label: 'Email',
      hintText: 'Email Address',
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      validator: AppValidators.validateEmail,
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      label: 'Password',
      hintText: 'Password',
      controller: _passwordController,
      obscureText: _obscurePassword,
      validator: AppValidators.validatePassword,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
        icon: Icon(
          _obscurePassword ? Icons.visibility_off : Icons.visibility,
          color: AppConstants.hintTextColor,
        ),
      ),
    );
  }

  Widget _buildRememberMeAndForgotPassword() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomToggleSwitch(
            value: _rememberMe,
            onTap: () {
              setState(() {
                _rememberMe = !_rememberMe;
              });
            },
            label: 'Remember me',
          ),
          GestureDetector(
            onTap: _handleForgotPassword,
            child: Text(
              'Forgot password?',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 14,
                color: AppConstants.hintTextColor,
                decoration: TextDecoration.underline,
                decorationColor: AppConstants.hintTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: AppConstants.buttonHeight,
      decoration: BoxDecoration(
        color: AppConstants.primaryColor,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: AppConstants.defaultBoxShadow,
      ),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
        ),
        child:
            _isLoading
                ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: AppConstants.whiteColor,
                    strokeWidth: 2,
                  ),
                )
                : Text('Login', style: AppConstants.buttonTextStyle),
      ),
    );
  }

  Widget _buildSocialLoginSection() {
    return SocialLoginSection(
      onGooglePressed: _handleGoogleLogin,
      onApplePressed: _handleAppleLogin,
      onFacebookPressed: _handleFacebookLogin,
    );
  }

  Widget _buildSignupSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: AppConstants.bodyTextStyle,
        ),
        GestureDetector(
          onTap: _handleSignup,
          child: Text(
            'Signup',
            style: AppConstants.linkTextStyle.copyWith(
              color: AppConstants.linkColor,
            ),
          ),
        ),
      ],
    );
  }
}
