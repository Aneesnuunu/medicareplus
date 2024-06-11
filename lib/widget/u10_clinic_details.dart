import 'package:flutter/material.dart';
import 'package:medi_care/Theam/theme.dart';

class U10ClinicDetails extends StatelessWidget {
  const U10ClinicDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppThemeData.primaryColor,
        borderRadius: BorderRadius.circular(15.0), // Set border radius here
      ),
      child: const Column(
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 10),
              Icon(
                Icons.local_hospital,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                "Clinic Details",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Medi-Care Clinic,\nNumber 186/165,9th Main Road,\n14th Cross, Sector 6, HSR Layout",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
