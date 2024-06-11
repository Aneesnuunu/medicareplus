// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class MyAppointmentsModel extends ChangeNotifier {
//   List<Map<String, dynamic>> _appointments = [];
//
//   List<Map<String, dynamic>> get appointments => _appointments;
//
//   Future<void> fetchAppointments() async {
//     try {
//       final docSnapshot = await FirebaseFirestore.instance
//           .collection('User')
//           .doc(FirebaseAuth.instance.currentUser?.uid)
//           .get();
//
//       _appointments = List<Map<String, dynamic>>.from(
//           docSnapshot.data()?['appointments'] ?? []);
//
//       notifyListeners();
//     } catch (error) {
//       print('Error fetching appointments: $error');
//     }
//   }
//
//   Future<void> cancelAppointment(int index) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('User')
//           .doc(FirebaseAuth.instance.currentUser?.uid)
//           .update({
//         'appointments': FieldValue.arrayRemove([_appointments[index]])
//       });
//
//       _appointments.removeAt(index);
//       notifyListeners();
//     } catch (error) {
//       print('Error cancelling appointment: $error');
//     }
//   }
// }
