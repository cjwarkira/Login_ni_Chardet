import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthDebug {
  static void printAuthState() {
    if (kDebugMode) {
      final user = FirebaseAuth.instance.currentUser;
      print('=== AUTH DEBUG ===');
      print('Current user: ${user?.email ?? 'No user'}');
      print('User ID: ${user?.uid ?? 'No UID'}');
      print('Email verified: ${user?.emailVerified ?? false}');
      print('================');
    }
  }

  static void logAuthEvent(String event, [String? details]) {
    if (kDebugMode) {
      print('AUTH EVENT: $event${details != null ? ' - $details' : ''}');
    }
  }
}
