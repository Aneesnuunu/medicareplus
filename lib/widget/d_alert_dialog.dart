import 'package:flutter/material.dart';
import 'package:medi_care/Theam/theme.dart';

class DoctorConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const DoctorConfirmationDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppThemeData.backgroundBlack,
      title: const Text('Confirm', style: TextStyle(color: Colors.white)),
      content: const Text(
        'Are you sure you want to stop the consultation?',
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop(); // Close the dialog
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppThemeData.primaryColor,
          ),
          child: const Text('Yes', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
