
import 'package:flutter/material.dart';

class AppointmentModel extends ChangeNotifier {
  // You can add more fields here to manage the state
  List<String> appointments = [];

  void fetchAppointments() {
    // Simulate fetching appointments from a data source (e.g., API or database)
    appointments = ["Appointment 1", "Appointment 2", "Appointment 3"];
    notifyListeners();
  }
}
