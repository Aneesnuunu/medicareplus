import 'package:flutter/material.dart';

class PrescriptionModel extends ChangeNotifier {
  bool _isUploading = false;

  bool get isUploading => _isUploading;

  void setUploading(bool uploading) {
    _isUploading = uploading;
    notifyListeners();
  }
}
