import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../doctor/d0_main_page.dart';

class DoctorLoginProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> signIn(String email, String password, BuildContext context) async {
    try {
      final ref = await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Retrieve user data from Firestore
      final userData = await FirebaseFirestore.instance
          .collection('Doctor')
          .doc(ref.user!.uid)
          .get();

      // Check if user is a doctor
      if (userData.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logged in successfully'),
            duration: Duration(seconds: 2), //  set duration
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DoctorNavigationBar(),
          ),
        );
      } else {
        // User is not authorized to access doctor features
        await _auth.signOut();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Access denied. Not a doctor.'),
            duration: Duration(seconds: 2), //  set duration
          ),
        );
      }
    } catch (e) {
      _errorMessage = 'Invalid email or password';
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
    }
  }
}
