import 'package:flutter/material.dart';
import 'package:medi_care/User/u09_book_appointment.dart';
import 'package:provider/provider.dart';
import 'dart:io'; // Import for exit(0)
import '../Theam/theme.dart';
import '../widget/carousel.dart';
import '../widget/doctor_details_container_homepage.dart';
import '../widget/exit_dialog.dart';
import '../widget/u_drawer.dart';

class HomePageModel extends ChangeNotifier {}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageModel(), // Provide the data model
      child: WillPopScope(
        onWillPop: () async {
          bool shouldExit = await ExitDialog.showExitConfirmationDialog(context);
          if (shouldExit) {
            exit(0);
          }
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                "Welcome to MediCare",
                style: TextStyle(
                  color: AppThemeData.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: AppThemeData.primaryColor,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
          drawer: const CustomDrawer(userId: ''), // Add the custom drawer widget here
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Carousel(),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(height: 250, child: DoctorDetails()),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserAppointmentBookingPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                      ),
                      backgroundColor: AppThemeData.primaryColor,
                    ),
                    child: const Text(
                      "Book Appointment",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
