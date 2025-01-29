import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_auth_app/view/signin.dart';

import '../view/home.dart';

class AuthManger extends StatelessWidget {
  const AuthManger({super.key});

  @override
  Widget build(BuildContext context) {
    return
      FirebaseAuth.instance.currentUser != null
          ? HomeScreen(user: FirebaseAuth.instance.currentUser!)
          : const LoginScreen();

  }
}
