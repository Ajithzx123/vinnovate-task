import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      // log(e.code);
      // log(e.message!);
      if (e.code == 'user-not-found') {
        return 'Email not registered'; // Email is not registered
      } else if (e.code == 'invalid-credential' || e.code == 'invalid-email') {
        return 'Invalid email or password'; // Invalid email or password
      } else {
        return 'An error occurred'; // Other errors
      }
    } catch (e) {
      log('Sign in error: $e');
      return 'An error occurred';
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // Handle error
      print('Sign out error: $e');
      rethrow;
    }
  }
}
