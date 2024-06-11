import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_care/User/u04_login_screen.dart';

import '../Theam/theme.dart';
import '../widget/appbar.dart';
import '../widget/text_form_field.dart';

class SiginPage extends StatefulWidget {
  const SiginPage({super.key});

  @override
  _SiginPageState createState() => _SiginPageState();
}

class _SiginPageState extends State<SiginPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController heightweightController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? selectedGender;
  String? selectedBloodGroup;

  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> bloodGroupOptions = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Registration",
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.only(left: 11, right: 10),
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormFieldName(
                    controller: nameController,
                    hintText: 'Name*',
                    prefixIcon: Icons.person,
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    hintText: 'Email Address*',
                    prefixIcon: Icons.email_outlined,
                  ),
                  CustomTextFormFieldPassword(
                    controller: passwordController,
                    hintText: 'Password*',
                    prefixIcon: Icons.lock_outline,
                  ),
                  CustomTextFormFieldAge(
                    controller: ageController,
                    hintText: 'Age*',
                    prefixIcon: Icons.calendar_today_outlined,
                  ),
                  CustomTextFormField(
                    controller: placeController,
                    hintText: 'Place*',
                    prefixIcon: Icons.location_on_outlined,
                  ),
                  CustomTextFormFieldGender(
                    selectedGender: selectedGender,
                    genderOptions: genderOptions,
                    onChanged: (newValue) {
                      setState(() {
                        selectedGender = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormFieldBlood(
                    selectedBloodGroup: selectedBloodGroup,
                    bloodGroupOptions: bloodGroupOptions,
                    onChanged: (newValue) {
                      setState(() {
                        selectedBloodGroup = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: heightweightController,
                    hintText: 'Height/Weight',
                    prefixIcon: Icons.format_size_outlined,
                  ),
                  CustomTextFormFieldPhone(
                    controller: phoneController,
                    hintText: 'Phone*',
                    prefixIcon: Icons.phone,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (nameController.text.isEmpty ||
                                  emailController.text.isEmpty ||
                                  passwordController.text.isEmpty ||
                                  ageController.text.isEmpty ||
                                  placeController.text.isEmpty ||
                                  selectedGender == null ||
                                  phoneController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Please fill all required fields'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                return;
                              }

                              setState(() {
                                _isLoading = true;
                              });

                              final authenticationInstance =
                                  FirebaseAuth.instance;
                              final dbInstance = FirebaseFirestore.instance;

                              try {
                                final ref = await authenticationInstance
                                    .createUserWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text);

                                var userId = ref.user!.uid;

                                var data = {
                                  "name": nameController.text,
                                  "email": emailController.text,
                                  "password": passwordController.text,
                                  "age": ageController.text,
                                  "place": placeController.text,
                                  "gender": selectedGender,
                                  "blood": selectedBloodGroup,
                                  "size": heightweightController.text,
                                  "phone": phoneController.text,
                                };

                                await dbInstance
                                    .collection("User")
                                    .doc(userId)
                                    .set(data);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Registration successfully'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ));
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Registration failed: ${e.toString()}'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11))),
                              backgroundColor: AppThemeData.primaryColor,
                            ),
                            child: const Text(
                              "Create an Account",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "I have already an account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppThemeData.primaryColor,
                        fontSize: 17,
                      ),
                    ),
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
