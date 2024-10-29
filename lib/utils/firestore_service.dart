import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  // GET DATA FROM COLLECTION
  static Future<Map<String, dynamic>?> getCollectionData(
      String collectionName) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty
          ? querySnapshot.docs.first.data() as Map<String, dynamic>
          : null;
    } catch (error) {
      print('Failed to getting data : $error');
      rethrow; // Rethrow or handle the error as needed
    }
  }

  // GET DATA FROM COLLECTION STREAM
  static Stream<List<Map<String, dynamic>>> getCollectionDataStream(
      String collectionName) {
    try {
      return FirebaseFirestore.instance
          .collection(collectionName)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return doc.data();
        }).toList();
      });
    } catch (error) {
      print('Failed to get companies stream: $error');
      rethrow; // Rethrow or handle the error as needed
    }
  }
}
