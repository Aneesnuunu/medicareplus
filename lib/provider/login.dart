import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword() async {
    final authenticationInstance = FirebaseAuth.instance;

    await authenticationInstance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }
}
