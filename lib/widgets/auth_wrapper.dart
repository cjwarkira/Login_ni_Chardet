import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_ni_chardet/screens/bloc_login_screen.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../utils/dev_auth_helper.dart';
import '../bloc/bloc.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    _initializeAuth();
  }

  void _initializeAuth() async {
    // In debug mode, automatically sign out on hot reload for testing
    if (kDebugMode) {
      await DevAuthHelper.handleDevSignOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // Debug print for development
        if (kDebugMode) {
          print('AuthWrapper: Auth state changed - ${state.runtimeType}');
        }

        // Show loading screen while checking authentication
        if (state is AuthInitial || state is AuthLoading) {
          return const Scaffold(
            backgroundColor: Color(0xFF1A1A1A),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Color(0xFF0ACF83)),
                  SizedBox(height: 16),
                  Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }

        // If user is authenticated, show home screen
        if (state is AuthAuthenticated) {
          return HomeScreen(
            userEmail: state.user.email ?? 'user@example.com',
          );
        }

        // If user is not authenticated, show login screen
        return const  LoginScreen();
      },
    );
  }
}
