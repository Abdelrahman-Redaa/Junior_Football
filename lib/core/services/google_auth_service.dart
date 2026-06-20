import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final String? idToken = googleUser.authentication.idToken;
      if (idToken == null || idToken.isEmpty) return null;
      return idToken;
    } catch (e) {
      log('Error during Google Sign-In: $e');
      return null;
    }
  }
}
