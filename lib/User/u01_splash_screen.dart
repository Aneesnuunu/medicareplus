// import 'package:flutter/material.dart';
//
// import 'u02_onbording_screen.dart';
//
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Set duration to 2 seconds
//     Future.delayed(const Duration(seconds: 2), () {
//       // Determine where to navigate based on login state
//
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => OnBoarding()),
//       );
//     });
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SizedBox(
//           height: 200,
//           width: 200,
//           child: Image.asset('assets/Images/logo.jpg'),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:medi_care/User/u06.1_navigationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'u02_onbording_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Set duration to 2 seconds
    Future.delayed(const Duration(seconds: 2), () async {
      // Check SharedPreferences for authentication data
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString('auth_token');

      // Determine where to navigate based on login state
      if (authToken != null) {
        // User is authenticated, navigate to home or any other authenticated screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainHome()),
        );
      } else {
        // User is not authenticated, navigate to the login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnBoarding()),
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset('assets/Images/logo.jpg'),
        ),
      ),
    );
  }
}
