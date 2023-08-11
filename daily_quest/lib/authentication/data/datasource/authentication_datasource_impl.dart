import 'dart:io';

import 'package:daily_quest/authentication/data/datasource/authentication_datasource.dart';
import 'package:daily_quest/authentication/domain/exception/authentication_exception.dart';
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

  @override
  Future<bool> autoSignIn() async {
    await FirebaseAuth.instance.currentUser?.delete();
    return Future.value(FirebaseAuth.instance.currentUser != null);
  }

  @override
  Future<bool> emailSignIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFound();
      } else if (e.code == 'wrong-password') {
        throw WrongUserNamePassword();
      } else {
        throw SignInUnknownError();
      }
    }
  }

  Future<bool> _macOSGoogleSignIn() async {
    final result = await platform.invokeMethod<bool>('googleSignIn');
    return result ?? false;
  }

  Future<bool> _googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return false;
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
