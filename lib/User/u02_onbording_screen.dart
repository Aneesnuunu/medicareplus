import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'u03_login_or_signup.dart';

class OnBoarding extends StatelessWidget {
  final List<Introduction> list = [
    Introduction(
      title: '',
      subTitle:
      'Welcome to our clinic appointment app! Easily book your appointments and manage your health with just a few taps.',
      subTitleTextStyle: GoogleFonts.lato(
        // color: AppThemeData.primaryColor,
        fontSize: 20,
      ),
      imageUrl: 'assets/Images/img_5.png',
    ),
    Introduction(
      title: '',
      subTitle:
      'Never wait in long queues again! Our app lets you schedule appointments with our dedicated doctor conveniently.',
      subTitleTextStyle: GoogleFonts.lato(
        // color: AppThemeData.primaryColor,
        fontSize: 20,
      ),
      imageUrl: 'assets/Images/qq.png',
    ),
    Introduction(
      title: '',
      subTitle:
      'Your time is precious. Let our app simplify your appointment scheduling process. Get started today!',
      subTitleTextStyle: GoogleFonts.lato(
        // color: AppThemeData.primaryColor,
        fontSize: 20,
      ),
      imageUrl: 'assets/Images/time.png',
    ),
  ];

   OnBoarding({super.key}); // Added named key parameter

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return IntroScreenOnboarding(
      introductionList: list.map((intro) {
        return Introduction(
          title: intro.title,
          subTitle: intro.subTitle,
          subTitleTextStyle: intro.subTitleTextStyle,
          imageUrl: intro.imageUrl,
          imageWidth: screenWidth * 0.8, // Adjust the image width dynamically
        );
      }).toList(),
      onTapSkipButton: () {

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LogorSign(), // Navigate to Login/Signup screen
            ),
          );

      },
      backgroudColor: Colors.white,
    );
  }
}
