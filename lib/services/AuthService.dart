import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:personify_app/models/usermodel.dart';
import 'package:personify_app/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// Create obj based on firebase user

  UserModel _userFromFirebaseUser(User? user) {
    return user != null
        ? UserModel(
            uid: user.uid, email: user.email, displayName: user.displayName)
        : UserModel();
  }

// authchange user stream
  Stream<UserModel> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

// sign in with google

  // obj for google sign in class
  GoogleSignIn googleAuth = new GoogleSignIn();

// Google sign in function
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleAuth.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print("error is ${e.toString()}");
      return null;
    }
  }

  Future signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleAuth.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      await DatabaseService(uid: user!.uid).updateUserData(
          user!.email.toString(), "userName", 18, "Lagos", "Nigeria", "Others");
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("error is ${e.toString()}");
      return null;
    }
  }

// Facebook sign in function
  Future signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential FacebookAuthCredential =
          await FacebookAuthProvider.credential(loginResult.accessToken!.token);

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(FacebookAuthCredential);

      final User? user = userCredential.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print("error is ${e.toString()}");
      return null;
    }
  }

  Future signUpWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential FacebookAuthCredential =
          await FacebookAuthProvider.credential(loginResult.accessToken!.token);

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(FacebookAuthCredential);

      final User? user = userCredential.user;
      await DatabaseService(uid: user!.uid).updateUserData(
          user.email.toString(), "userName", 18, "Lagos", "Nigeria", "Others");
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("error is ${e.toString()}");
      return null;
    }
  }

  // Logout user
  Future Logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("error is ${e.toString()}");
    }
  }

  Future DeleteAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      print(e);

      if (e.code == "requires-recent-login") {
        await _reauthenticateAndDelete();
      } else {
        // Handle other Firebase exceptions
      }
    } catch (e) {
      print(e);

      // Handle general exception
    }
  }

  Future<void> _reauthenticateAndDelete() async {
    try {
      final providerData = _auth.currentUser?.providerData.first;

      if (AppleAuthProvider().providerId == providerData!.providerId) {
        await _auth.currentUser!
            .reauthenticateWithProvider(AppleAuthProvider());
      } else if (GoogleAuthProvider().providerId == providerData.providerId) {
        await _auth.currentUser!
            .reauthenticateWithProvider(GoogleAuthProvider());
      }

      await _auth.currentUser?.delete();
    } catch (e) {
      // Handle exceptions
    }
  }
}
