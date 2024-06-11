import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentsProvider extends ChangeNotifier {
  List<DocumentSnapshot> _appointments = [];
  bool _isLoading = true;
  String _error = '';

  List<DocumentSnapshot> get appointments => _appointments;
  bool get isLoading => _isLoading;
  String get error => _error;

  AppointmentsProvider() {
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    try {
      _isLoading = true;
      notifyListeners();

      DateTime currentDate = DateTime.now();
      String formattedCurrentDate = currentDate.toIso8601String().split('T')[0];

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('User')
          .where('appointments.date', isEqualTo: formattedCurrentDate)
          .get();

      _appointments = snapshot.docs;
      _isLoading = false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
    } finally {
      notifyListeners();
    }
  }
}
