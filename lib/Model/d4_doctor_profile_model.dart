import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DoctorProfilePageModel extends ChangeNotifier {
  final User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference doctorCollection =
  FirebaseFirestore.instance.collection('Doctor');

  String? _profileImageUrl;
  Map<String, dynamic>? _doctorData; // Store doctor data locally

  String? get profileImageUrl => _profileImageUrl;

  DoctorProfilePageModel() {
    fetchDoctorData();
  }

  Future<void> fetchDoctorData() async {
    final docSnapshot = await doctorCollection.doc(user?.uid).get();
    _doctorData = docSnapshot.data() as Map<String, dynamic>?;

    _profileImageUrl = _doctorData?['profileImageUrl'];
    notifyListeners();
  }

  Future<void> updateProfileField(String field, String value) async {
    try {
      await doctorCollection.doc(user?.uid).update({field: value});
      // Update local doctor data
      _doctorData?[field] = value;
      notifyListeners(); // Notify UI of changes
    } catch (e) {
      // Handle error
    }
  }

  Future<void> uploadImage(File imageFile) async {
    if (imageFile != null) {
      var storageInstance = FirebaseStorage.instance;

      try {
        var ref = await storageInstance
            .ref()
            .child("profile${user?.uid}/${imageFile.path.split('/').last}")
            .putFile(imageFile);

        var imageUrl = await ref.ref.getDownloadURL();
        await doctorCollection
            .doc(user?.uid)
            .update({'profileImageUrl': imageUrl});
        _profileImageUrl = imageUrl;
        notifyListeners();
      } catch (e) {
        // Handle error
      }
    }
  }
}
