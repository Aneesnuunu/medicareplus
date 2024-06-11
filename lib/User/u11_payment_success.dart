import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medi_care/Theam/theme.dart';
import 'u06.1_navigationbar.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'animation/paym.json',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
              repeat: true,
            ),
            // const SizedBox(height: 50),
            const Text(
              'Thanks For Your Support',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            const SizedBox(height: 30),
            const Text(
              'Goto "My Appointment" to see\nyour Appointment Details ',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainHome(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(11))),
                  backgroundColor: AppThemeData.primaryColor,
                ),
                child: const Text(
                  "Ok",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
