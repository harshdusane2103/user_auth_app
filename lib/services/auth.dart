//
//
// import 'dart:developer';
//
// import 'package:firebase_auth/firebase_auth.dart';
//
//
// class AuthService
// {
//   AuthService._();
//   static AuthService authService=AuthService._();
//   final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
// //   Account Create
//   Future<void> createAccountWithEmailAndPassword(String email,String password)
//   async {
//     await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
//   }
// //  Login
//   Future<String> signInwithEmailAndPassword(String email,String password)
//   async {
//     try
//     {
//       await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
//       return "success";
//     }
//     catch(e)
//     {
//       // return e.toString();
//     }
//   }
//   Future<void> singOutUser()
//   async {
//     await _firebaseAuth.signOut();
//   }
//
//   User? getCurrentUser()
//   {
//     User? user= _firebaseAuth.currentUser;
//     if(user!=null)
//     {
//       log("email:${user.email}");
//     }
//     return user;
//
//   }
//
//
//
// }

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController
{
  RxString receiverEmail="".obs;
  RxString receiverName="".obs;
  RxString image="".obs;

  TextEditingController txtMessage=TextEditingController();
  TextEditingController txtUpdateMessage=TextEditingController();
  void getReceiver(String email,String name)
  {
    receiverEmail.value=email;
    receiverName.value=name;
  }
  void getImage(String url)
  {
    image.value=url;
  }
// @override
// void onInit()
// {
//   super.onInit();
//   CloudFireStoreService.cloudFireStoreService.changeOnlineStatus(true);
// }
// @override
// // TODO: implement isClosed
// void onClose()
// {
//   super.onClose();
//   CloudFireStoreService.cloudFireStoreService.changeOnlineStatus(false);
// }


}