import 'package:flutter/material.dart';
import '../Theam/theme.dart';

class PrescriptionImagePage extends StatelessWidget {
  final String prescriptionUrl;

  const PrescriptionImagePage({super.key, required this.prescriptionUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: prescriptionUrl.isNotEmpty
            ? Image.network(prescriptionUrl)
            : const Text(
                'No Prescription Available',
                style:
                    TextStyle(color: AppThemeData.primaryColor, fontSize: 25),
              ),
      ),
    );
  }
}
