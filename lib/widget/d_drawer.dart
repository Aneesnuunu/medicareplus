import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Theam/theme.dart';
import '../User/u04_login_screen.dart';
import '../User/u14_about.dart';
import '../doctor/d4_profile.dart';
import '../doctor/d6_leave.dart';
import '../doctor/d7_carousel_change.dart';
import '../doctor/d8_my_patients.dart';


class DoctorDrawer extends StatelessWidget {
  const DoctorDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppThemeData.backgroundBlack,

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(height: 150,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: AppThemeData.primaryColor,
              ),
              child: Text(
                'Doctor Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.home),
          //   title: Text(
          //     'Home',
          //     style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //     // Add navigation or actions here if needed
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              'Profile',
              style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  const DoctorProfilePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text(
              'About',
              style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
            ),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  const AboutMePage(),
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
            onTap: ()  async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: AppThemeData.backgroundBlack,
                    title: const Text('Logout Confirmation',style: TextStyle(color: Colors.white),),
                    content: const Text('Are you sure you want to logout?',style: TextStyle(color: Colors.white),),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel',style: TextStyle(color: Colors.white),),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      TextButton(
                        child: const Text('Logout',style: TextStyle(color: Colors.white),),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  );
                },
              );

              if (shouldLogout == true) {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                      (route) => false,
                );
              }
            },

          ),
          const SizedBox(height: 10,)
,
          ListTile(
            leading: const Icon(Icons.event_busy_outlined),
            title: const Text(
              'Take a Leave',
              style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
            ),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>   const DoctorAvailabilityManagementPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 10,)
          ,
          ListTile(
            leading: const Icon(Icons.view_carousel),
            title: const Text(
              'Carousel Change',
              style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
            ),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>    ImageUploadPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 10,)
          ,
          ListTile(
            leading: const Icon(Icons.groups),
            title: const Text(
              'My Patients',
              style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
            ),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>    UserListPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
