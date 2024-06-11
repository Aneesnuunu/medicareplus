import 'package:flutter/material.dart';

class DoctorAvailabilityModel extends ChangeNotifier {
  DateTime? selectedDate;
  Set<String> unavailableTimeSlots = {};

  void updateSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void updateUnavailableTimeSlots(Set<String> timeSlots) {
    unavailableTimeSlots = timeSlots;
    notifyListeners();
  }
}
