import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageUploadModel extends ChangeNotifier {
  final List<File> images = [];
  final ImagePicker picker = ImagePicker();
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isUploading = false;

  Future<void> pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      images.clear();
      images.addAll(pickedFiles.map((file) => File(file.path)));
      notifyListeners();
    }
  }

  Future<void> deleteImage(String documentId) async {
    await firestore.collection('carousel_images').doc(documentId).delete();
  }

  Future<void> uploadImages() async {
    isUploading = true;
    notifyListeners();

    for (var image in images) {
      final fileName = image.path.split('/').last;
      final ref = storage.ref().child('carousel_images').child(fileName);
      await ref.putFile(image);
      final downloadUrl = await ref.getDownloadURL();
      await firestore.collection('carousel_images').add({'url': downloadUrl});
    }

    isUploading = false;
    notifyListeners();
  }
}
