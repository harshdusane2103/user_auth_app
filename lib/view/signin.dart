
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'package:sign_in_button/sign_in_button.dart';
// import 'package:user_auth_app/Contoller/auth_controller.dart';
// import 'package:user_auth_app/services/auth.dart';
// import 'package:user_auth_app/services/google.dart';
// import 'package:user_auth_app/view/home.dart';
//
//
//
// var controller = Get.put(Authcontroller());
//
// class SingIn extends StatelessWidget {
//   const SingIn({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('SignIn'),
//       // ),
//       body:
//
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:user_auth_app/services/google.dart';
import 'package:user_auth_app/view/home.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body:    SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.all(20),
              height: 620,
              width: 360,
              decoration: BoxDecoration(
                // border: Border.all(
                //   color: Colors.blue.shade100,
                //   width: 1,
                // ),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(height: 10,),

                    Text(
                      "LogIn",
                      style: TextStyle(
                        // color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Remember to get up & stretch once",
                      style: TextStyle(
                        // color: Colors.black,
                      ),
                    ),
                    Text(
                      "in a  while-your friends at chat",
                      style: TextStyle(
                        // color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      // controller: controller.txtEmail,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.blue, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                          )),
                    ),
                    SizedBox(height: 12,),
                    TextField(
                      obscureText: true,
                      // controller: controller.txtPassword,
                      decoration: InputDecoration(

                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.blue, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          prefixIcon: Icon(
                            Icons.lock_outline_rounded,
                          ),
                          suffixIcon: Icon(Icons.remove_red_eye_outlined)
                      ),
                    ),

                    SizedBox(height: 18,),
                    // GestureDetector(
                    //   onTap: () async {
                    //     String response = await AuthService.authService
                    //         .signInwithEmailAndPassword(
                    //         controller.txtEmail.text,
                    //         controller.txtPassword.text
                    //     );
                    //     User? user = AuthService.authService.getCurrentUser();
                    //     if (user != null) {
                    //       Get.offAndToNamed('/home');
                    //       controller.txtEmail.clear();
                    //       controller.txtPassword.clear();
                    //
                    //     } else {
                    //       Get.snackbar('signIn in failed', response);
                    //     }
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     width: 180,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(20),
                    //       color: Colors.blue,
                    //     ),
                    //     child: Center(
                    //         child: Text(
                    //           'SignIn',
                    //           style: TextStyle(color: Colors.white, fontSize: 18),
                    //         )),
                    //   ),
                    // ),
                    Center(
                      child: SignInButton(
                        Buttons.google,
                        onPressed: () async {
                          User? user = await GoogleAuthService().signInWithGoogle();
                          if (user != null) {
                            Get.off(() => HomeScreen(user: user)); // Navigate to HomeScreen
                          }
                        },
                        // child: const Text('Sign in with Google'),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('OR'),
                    SizedBox(
                      height: 8,
                    ),
                    // SignInButton(Buttons.google, onPressed: () async {
                    //   await GoogleAuthService.googleAuthService.signInWithGoogle().toString();
                    //   User? user = AuthService.authService.getCurrentUser();
                    //   if (user != null) {
                    //     Get.offAll(HomeScreen());
                    //   }
                    // }),
                    SizedBox(
                      height: 8,
                    ),
                    // signup button
                    GestureDetector(
                      onTap: () {
                        // Get.off(SignUp());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have account ?',
                            style: TextStyle(
                              // color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 2,),
                          Text(
                            'signUp',
                            style: TextStyle(color: Colors.blue, fontSize:20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //
        //
        //     //     ElevatedButton(onPressed: () async {
        //     //      String response= await AuthService.authService.signInwithEmailAndPassword(controller.txtEmail.text,controller.txtPassword.text);
        //     //       User? user= AuthService.authService.getCurrentUser();
        //     //       if(user!=null)
        //     //         {
        //     //           Get.offAndToNamed('/home');
        //     // }
        //     //       else
        //     //         {
        //     //           Get.snackbar('singin in failed', response);
        //     //         }
        //     //
        //     //
        //     //     }, child: Text('SingIn'))
        //   ],
        // ),
      ),

    );
  }
}
