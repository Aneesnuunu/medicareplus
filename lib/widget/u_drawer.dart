import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Theam/theme.dart';
import '../User/u04_login_screen.dart';
import '../User/u08_profile.dart';
import '../User/u12_my_appointments.dart';
import '../User/u13_my_prescriptions.dart';
import '../User/u14_about.dart';
import '../User/u16_absent.dart';

class CustomDrawer extends StatelessWidget {
  final String userId;

  const CustomDrawer({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppThemeData.backgroundBlack,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 150,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: AppThemeData.primaryColor,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.task_alt),
            title: const Text(
              'Appointments',
              style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppointmentDetailsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text(
              'History',
              style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyPrescription(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.event_busy),
            title: const Text(
              'Absent',
              style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FailedAppointmentsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              'My Profile',
              style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_support_outlined),
            title: const Text(
              'Support',
              style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text(
              'About',
              style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutMePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'Logout',
              style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
            ),
            onTap: () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: AppThemeData.backgroundBlack,
                    title: const Text('Logout Confirmation',
                        style: TextStyle(color: Colors.white)),
                    content: const Text('Are you sure you want to logout?',
                        style: TextStyle(color: Colors.white)),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      TextButton(
                        child: const Text('Logout',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  );
                },
              );

              if (shouldLogout == true) {
                // Clear authentication token from SharedPreferences
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('auth_token');

                // Sign out the user from Firebase Authentication
                await FirebaseAuth.instance.signOut();

                // Navigate to the LoginPage
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
