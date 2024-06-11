import 'package:flutter/material.dart';

import '../widget/appbar.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:CustomAppBar(
        title:          "About",




      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Dr. Sarah Johnson, MD',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Dr. Sarah Johnson, MD, brings 15 years of expertise in internal medicine, offering compassionate care and staying abreast of medical advancements. With a knack for clear communication, she guides patients toward optimal health and well-being.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              Text(
                'About Medicare Clinic',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Medicare Clinic is a small healthcare facility dedicated to providing personalized medical care to patients. With a focus on gastroenterology and liver health, our clinic offers comprehensive diagnosis and treatment services. Our goal is to ensure every patient receives individualized attention and the highest quality of care.',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 40),
              Text(
                'Clinic Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Clinic Name: MediCare Clinic',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                'Location: Number 186/165, 9th Main Road, 14th Cross, Sector 6, HSR Layout',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
