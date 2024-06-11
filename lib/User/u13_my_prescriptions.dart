import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:medi_care/User/u13.9_prescription_image.dart';
import '../Theam/theme.dart';
import '../widget/appbar.dart';

class MyPrescription extends StatelessWidget {
  const MyPrescription({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Prescriptions",
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('User')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('success_appointments') // Update collection reference
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final appointments = snapshot.data!.docs;
            return ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                final appointmentData =
                appointment.data() as Map<String, dynamic>;
                final appointmentId = appointment.id; // Get the appointment ID
                final date = appointmentData['date'];
                final dayName = appointmentData['dayName'];
                final time = appointmentData['time'];
                final prescriptionUrl = appointmentData['prescription'] ?? '';

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: AppThemeData.primaryColor,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.event, color: Colors.white),
                          title: Text(
                            DateFormat('yyyy-MM-dd')
                                .format(DateTime.parse(date)),
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$dayName',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          trailing: Text(
                            '$time',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrescriptionImagePage(
                                  prescriptionUrl: prescriptionUrl,
                                ),
                              ),
                            );
                          },
                        ),
                        Text(
                          appointmentId,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
