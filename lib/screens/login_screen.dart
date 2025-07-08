import 'package:flutter/material.dart';
import '../widgets/background_container.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_toggle_switch.dart';
import '../widgets/social_login_section.dart';
import '../constants/app_constants.dart';
import '../controllers/login_controller.dart';
import '../utils/validators.dart';

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

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final email = _emailController.text;
        final password = _passwordController.text;

        final success = await _loginController.login(
          email,
          password,
          rememberMe: _rememberMe,
        );

        if (success && mounted) {
          // AuthWrapper will handle navigation automatically
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login failed: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email first')),
      );
      return;
    }

    try {
      await _loginController.forgotPassword(email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }

  void _handleSignup() {
    // TODO: Navigate to signup screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signup navigation to be implemented')),
    );
  }

  void _handleGoogleLogin() async {
    try {
      final success = await _loginController.loginWithGoogle();
      if (mounted && success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Google login successful!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google login failed: ${e.toString()}')),
        );
      }
    }
  }

  void _handleAppleLogin() async {
    try {
      final success = await _loginController.loginWithApple();
      if (mounted && success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Apple login successful!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Apple login failed: ${e.toString()}')),
        );
      }
    }
  }

  void _handleFacebookLogin() async {
    try {
      final success = await _loginController.loginWithFacebook();
      if (mounted && success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Facebook login successful!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Facebook login failed: ${e.toString()}')),
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
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
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
                    const SizedBox(height: 30),
                  ],
                ),
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
