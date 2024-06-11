import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Theam/theme.dart';
import '../widget/appbar.dart';

class FailedAppointmentsPage extends StatelessWidget {
  const FailedAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const CustomAppBar(
        title:                    "Failed Appointments",





      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('User')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('failed_appointments')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No Failed Appointments',
                style: TextStyle(color: AppThemeData.primaryColor),
              ),
            );
          } else {
            final failedAppointments = snapshot.data!.docs;
            return ListView.builder(
              itemCount: failedAppointments.length,
              itemBuilder: (context, index) {
                final failedAppointment = failedAppointments[index];
                final failedAppointmentData =
                failedAppointment.data() as Map<String, dynamic>;
                final date = failedAppointmentData['date'] ?? '';
                final dayName = failedAppointmentData['dayName'] ?? '';
                final time = failedAppointmentData['time'] ?? '';

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: AppThemeData.primaryColor,
                    child: ListTile(
                      leading: const Icon(Icons.event_busy, color: Colors.white),
                      title: Text(
                        date,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        dayName,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: Text(
                        time,
                        style: const TextStyle(color: Colors.white),
                      ),
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
