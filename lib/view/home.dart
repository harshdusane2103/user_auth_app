// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:user_auth_app/Contoller/auth_controller.dart';
// // import 'package:user_auth_app/Model/model.dart';
// // import 'package:user_auth_app/services/auth.dart';
// // import 'package:user_auth_app/services/cloud.dart';
// // import 'package:user_auth_app/services/google.dart';
// // import 'package:user_auth_app/view/signin.dart';
// //   var controller = Get.put(Authcontroller());
// // class HomeScreen extends StatelessWidget {
// //   const HomeScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //
// //         title: Text('AuthService'),
// //         actions: [
// //           IconButton(
// //               onPressed: () async {
// //                 await AuthService.authService.singOutUser();
// //                 await GoogleAuthService.googleAuthService.signOutFromGoogle();
// //
// //                 User? user =
// //                 AuthService.authService.getCurrentUser();
// //                 if (user == null) {
// //                   Get.off( SingIn());
// //                 }
// //               },
// //               icon: Icon(Icons.logout)),
// //         ],
// //         // actions: [
// //         //   IconButton(
// //         //     onPressed: () async {
// //         //       await GoogleAuthService.googleAuthService.signOutFromGoogle();
// //         //     },
// //         //     icon: const Icon(Icons.logout),
// //         //   ),
// //         // ],
// //       ),
// //       body: FutureBuilder(
// //           future: CloudFireStoreService.cloudFireStoreService
// //               .readCurrentUserFromFireStore(),
// //           builder: (context, snapshot) {
// //             if (snapshot.hasError) {
// //               return Center(
// //                 child: Text(snapshot.error.toString()),
// //               );
// //             }
// //             if (snapshot.connectionState == ConnectionState.waiting) {
// //               return const Center(child: CircularProgressIndicator());
// //             }
// //
// //             Map? data = snapshot.data!.data();
// //             UserModel userModel = UserModel.fromMap(data!);
// //             UserCredential userCredential=UserCredential.fromMap(data);
// //             return Column(
// //               children: [
// //                 SizedBox(height: 50,),
// //                 Center(
// //                   child: CircleAvatar(
// //                     radius: 40,
// //                     backgroundImage: NetworkImage(userCredential.user!.photoURL!),
// //                   ),
// //                 ),
// //                 Text(
// //                   userModel.name!,
// //                   style: TextStyle(fontSize: 24),
// //                 ),
// //                 SizedBox(
// //                   height: 5,
// //                 ),
// //                 Text(userModel.email!),
// //                 Text(userModel.phone!),
// //
// //
// //               ],
// //             );
// //           }),
// //     );
// //   }
// // }
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:user_auth_app/Model/model.dart';
// import 'package:user_auth_app/services/auth.dart';
// import 'package:user_auth_app/services/cloud.dart';
// import 'package:user_auth_app/services/google.dart';
// import 'package:user_auth_app/view/signin.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('AuthService'),
//         actions: [
//           IconButton(
//             onPressed: () async {
//               // Sign out logic
//               await AuthService.authService.singOutUser();
//               await GoogleAuthService.googleAuthService.signOutFromGoogle();
//
//               User? user = AuthService.authService.getCurrentUser();
//               if (user == null) {
//                 Get.off(() => SingIn());
//               }
//             },
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: FutureBuilder(
//         future: CloudFireStoreService.cloudFireStoreService
//             .readCurrentUserFromFireStore(), // Fetch data from Firestore
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }
//
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasData && snapshot.data != null) {
//             // Extract user data
//             Map<String, dynamic>? data = snapshot.data!.data();
//             if (data == null) {
//               return const Center(child: Text("No user data found."));
//             }
//
//             UserModel userModel = UserModel.fromMap(data);
//
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // User Profile Picture
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: userModel.image != null
//                       ? NetworkImage(userModel.image!)
//                       : const AssetImage('assets/images/default_avatar.png')
//                   as ImageProvider,
//                 ),
//                 const SizedBox(height: 20),
//
//                 // User Name
//                 Text(
//                   userModel.name ?? 'No Name',
//                   style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//
//                 // User Email
//                 Text(
//                   userModel.email ?? 'No Email',
//                   style: const TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//
//                 const SizedBox(height: 8),
//
//                 // User Phone
//                 Text(
//                   userModel.phone ?? 'No Phone Number',
//                   style: const TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//               ],
//             );
//           }
//
//           return const Center(child: Text("No user data available."));
//         },
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_auth_app/services/google.dart';
import 'package:user_auth_app/view/Detail/detail.dart';
import 'package:user_auth_app/view/signin.dart';


class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg'),
          ),
        ),
        // title: const Text('User Details'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text('Logout'),
                ),
              ),
            ],
            onSelected: (value) async {
              if (value == 'logout') {
                await GoogleAuthService().signOut();
                Get.off(() => const LoginScreen());
              }
            },
            icon: Icon(Icons.more_vert), // Three-dot menu icon
          )


        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height:60,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                
              color: Colors.white,
              ),
              child:
              Row(

                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.search),
                  SizedBox(width: 10,),
                  Text('Search New',style: TextStyle(color: Colors.black),)
                ],
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Get.offAndToNamed('/detail');
              },
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 40,
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                  ) ,
                  title: Text(
                    user.displayName ?? 'No Name',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ) ,
                  subtitle:   Text(
                    user.email ?? 'No Email',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
