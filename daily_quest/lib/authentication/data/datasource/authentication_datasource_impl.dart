import 'dart:io';

import 'package:daily_quest/authentication/data/datasource/authentication_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  static const platform = MethodChannel('com.dailyquest/authentication');
  @override
  Future<bool> googleSignIn() async {
    if (Platform.isMacOS) {
      return await _macOSGoogleSignIn();
    } else {
      return await _googleSignIn();
    }
  }

  Future<bool> _macOSGoogleSignIn() {
    return platform
        .invokeMethod<bool>('googleSignIn')
        .then((value) => value ?? false);
  }

  Future<bool> _googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return false;
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    return true;
  }
}
