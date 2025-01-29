//
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:user_auth_app/ApiHelper/api.dart';
//
// class ImgurController extends GetxController {
//   var images = <Map<String, String>>[].obs; // Stores uploaded images
//   var isLoading = false.obs;
//   var errorMessage = RxnString();
//
//   @override
//   void onInit() {
//     super.onInit();
//     // loadImages(); // Load stored images on startup
//   }
//
//   // Upload Image
//   Future<void> uploadImage(Uint8List imageBytes) async {
//     try {
//       isLoading(true);
//       String base64Image = base64Encode(imageBytes);
//       final response = await ImgurApiHelper.uploadImage(base64Image);
//
//       final imageUrl = response['data']['link'];
//       final imageHash = response['data']['id'];
//       final deleteHash = response['data']['deletehash'];
//
//       images.add({'url': imageUrl, 'hash': imageHash, 'deleteHash': deleteHash});
//       // await saveImages(); // Save the updated images list
//       errorMessage.value = null;
//       print("Uploaded Image URL: $imageUrl");
//     } catch (e) {
//       errorMessage.value = e.toString();
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   // Delete Image
//   Future<void> deleteImage(int index) async {
//     if (index >= images.length) return;
//     try {
//       isLoading(true);
//       await ImgurApiHelper.deleteImage(images[index]['deleteHash']!);
//       images.removeAt(index);
//       // await saveImages(); // Update stored images list
//       errorMessage.value = null;
//     } catch (e) {
//       errorMessage.value = e.toString();
//     } finally {
//       isLoading(false);
//     }
//   }
//
//
// }
import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:user_auth_app/ApiHelper/api.dart';
// import 'package:user_auth_app/Helpers/firestore_helper.dart';
import 'package:user_auth_app/services/cloud.dart';

class ImgurController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = RxnString();

  // Upload Image and Save to Firestore
  Future<void> uploadImage(Uint8List imageBytes) async {
    try {
      isLoading(true);
      String base64Image = base64Encode(imageBytes);
      final response = await ImgurApiHelper.uploadImage(base64Image);

      final imageUrl = response['data']['link'];
      final imageHash = response['data']['id'];
      final deleteHash = response['data']['deletehash'];

      // Save to Firestore
      await FirestoreHelper.saveImage(imageUrl, imageHash, deleteHash);
      errorMessage.value = null;
      print("Uploaded Image URL: $imageUrl");
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  // Delete Image from Firestore and Imgur
  Future<void> deleteImage(String imageHash, String deleteHash) async {
    try {
      isLoading(true);
      await ImgurApiHelper.deleteImage(deleteHash);
      await FirestoreHelper.deleteImage(imageHash);
      errorMessage.value = null;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}
