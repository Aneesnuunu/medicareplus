import 'package:flutter/material.dart';
import 'package:medi_care/Theam/theme.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppThemeData.primaryColor,
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
              Text(
                "Dr. Sarah Johnson\nMD (Doctor of Medicine)\n15 Years Experience",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Dr. Sarah Johnson, MD, brings 15 years of expertise in internal medicine, offering compassionate care and staying abreast of medical advancements. With a knack for clear communication, she guides patients toward optimal health and well-being.",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
