
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_auth_app/Contoller/auth_controller.dart';
import 'package:user_auth_app/view/Detail/detail.dart';
import 'package:user_auth_app/view/home.dart';
import 'package:user_auth_app/view/signin.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page:()=>AuthManger(),transition: Transition.rightToLeft),
        GetPage(name: '/log', page:()=>LoginScreen(),transition: Transition.rightToLeft),
        GetPage(name: '/home', page:()=>HomeScreen(user: FirebaseAuth.instance.currentUser!),transition: Transition.rightToLeft),
        GetPage(name: '/detail', page:()=>DetailScreen(user: FirebaseAuth.instance.currentUser!),transition: Transition.rightToLeft),

      ],
    );
  }
}
