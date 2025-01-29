//
//
// import 'dart:typed_data';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:user_auth_app/Contoller/image_controller.dart';
//
//
// class DetailScreen extends StatelessWidget {
//   final User user;
//   final ImgurController imgurController = Get.put(ImgurController());
//
//   DetailScreen({super.key, required this.user});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         leading: InkWell(
//           onTap: () => Get.offAndToNamed('/home'),
//           child: const Icon(Icons.arrow_back_ios),
//         ),
//         title: Text(
//           user.displayName ?? 'No Name',
//           style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Obx(() {
//           if (imgurController.isLoading.value) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           return imgurController.images.isEmpty
//               ? const Center(child: Text('No images uploaded yet.'))
//               : ListView.builder(
//             itemCount: imgurController.images.length,
//             itemBuilder: (context, index) {
//               final image = imgurController.images[index];
//               return Card(
//                 margin: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Column(
//                   children: [
//                     Stack(
//                       children: [ Image.network(
//                         image['url']!,
//                         height: 400,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                       ),
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               IconButton(   onPressed: () async {
//                                 await imgurController.deleteImage(index);
//                                     }, icon: Icon(Icons.delete,color: Colors.red,))
//                                ]
//
//                     ),
//
//
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         }),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final picker = ImagePicker();
//           XFile? xfile = await picker.pickImage(source: ImageSource.gallery);
//           if (xfile != null) {
//             Uint8List image = await xfile.readAsBytes();
//             await imgurController.uploadImage(image);
//           }
//         },
//         child: const Icon(Icons.image),
//       ),
//     );
//   }
// }
//
//
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_auth_app/Contoller/image_controller.dart';
// import 'package:user_auth_app/Helpers/firestore_helper.dart';
import 'package:user_auth_app/services/cloud.dart';

class DetailScreen extends StatelessWidget {
  final User user;
  final ImgurController imgurController = Get.put(ImgurController());

  DetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        centerTitle: true,
        leading: InkWell(
          onTap: () => Get.offAndToNamed('/home'),
          child: const Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
        title: Text(
          user.displayName ?? 'No Name',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: FirestoreHelper.getImagesStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No images uploaded yet.'));
            }

            final images = snapshot.data!.docs;

            return ListView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                final image = images[index].data() as Map<String, dynamic>;
                final imageHash = image['hash'];
                final deleteHash = image['deleteHash'];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Stack(
                    children: [
                      Container(
                        height: 400,

                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.red,
                          image: DecorationImage(

                              fit:BoxFit.cover,image: NetworkImage( image['url'],


                          )

                          )

                        ),
                        // child: Image.network(
                        //   image['url'],
                        //   height: 400,
                        //   width: double.infinity,
                        //
                        //   fit: BoxFit.cover,
                        //
                        // ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: CircleAvatar(
                          backgroundColor: Colors.black12,
                          child: IconButton(
                            onPressed: () async {
                              await imgurController.deleteImage(imageHash, deleteHash);
                            },
                            icon: const Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black26,
        onPressed: () async {
          final picker = ImagePicker();
          XFile? xfile = await picker.pickImage(source: ImageSource.gallery);
          if (xfile != null) {
            Uint8List image = await xfile.readAsBytes();
            await imgurController.uploadImage(image);
          }
        },
        child: const Icon(Icons.image,color: Colors.white,),
      ),
    );
  }
}
