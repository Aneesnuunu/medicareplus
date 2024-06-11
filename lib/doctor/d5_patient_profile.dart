import 'package:flutter/material.dart';
import 'package:medi_care/doctor/u15_prescription_sheet.dart';
import '../Theam/theme.dart';
import '../widget/appbar.dart';
import '../widget/d5_patient_profile_field.dart';

class PatientProfilePage extends StatelessWidget {
  final String userName;
  final String age;
  final String profileImageUrl;
  final String email;
  final String phone;
  final String place;
  final String gender;
  final String blood;
  final String size;
  final String date;
  final String appointmentId; // Add appointmentId as a parameter
  final String userId;
  const PatientProfilePage({
    super.key,
    required this.userName,
    required this.age,
    required this.profileImageUrl,
    required this.email,
    required this.phone,
    required this.place,
    required this.gender,
    required this.blood,
    required this.size,
    required this.date,
    required this.appointmentId, // Initialize appointmentId
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Patient Profile",
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 70,
                    backgroundImage: profileImageUrl.isNotEmpty
                        ? NetworkImage(profileImageUrl)
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileField(
                      label: "Name",
                      value: userName,
                    ),
                    ProfileField(
                      label: "Email",
                      value: email,
                    ),
                    ProfileField(
                      label: "Age",
                      value: age,
                    ),
                    ProfileField(
                      label: "Place",
                      value: place,
                    ),
                    ProfileField(
                      label: "Gender",
                      value: gender,
                    ),
                    ProfileField(
                      label: "Blood Group",
                      value: blood,
                    ),
                    ProfileField(
                      label: "Size",
                      value: size,
                    ),
                    ProfileField(
                      label: "Phone",
                      value: phone,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the PrescriptionSheet page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrescriptionSheet(
                            name: userName,
                            age: age,
                            place: place,
                            date: date,
                            appointmentId: appointmentId, // Pass appointment ID
                            userId: userId,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(11),
                        ),
                      ),
                      backgroundColor: AppThemeData.primaryColor,
                    ),
                    child: const Text(
                      "Start Consultation",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

