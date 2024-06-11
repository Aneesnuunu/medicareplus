import 'package:flutter/material.dart';

class BookAppointmentModel extends ChangeNotifier {
  DateTime? selectedDate;
  String? selectedTime;

  void setDate(DateTime date) {
    selectedDate = date;
    selectedTime = null; // Reset selected time when date changes
    notifyListeners();
  }

  void setTime(String time) {
    selectedTime = time;
    notifyListeners();
  }
}
