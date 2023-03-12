import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<UserCredential> signInWithGoogle() async {
    // begin interactive signIn process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //
    final credential = GoogleAuthProvider.credential(
        idToken: gAuth.idToken, accessToken: gAuth.accessToken);

    // sign in with firebase
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signInWithFacebook() async {
    // begin interactive signIn process
    final loginResult = await FacebookAuth.instance.login();
    final userData = await FacebookAuth.instance.getUserData();
    final credentials =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    await FirebaseAuth.instance.signInWithCredential(credentials);
  }
}
