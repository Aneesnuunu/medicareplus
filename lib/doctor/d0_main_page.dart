import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/d_main_model.dart';
import '../Theam/theme.dart';
import '../User/u07_calender.dart';
import 'd1_home.dart';
import 'd4_profile.dart';

class DoctorNavigationBar extends StatelessWidget {
  const DoctorNavigationBar({super.key});

  static final List<Widget> _widgetOptions = [
    const DoctorHomePage(),
    const CalendarPage(),
    const DoctorProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavigationModel(),
      child: Scaffold(
        body: Consumer<NavigationModel>(
          builder: (context, navigationModel, child) {
            return _widgetOptions.elementAt(navigationModel.selectedIndex);
          },
        ),
        bottomNavigationBar: Consumer<NavigationModel>(
          builder: (context, navigationModel, child) {
            return BottomNavigationBar(
              backgroundColor: AppThemeData.primaryColor,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: 'Calendar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: navigationModel.selectedIndex,
              selectedItemColor: Colors.white,
              onTap: (index) {
                navigationModel.setSelectedIndex(index);
              },
            );
          },
        ),
      ),
    );
  }
}
