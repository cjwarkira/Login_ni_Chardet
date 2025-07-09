import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DevAuthHelper {
  /// Signs out the user in debug mode to help with development testing
  /// This will automatically sign out on hot reload for easier testing
  static Future<void> handleDevSignOut() async {
    if (kDebugMode) {
      try {
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          await FirebaseAuth.instance.signOut();
          print(
            'DEV: Auto-signed out user ${currentUser.email} for hot reload testing',
          );
        }
      } catch (e) {
        print('DEV: Error auto-signing out user: $e');
      }
    }
  }

  /// Manual sign out for development testing
  static Future<void> manualDevSignOut() async {
    if (kDebugMode) {
      try {
        await FirebaseAuth.instance.signOut();
        print('DEV: Manual sign out for testing');
      } catch (e) {
        print('DEV: Error in manual sign out: $e');
      }
    }
  }
}
