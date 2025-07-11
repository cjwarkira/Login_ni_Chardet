// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../widgets/background_container.dart';
// import '../widgets/custom_text_field.dart';
// import '../widgets/custom_toggle_switch.dart';
// import '../widgets/social_login_section.dart';
// import '../constants/app_constants.dart';
// import '../bloc/bloc.dart';
// import '../utils/user_preferences.dart';
// import 'signup_screen.dart';

// class BlocLoginScreen extends StatefulWidget {
//   const BlocLoginScreen({super.key});

//   @override
//   State<BlocLoginScreen> createState() => _BlocLoginScreenState();
// }

// class _BlocLoginScreenState extends State<BlocLoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BackgroundContainer(
//         child: SafeArea(
//           child: MultiBlocListener(
//             listeners: [
//               // Listen to authentication state changes
//               BlocListener<AuthBloc, AuthState>(
//                 listener: (context, state) {
//                   if (state is AuthError) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(state.message),
//                         backgroundColor: Colors.red,
//                         duration: const Duration(seconds: 3),
//                       ),
//                     );
//                   } else if (state is AuthAuthenticated) {
//                     // Navigation is handled by AuthWrapper
//                     // Save preferences if remember me is checked
//                     final loginFormState = context.read<LoginFormCubit>().state;
//                     if (loginFormState.rememberMe) {
//                       UserPreferences.setRememberMe(true);
//                       UserPreferences.setSavedEmail(loginFormState.email);
//                     } else {
//                       UserPreferences.setRememberMe(false);
//                     }
//                   }
//                 },
//               ),
//               // Listen to form state changes to update controllers
//               BlocListener<LoginFormCubit, LoginFormState>(
//                 listener: (context, state) {
//                   if (_emailController.text != state.email) {
//                     _emailController.text = state.email;
//                     _emailController.selection = TextSelection.fromPosition(
//                       TextPosition(offset: state.email.length),
//                     );
//                   }
//                   if (_passwordController.text != state.password) {
//                     _passwordController.text = state.password;
//                     _passwordController.selection = TextSelection.fromPosition(
//                       TextPosition(offset: state.password.length),
//                     );
//                   }
//                 },
//               ),
//             ],
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(AppConstants.defaultPadding),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // App Logo and Title
//                       const Icon(
//                         Icons.home,
//                         size: 80,
//                         color: AppConstants.primaryColor,
//                       ),
//                       const SizedBox(height: 24),
//                       const Text(
//                         'Welcome Back',
//                         style: TextStyle(
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       const Text(
//                         'Sign in to your account',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white70,
//                         ),
//                       ),
//                       const SizedBox(height: 40),

//                       // Login Form
//                       BlocBuilder<LoginFormCubit, LoginFormState>(
//                         builder: (context, formState) {
//                           return Column(
//                             children: [
//                               // Email Field
//                               CustomTextField(
//                                 label: 'Email',
//                                 hintText: 'Enter your email',
//                                 controller: _emailController,
//                                 keyboardType: TextInputType.emailAddress,
//                               ),
//                               if (formState.emailError != null)
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 4),
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       formState.emailError!,
//                                       style: const TextStyle(
//                                         color: Colors.red,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               const SizedBox(height: 20),

//                               // Password Field
//                               CustomTextField(
//                                 label: 'Password',
//                                 hintText: 'Enter your password',
//                                 controller: _passwordController,
//                                 obscureText: formState.obscurePassword,
//                                 suffixIcon: IconButton(
//                                   icon: Icon(
//                                     formState.obscurePassword
//                                         ? Icons.visibility_outlined
//                                         : Icons.visibility_off_outlined,
//                                     color: Colors.black54,
//                                   ),
//                                   onPressed: () {
//                                     context.read<LoginFormCubit>().togglePasswordVisibility();
//                                   },
//                                 ),
//                               ),
//                               if (formState.passwordError != null)
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 4),
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       formState.passwordError!,
//                                       style: const TextStyle(
//                                         color: Colors.red,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               const SizedBox(height: 20),

//                               // Remember Me and Forgot Password
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   CustomToggleSwitch(
//                                     label: 'Remember me',
//                                     value: formState.rememberMe,
//                                     onTap: () {
//                                       context.read<LoginFormCubit>().toggleRememberMe();
//                                     },
//                                   ),
//                                   TextButton(
//                                     onPressed: () => _showForgotPasswordDialog(context),
//                                     child: const Text(
//                                       'Forgot Password?',
//                                       style: TextStyle(
//                                         color: AppConstants.primaryColor,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 40),

//                               // Login Button
//                               BlocBuilder<AuthBloc, AuthState>(
//                                 builder: (context, authState) {
//                                   final isLoading = authState is AuthSigningIn;
                                  
//                                   return SizedBox(
//                                     width: double.infinity,
//                                     height: 56,
//                                     child: ElevatedButton(
//                                       onPressed: formState.isFormValid && !isLoading
//                                           ? () => _handleLogin(context, formState)
//                                           : null,
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: AppConstants.primaryColor,
//                                         foregroundColor: Colors.black,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(12),
//                                         ),
//                                         disabledBackgroundColor: Colors.grey[600],
//                                       ),
//                                       child: isLoading
//                                           ? const SizedBox(
//                                               height: 20,
//                                               width: 20,
//                                               child: CircularProgressIndicator(
//                                                 strokeWidth: 2,
//                                                 valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//                                               ),
//                                             )
//                                           : const Text(
//                                               'Sign In',
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           );
//                         },
//                       ),

//                       const SizedBox(height: 32),

//                       // Social Login Section
//                       BlocBuilder<AuthBloc, AuthState>(
//                         builder: (context, state) {
//                           final isLoading = state is AuthSigningIn;
//                           return SocialLoginSection(
//                             onGooglePressed: () {
//                               if (!isLoading) {
//                                 context.read<AuthBloc>().add(AuthGoogleSignInRequested());
//                               }
//                             },
//                             onApplePressed: () {
//                               if (!isLoading) {
//                                 context.read<AuthBloc>().add(AuthAppleSignInRequested());
//                               }
//                             },
//                             onFacebookPressed: () {
//                               if (!isLoading) {
//                                 context.read<AuthBloc>().add(AuthFacebookSignInRequested());
//                               }
//                             },
//                           );
//                         },
//                       ),

//                       const SizedBox(height: 32),

//                       // Sign Up Link
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             "Don't have an account? ",
//                             style: TextStyle(color: Colors.white70),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               context.read<LoginFormCubit>().clearForm();
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const SignupScreen(),
//                                 ),
//                               );
//                             },
//                             child: const Text(
//                               'Sign Up',
//                               style: TextStyle(
//                                 color: AppConstants.primaryColor,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Listen to text field changes and update cubit
//     _emailController.addListener(() {
//       context.read<LoginFormCubit>().emailChanged(_emailController.text);
//     });
//     _passwordController.addListener(() {
//       context.read<LoginFormCubit>().passwordChanged(_passwordController.text);
//     });
//   }

//   void _handleLogin(BuildContext context, LoginFormState formState) {
//     context.read<AuthBloc>().add(
//       AuthSignInRequested(
//         email: formState.email,
//         password: formState.password,
//       ),
//     );
//   }

//   void _showForgotPasswordDialog(BuildContext context) {
//     final TextEditingController emailController = TextEditingController();
    
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return BlocProvider.value(
//           value: BlocProvider.of<AuthBloc>(context),
//           child: AlertDialog(
//             backgroundColor: const Color(0xFF2A2A2A),
//             title: const Text(
//               'Reset Password',
//               style: TextStyle(color: Colors.white),
//             ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   'Enter your email address and we\'ll send you a link to reset your password.',
//                   style: TextStyle(color: Colors.white70),
//                 ),
//                 const SizedBox(height: 16),
//                 TextField(
//                   controller: emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: const InputDecoration(
//                     hintText: 'Email',
//                     hintStyle: TextStyle(color: Colors.white54),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white54),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: AppConstants.primaryColor),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: const Text(
//                   'Cancel',
//                   style: TextStyle(color: Colors.white70),
//                 ),
//               ),
//               BlocConsumer<AuthBloc, AuthState>(
//                 listener: (context, state) {
//                   if (state is AuthPasswordResetSent) {
//                     Navigator.of(context).pop();
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Password reset email sent to ${state.email}'),
//                         backgroundColor: Colors.green,
//                       ),
//                     );
//                   } else if (state is AuthError) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(state.message),
//                         backgroundColor: Colors.red,
//                       ),
//                     );
//                   }
//                 },
//                 builder: (context, state) {
//                   final isLoading = state is AuthLoading;
//                   return ElevatedButton(
//                     onPressed: isLoading ? null : () {
//                       if (emailController.text.trim().isNotEmpty) {
//                         context.read<AuthBloc>().add(
//                           AuthPasswordResetRequested(email: emailController.text.trim()),
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppConstants.primaryColor,
//                       foregroundColor: Colors.black,
//                     ),
//                     child: isLoading
//                         ? const SizedBox(
//                             height: 16,
//                             width: 16,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//                             ),
//                           )
//                         : const Text('Send Reset Link'),
//                   );
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
