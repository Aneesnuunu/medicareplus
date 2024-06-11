
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ProfilePageModel extends ChangeNotifier {
  final User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('User');

  String? _profileImageUrl;
  Map<String, dynamic>? _userData; // Store user data locally

  String? get profileImageUrl => _profileImageUrl;

  ProfilePageModel() {
    fetchUserData(); // Fetch user data initially
  }

  Future<void> fetchUserData() async {
    final docSnapshot = await usersCollection.doc(user?.uid).get();
    _userData = docSnapshot.data() as Map<String, dynamic>?;

    _profileImageUrl = _userData?['profileImageUrl'];
    notifyListeners();
  }

  Future<void> updateProfileField(String field, String value) async {
    try {
      await usersCollection.doc(user?.uid).update({field: value});
      // Update local user data
      _userData?[field] = value;
      notifyListeners(); // Notify UI of changes
    } catch (e) {
      // print("Error updating $field: $e");
    }
  }

// Add getter methods for other user fields if needed
}

