import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save image details to Firestore
  static Future<void> saveImage(String imageUrl, String imageHash, String deleteHash) async {
    await _db.collection('user_images').doc(imageHash).set({
      'url': imageUrl,
      'hash': imageHash,
      'deleteHash': deleteHash,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Delete image from Firestore
  static Future<void> deleteImage(String imageHash) async {
    await _db.collection('user_images').doc(imageHash).delete();
  }

  // Get a real-time stream of images
  static Stream<QuerySnapshot> getImagesStream() {
    return _db.collection('user_images').orderBy('timestamp', descending: true).snapshots();
  }
}
