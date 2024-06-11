import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Theam/theme.dart';
import '../widget/appbar.dart';
import 'd5_patient_profile.dart';

class DoctorAppointmentsPage extends StatelessWidget {
  final BuildContext context;

  const DoctorAppointmentsPage({required this.context, super.key});

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    String formattedCurrentDate = currentDate.toIso8601String().split('T')[0];

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'My Appointments',
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('User').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final userName = user['name'];
                final age = user['age'];
                final userId = user.id;

                final userData = user.data() as Map<String, dynamic>?;
                final profileImageUrl =
                userData != null && userData.containsKey('profileImageUrl')
                    ? userData['profileImageUrl']
                    : '';

                final email = userData?['email'] ?? '';
                final phone = userData?['phone'] ?? '';
                final place = userData?['place'] ?? '';
                final gender = userData?['gender'] ?? '';
                final blood = userData?['blood'] ?? '';
                final size = userData?['size'] ?? '';

                final appointments = user.reference
                    .collection('appointments')
                    .where('date', isEqualTo: formattedCurrentDate)
                    .snapshots();

                return StreamBuilder<QuerySnapshot>(
                  stream: appointments,
                  builder: (context, appointmentSnapshot) {
                    if (appointmentSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (appointmentSnapshot.hasError) {
                      return Center(
                          child: Text('Error: ${appointmentSnapshot.error}'));
                    } else {
                      final appointmentDocs =
                      appointmentSnapshot.data!.docs.toList();
                      appointmentDocs.sort((a, b) =>
                          (a['time'] as String).compareTo(b['time'] as String));

                      return Column(
                        children: appointmentDocs.map((appointment) {
                          final appointmentData =
                          appointment.data() as Map<String, dynamic>;
                          final appointmentId = appointment.id;
                          final date = appointmentData['date'] as String?;
                          final time = appointmentData['time'] as String?;

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PatientProfilePage(
                                      userName: userName,
                                      age: age,
                                      profileImageUrl: profileImageUrl,
                                      email: email,
                                      phone: phone,
                                      place: place,
                                      gender: gender,
                                      blood: blood,
                                      size: size,
                                      date: date ?? '',
                                      appointmentId: appointmentId,
                                      userId: userId,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                color: AppThemeData.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: profileImageUrl.isNotEmpty
                                          ? CircleAvatar(
                                        backgroundImage:
                                        NetworkImage(profileImageUrl),
                                      )
                                          : const CircleAvatar(),
                                      title: Text(
                                        userName,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        '$age',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            time ?? '',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          PopupMenuButton<String>(
                                            onSelected: (value) async {
                                              if (value == 'absent') {
                                                final failedAppointmentData = {
                                                  ...appointmentData,
                                                  'userId': userId,
                                                  'appointmentId':
                                                  appointmentId,
                                                };

                                                await FirebaseFirestore.instance
                                                    .collection('User')
                                                    .doc(userId)
                                                    .collection(
                                                    'failed_appointments')
                                                    .add(failedAppointmentData);

                                                await FirebaseFirestore.instance
                                                    .collection('User')
                                                    .doc(userId)
                                                    .collection('appointments')
                                                    .doc(appointmentId)
                                                    .delete();
                                              } else if (value ==
                                                  'cancel') {
                                                await FirebaseFirestore.instance
                                                    .collection('User')
                                                    .doc(userId)
                                                    .collection('appointments')
                                                    .doc(appointmentId)
                                                    .delete();
                                              }
                                            },
                                            itemBuilder:
                                                (BuildContext context) {
                                              return [
                                                const PopupMenuItem<String>(
                                                  value: 'absent',
                                                  child: Text('Mark as Absent'),
                                                ),
                                                const PopupMenuItem<String>(
                                                  value: 'cancel',
                                                  child: Text('Cancel Appointment'),
                                                ),
                                              ];
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      appointmentId,
                                      style: const TextStyle(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
