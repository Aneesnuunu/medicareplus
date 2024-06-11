import 'package:flutter/material.dart';
import '../Theam/theme.dart';
import '../widget/carousel.dart';
import '../widget/d_drawer.dart';
import 'd2.1_tomarrow_appointment.dart';
import 'd2.2_day_after_tomarrow_appointment.dart';
import 'd2_today_appointment.dart';

class DoctorHomePage extends StatelessWidget {
  const DoctorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Hi Doctor",
            style: TextStyle(
                color: AppThemeData.primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: AppThemeData.primaryColor),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const DoctorDrawer(),  // Use the DoctorDrawer widget here
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
             const Carousel(),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            title: const Text(
              'My Today Appointment',
              style: TextStyle(color: Colors.white),
            ),
            tileColor: AppThemeData.primaryColor,
            onTap: () {
              Navigator.push(
                context,

                MaterialPageRoute(builder: (context) => DoctorAppointmentsPage(context: context,)),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            leading: const Icon(Icons.calendar_today, color: Colors.white),
            trailing: const Icon(Icons.arrow_forward, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            title: const Text(
              'My Tomorrow Appointment',
              style: TextStyle(color: Colors.white),
            ),
            tileColor: AppThemeData.primaryColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TomorrowAppointmentsPage(context: context,)),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            leading: const Icon(Icons.calendar_today, color: Colors.white),
            trailing: const Icon(Icons.arrow_forward, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            title: const Text(
              'Day After Tomorrow Appointment',
              style: TextStyle(color: Colors.white),
            ),
            tileColor: AppThemeData.primaryColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DayAfterTomorrowAppointmentsPage(context: context,)),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            leading: const Icon(Icons.calendar_today, color: Colors.white),
            trailing: const Icon(Icons.arrow_forward, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
