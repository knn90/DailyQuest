import 'dart:io';

import 'package:daily_quest/authentication/data/datasource/authentication_datasource.dart';
import 'package:daily_quest/authentication/domain/exception/authentication_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  static const platform = MethodChannel('com.dailyquest/authentication');

  @override
  Future<String> autoSignIn() async {
    await FirebaseAuth.instance.signOut();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return Future.value(user.uid);
    } else {
      throw AuthenticationError.signInUnknownError;
    }
  }

  @override
  Future<String> googleSignIn() async {
    if (Platform.isMacOS) {
      return await _macOSGoogleSignIn();
    } else {
      return await _googleSignIn();
    }
  }

  @override
  Future<String> guestSignIn() async {
    try {
      final userCred = await FirebaseAuth.instance.signInAnonymously();
      final user = userCred.user;
      if (user != null) {
        return Future.value(user.uid);
      } else {
        throw AuthenticationError.signInUnknownError;
      }
    } on FirebaseAuthException {
      throw AuthenticationError.signInUnknownError;
    }
  }

  @override
  Future<String> emailSignIn(
      {required String email, required String password}) async {
    try {
      final userCred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = userCred.user;
      if (user != null) {
        return Future.value(user.uid);
      } else {
        throw AuthenticationError.signInUnknownError;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthenticationError.userNotFound;
      } else if (e.code == 'wrong-password') {
        throw AuthenticationError.wrongUserNamePassword;
      } else {
        throw AuthenticationError.signInUnknownError;
      }
    }
  }

  @override
  Future<String> signUp(
      {required String email, required String password}) async {
    try {
      final userCred =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCred.user;
      if (user != null) {
        return Future.value(user.uid);
      } else {
        throw AuthenticationError.signInUnknownError;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthenticationError.weakPasswordError;
      } else if (e.code == 'email-already-in-use') {
        throw AuthenticationError.userExistError;
      } else {
        throw AuthenticationError.signUpUnknownError;
      }
    }
  }

  @override
  Future<bool> resetPassword({required String email}) async {
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthenticationError.userNotFound;
      } else {
        throw AuthenticationError.resetPasswordUnknowError;
      }
    }
  }

  Future<String> _macOSGoogleSignIn() async {
    final userId = await platform.invokeMethod<String?>('googleSignIn');
    if (userId != null) {
      return Future.value(userId);
    } else {
      throw AuthenticationError.signInUnknownError;
    }
  }

  Future<String> _googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // TODO: Change this to signin cancelled
      throw AuthenticationError.signInUnknownError;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCred =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final user = userCred.user;
    if (user != null) {
      return Future.value(user.uid);
    } else {
      throw AuthenticationError.signInUnknownError;
    }
  }
}
