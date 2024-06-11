// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import '../Theam/theme.dart';
// import '../widget/appbar.dart';
//
// class AppointmentDetailsPage extends StatelessWidget {
//   const AppointmentDetailsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(
//         title: "Appointments",
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('User')
//             .doc(FirebaseAuth.instance.currentUser?.uid)
//             .collection('appointments')
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final appointments = snapshot.data!.docs;
//             return ListView.builder(
//               itemCount: appointments.length,
//               itemBuilder: (context, index) {
//                 final appointment = appointments[index];
//                 final appointmentData =
//                     appointment.data() as Map<String, dynamic>;
//                 final appointmentId = appointment.id; // Get the appointment ID
//                 final date = appointmentData['date'];
//                 final dayName = appointmentData['dayName'];
//                 final time = appointmentData['time'];
//
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                     color: AppThemeData.primaryColor,
//                     child: Column(
//                       children: [
//                         ListTile(
//                           leading: const Icon(Icons.event, color: Colors.white),
//                           title: Text(
//                             DateFormat('yyyy-MM-dd')
//                                 .format(DateTime.parse(date)),
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '$dayName',
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           trailing: Text(
//                             '$time',
//                             style: const TextStyle(
//                               color: Colors.white,
//                             ),
//                           ),
//                           onTap: () {
//                             // Handle onTap event if needed
//                           },
//                         ),
//                         Text(
//                           appointmentId,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         SizedBox(
//                           width: double.infinity, // Set width to match parent
//                           child: ElevatedButton(
//                             onPressed: () {
//                               // Show confirmation dialog
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     backgroundColor:
//                                         AppThemeData.backgroundBlack,
//                                     title: const Text(
//                                       'Confirm Cancellation',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     content: const Text(
//                                       'Are you sure you want to cancel this appointment?',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     actions: <Widget>[
//                                       TextButton(
//                                         onPressed: () {
//                                           Navigator.of(context).pop();
//                                         },
//                                         child: const Text(
//                                           'No',
//                                           style: TextStyle(
//                                               color: AppThemeData.primaryColor),
//                                         ),
//                                       ),
//                                       TextButton(
//                                         onPressed: () {
//                                           // Delete the appointment
//                                           FirebaseFirestore.instance
//                                               .collection('User')
//                                               .doc(FirebaseAuth
//                                                   .instance.currentUser?.uid)
//                                               .collection('appointments')
//                                               .doc(appointment.id)
//                                               .delete()
//                                               .then((value) {
//                                             // Update UI by removing the appointment from the list
//                                             ScaffoldMessenger.of(context)
//                                                 .showSnackBar(
//                                               const SnackBar(
//                                                 content: Text(
//                                                     'Appointment canceled successfully'),
//                                               ),
//                                             );
//                                           }).catchError((error) {
//                                             ScaffoldMessenger.of(context)
//                                                 .showSnackBar(
//                                               SnackBar(
//                                                 content: Text(
//                                                     'Failed to cancel appointment: $error'),
//                                                 backgroundColor: Colors.red,
//                                               ),
//                                             );
//                                           });
//                                           Navigator.of(context).pop();
//                                         },
//                                         child: const Text('Yes'),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.red,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                             ),
//                             child: const Text(
//                               'Cancel Appointment',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../Theam/theme.dart';
import '../widget/appbar.dart';

class AppointmentDetailsPage extends StatelessWidget {
  const AppointmentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Appointments",
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('User')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('appointments')
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
                final appointmentData = appointment.data() as Map<String, dynamic>;
                final appointmentId = appointment.id; // Get the appointment ID
                final date = appointmentData['date'];
                final dayName = appointmentData['dayName'];
                final time = appointmentData['time'];

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
                            DateFormat('yyyy-MM-dd').format(DateTime.parse(date)),
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
                            // Handle onTap event if needed
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
                        SizedBox(
                          width: double.infinity, // Set width to match parent
                          child: ElevatedButton(
                            onPressed: () {
                              // Show confirmation dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: AppThemeData.backgroundBlack,
                                    title: const Text(
                                      'Confirm Cancellation',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: const Text(
                                      'Are you sure you want to cancel this appointment?',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'No',
                                          style: TextStyle(color: AppThemeData.primaryColor),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          try {
                                            final currentUser = FirebaseAuth.instance.currentUser;
                                            final userDoc = FirebaseFirestore.instance
                                                .collection('User')
                                                .doc(currentUser?.uid)
                                                .collection('appointments')
                                                .doc(appointment.id);

                                            // Delete the appointment from user's appointments
                                            await userDoc.delete();

                                            final dateKey = DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
                                            final docRef = FirebaseFirestore.instance
                                                .collection('doctor_availability')
                                                .doc(dateKey);

                                            // Remove the time slot from unavailable slots
                                            await docRef.update({
                                              'unavailableTimeSlots': FieldValue.arrayRemove([time])
                                            });

                                            // Show success message
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Appointment canceled successfully'),
                                              ),
                                            );
                                          } catch (error) {
                                            // Show error message
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Failed to cancel appointment: $error'),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          } finally {
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Cancel Appointment',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
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
