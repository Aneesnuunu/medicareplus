import 'package:flutter/material.dart';

import '../Theam/theme.dart';

class U10DoctorDetails extends StatelessWidget {
  const U10DoctorDetails({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppThemeData.primaryColor,
        borderRadius: BorderRadius.circular(15.0), // Set border radius here
      ),
      width: MediaQuery.of(context).size.width,
      child: const Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15, left: 15),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/Images/img_1.png"),
                  radius: 50,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  "Dr. Sarah Johnson\nMD (Doctor of Medicine)\n15 Years Experience",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
