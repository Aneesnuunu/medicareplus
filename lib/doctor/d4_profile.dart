import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Model/d4_doctor_profile_model.dart';
import '../widget/appbar.dart';
import '../widget/profile_field.dart';

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DoctorProfilePageModel(),
      child: _DoctorProfilePageContent(),
    );
  }
}

class _DoctorProfilePageContent extends StatefulWidget {
  @override
  _DoctorProfilePageContentState createState() =>
      _DoctorProfilePageContentState();
}

class _DoctorProfilePageContentState extends State<_DoctorProfilePageContent> {
  final _imagePicker = ImagePicker();
  final _scrollController = ScrollController(); // Scroll controller

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<DoctorProfilePageModel>(context);

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Doctor Profile",
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        controller: _scrollController, // Assign scroll controller
        child: Padding(
          padding: const EdgeInsets.only(left: 11, right: 10),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 70,
                          backgroundImage: model.profileImageUrl != null
                              ? NetworkImage(model.profileImageUrl!)
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () async {
                            var img = await _imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (img != null) {
                              File imageFile = File(img.path);
                              await model.uploadImage(imageFile);
                              // Scroll down after uploading image
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          icon: const Icon(Icons.camera),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  FutureBuilder<DocumentSnapshot>(
                    future: model.doctorCollection.doc(model.user?.uid).get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Map<String, dynamic>? doctorData =
                        snapshot.data?.data() as Map<String, dynamic>?;
                        return Column(
                          children: [
                            ProfileField(
                              label: "Name",
                              value: doctorData?['name'],
                              onEdit: (newValue) {
                                model.updateProfileField('name', newValue);
                              },
                            ),
                            ProfileField(
                              label: "Email Address",
                              value: doctorData?['email'],
                              // Do not provide an onEdit callback for the email field
                            ),
                            ProfileField(
                              label: "Age",
                              value: doctorData?['age'],
                              onEdit: (newValue) {
                                model.updateProfileField('age', newValue);
                              },
                            ),
                            ProfileField(
                              label: "Place",
                              value: doctorData?['place'],
                              onEdit: (newValue) {
                                model.updateProfileField('place', newValue);
                              },
                            ),
                            ProfileField(
                              label: "Gender",
                              value: doctorData?['gender'],
                              onEdit: (newValue) {
                                model.updateProfileField('gender', newValue);
                              },
                            ),
                            ProfileField(
                              label: "Blood Group",
                              value: doctorData?['blood'],
                              onEdit: (newValue) {
                                model.updateProfileField('blood', newValue);
                              },
                            ),
                            ProfileField(
                              label: "Size",
                              value: doctorData?['size'],
                              onEdit: (newValue) {
                                model.updateProfileField('size', newValue);
                              },
                            ),
                            ProfileField(
                              label: "Phone",
                              value: doctorData?['phone'],
                              onEdit: (newValue) {
                                model.updateProfileField('phone', newValue);
                              },
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
