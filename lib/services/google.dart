// import 'dart:developer';
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:user_auth_app/Model/model.dart';
// import 'package:user_auth_app/services/cloud.dart';
//
//
// class GoogleAuthService {
//   GoogleAuthService._();
//
//   static GoogleAuthService googleAuthService = GoogleAuthService._();
//   GoogleSignIn googleSignIn = GoogleSignIn();
//
//   Future<void> signInWithGoogle() async {
//     try {
//       GoogleSignInAccount? account = await googleSignIn.signIn();
//       GoogleSignInAuthentication authentication = await account!.authentication;
//       AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: authentication.accessToken,
//         idToken: authentication.idToken,
//       );
//       UserCredential userCredential =
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       UserModel user = UserModel(
//           name: userCredential.user!.displayName.toString(),
//           email: userCredential.user!.phoneNumber.toString(),
//           image: userCredential.user!.photoURL.toString(),
//           phone: userCredential.user!.phoneNumber.toString(),
//           token: '--------------',
//           isOnline: false,
//           isTyping: false,
//           timestamp: Timestamp.now(),
//           read: false);
//       CloudFireStoreService.cloudFireStoreService.insertUserIntoFireStore(user);
//       log(userCredential.user!.email!);
//       log(userCredential.user!.photoURL!);
//     } catch (e) {
//       Get.snackbar("SignIn failed", "e.toString()");
//       log(e.toString());
//     }
//   }
//
//   Future<void> signOutFromGoogle() async {
//     await googleSignIn.signOut();
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      // Trigger Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      // Get the authentication details from the Google account
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential for Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase and return the authenticated user
      final UserCredential userCredential =
      await _firebaseAuth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
