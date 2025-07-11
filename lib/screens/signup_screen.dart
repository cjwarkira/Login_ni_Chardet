import 'package:flutter/material.dart';
import '../widgets/background_container.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_login_section.dart';
import '../constants/app_constants.dart';
import '../controllers/login_controller.dart';
import '../utils/validators.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _loginController = LoginController();
  bool _acceptTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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

  void _handleSignup() async {
    // Ensure the form validation doesn't cause UI issues
    FocusScope.of(context).unfocus();

    // Check for empty fields and show user-friendly messages
    if (_nameController.text.trim().isEmpty) {
      _showToastMessage(
        message: 'Please enter your full name',
        context: context,
      );
      return;
    }

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

    if (_confirmPasswordController.text.isEmpty) {
      _showToastMessage(
        message: 'Please confirm your password',
        context: context,
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showToastMessage(message: 'Passwords do not match', context: context);
      return;
    }

    if (!_acceptTerms) {
      _showToastMessage(
        message: 'Please accept the terms and conditions',
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
        final name = _nameController.text.trim();
        final email = _emailController.text.trim();
        final password = _passwordController.text;

        final success = await _loginController.register(email, password, name);

        if (success && mounted) {
          // Sign out the user immediately after registration
          await _loginController.logout();

          _showToastMessage(
            message: 'User Account Registered',
            context: context,
            color: Colors.green,
            icon: const Icon(Icons.check_circle, color: Colors.white),
            duration: const Duration(seconds: 3),
          );

          // Navigate back to login screen after a brief delay
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              Navigator.of(context).pushReplacementNamed('/login');
            }
          });
        }
      } catch (e) {
        if (mounted) {
          _showToastMessage(
            message: 'Sign up failed: ${e.toString()}',
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

  void _handleGoogleSignup() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final success = await _loginController.loginWithGoogle();
      if (mounted && success) {
        // Sign out the user immediately after registration
        await _loginController.logout();

        _showToastMessage(
          message: 'Google Account Registered Successfully',
          context: context,
          color: Colors.green,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          duration: const Duration(seconds: 3),
        );

        // Navigate back to login screen after a brief delay
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.of(context).pushReplacementNamed('/login');
          }
        });
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = e.toString();

        // Handle specific error cases
        if (errorMessage.contains('cancelled')) {
          errorMessage = 'Google Sign-In was cancelled';
        } else if (errorMessage.contains('network')) {
          errorMessage = 'Network error. Please check your connection.';
        } else if (errorMessage.contains('not available')) {
          errorMessage = 'Google Sign-In is not available on this device';
        } else {
          errorMessage = 'Google sign up failed. Please try again.';
        }

        _showToastMessage(
          message: errorMessage,
          context: context,
          duration: const Duration(seconds: 3),
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

  void _handleAppleSignup() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final success = await _loginController.loginWithApple();
      if (mounted && success) {
        // Sign out the user immediately after registration
        await _loginController.logout();

        _showToastMessage(
          message: 'User Account Registered',
          context: context,
          color: Colors.green,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          duration: const Duration(seconds: 3),
        );

        // Navigate back to login screen after a brief delay
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.of(context).pushReplacementNamed('/login');
          }
        });
      }
    } catch (e) {
      if (mounted) {
        _showToastMessage(
          message: 'Apple sign up failed: ${e.toString()}',
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

  void _handleFacebookSignup() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final success = await _loginController.loginWithFacebook();
      if (mounted && success) {
        _showToastMessage(
          message: 'Facebook sign up successful!',
          context: context,
          color: Colors.green,
        );
      }
    } catch (e) {
      if (mounted) {
        _showToastMessage(
          message: 'Facebook sign up failed: ${e.toString()}',
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

  void _handleLogin() {
    Navigator.of(context).pop(); // Go back to login screen
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
                  const SizedBox(height: 20),
                  _buildTitle(),
                  const SizedBox(height: 24),
                  _buildNameField(),
                  const SizedBox(height: AppConstants.elementSpacing),
                  _buildEmailField(),
                  const SizedBox(height: AppConstants.elementSpacing),
                  _buildPasswordField(),
                  const SizedBox(height: AppConstants.elementSpacing),
                  _buildConfirmPasswordField(),
                  const SizedBox(height: AppConstants.elementSpacing),
                  _buildTermsAndConditions(),
                  const SizedBox(height: 20),
                  _buildSignupButton(),
                  const SizedBox(height: AppConstants.sectionSpacing),
                  _buildSocialLoginSection(),
                  const SizedBox(height: AppConstants.sectionSpacing),
                  _buildLoginSection(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text('Create Account', style: AppConstants.titleTextStyle);
  }

  Widget _buildNameField() {
    return CustomTextField(
      label: 'Full Name',
      hintText: 'Enter your full name',
      controller: _nameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your full name';
        }
        if (value.trim().length < 2) {
          return 'Name must be at least 2 characters';
        }
        return null;
      },
    );
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

  Widget _buildConfirmPasswordField() {
    return CustomTextField(
      label: 'Confirm Password',
      hintText: 'Confirm Password',
      controller: _confirmPasswordController,
      obscureText: _obscureConfirmPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            _obscureConfirmPassword = !_obscureConfirmPassword;
          });
        },
        icon: Icon(
          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
          color: AppConstants.hintTextColor,
        ),
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      children: [
        Checkbox(
          value: _acceptTerms,
          onChanged: (value) {
            setState(() {
              _acceptTerms = value ?? false;
            });
          },
          activeColor: AppConstants.primaryColor,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: AppConstants.bodyTextStyle,
              children: [
                const TextSpan(text: 'I agree to the '),
                TextSpan(
                  text: 'Terms of Service',
                  style: AppConstants.linkTextStyle.copyWith(
                    color: AppConstants.linkColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: AppConstants.linkTextStyle.copyWith(
                    color: AppConstants.linkColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignupButton() {
    return Container(
      width: double.infinity,
      height: AppConstants.buttonHeight,
      decoration: BoxDecoration(
        color: AppConstants.primaryColor,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: AppConstants.defaultBoxShadow,
      ),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSignup,
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
                : Text('Create Account', style: AppConstants.buttonTextStyle),
      ),
    );
  }

  Widget _buildSocialLoginSection() {
    return SocialLoginSection(
      dividerText: 'Or sign up with',
      onGooglePressed: _handleGoogleSignup,
      onApplePressed: _handleAppleSignup,
      onFacebookPressed: _handleFacebookSignup,
    );
  }

  Widget _buildLoginSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: AppConstants.bodyTextStyle,
        ),
        GestureDetector(
          onTap: _handleLogin,
          child: Text(
            'Login',
            style: AppConstants.linkTextStyle.copyWith(
              color: AppConstants.linkColor,
            ),
          ),
        ),
      ],
    );
  }
}
