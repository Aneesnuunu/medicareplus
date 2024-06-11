import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProfilePageModel extends ChangeNotifier {
  final User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('User');

  String? _profileImageUrl;
  Map<String, dynamic>? _userData;
  bool _isLoading = false;

  String? get profileImageUrl => _profileImageUrl;
  Map<String, dynamic>? get userData => _userData;
  bool get isLoading => _isLoading;

  ProfilePageModel() {
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final docSnapshot = await usersCollection.doc(user?.uid).get();
    _userData = docSnapshot.data() as Map<String, dynamic>?;

    _profileImageUrl = _userData?['profileImageUrl'];
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> updateProfileField(String field, String value) async {
    try {
      await usersCollection.doc(user?.uid).update({field: value});
      _userData?[field] = value;
      notifyListeners();
    } catch (e) {
      // print('Error updating profile field: $e');
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
        await usersCollection
            .doc(user?.uid)
            .update({'profileImageUrl': imageUrl});
        _profileImageUrl = imageUrl;
        notifyListeners();
      } catch (e) {
        // print('Error uploading image: $e');
      }
    }
  }
}
