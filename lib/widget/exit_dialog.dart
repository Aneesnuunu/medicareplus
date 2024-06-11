import 'package:flutter/material.dart';
import 'package:medi_care/Theam/theme.dart';

class ExitDialog {
  static Future<bool> showExitConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog( backgroundColor: AppThemeData.backgroundBlack,
        title: const Text("Exit App",style: TextStyle(color: Colors.white),),
        content: const Text("Do you want to exit the app?",style: TextStyle(color: Colors.white),),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("OK"),
          ),
        ],
      ),
    ) ?? false;
  }
}
