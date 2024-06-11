import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Theam/theme.dart';
import '../Model/u09_book_appoi_model.dart';

class DateContainer extends StatelessWidget {
  final DateTime date;
  final BookAppointmentModel model;

  const DateContainer({
    super.key,
    required this.date,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = model.selectedDate != null &&
        model.selectedDate!.isAtSameMomentAs(date);

    return GestureDetector(
      onTap: () {
        model.setDate(date);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: MediaQuery.of(context).size.width * 0.28, // Adjust width to fit 3 in a row with spacing
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : AppThemeData.primaryColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.white,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('yyyy-MM-dd').format(date),
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.black : Colors.white,
              ),
            ),
            Text(
              DateFormat('EEEE').format(date),
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
