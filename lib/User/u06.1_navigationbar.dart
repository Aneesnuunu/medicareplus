import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:medi_care/Theam/theme.dart';
import 'package:medi_care/User/u06_home_page.dart';
import 'package:medi_care/User/u07_calender.dart';
import 'package:medi_care/User/u08_profile.dart';
import '../provider/u06.1_provider.dart';

class MainHome extends StatelessWidget {
  const MainHome({super.key});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TabProvider(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            extendBody: true,
            body: Consumer<TabProvider>(
              builder: (context, provider, child) {
                return IndexedStack(
                  index: provider.selectedIndex,
                  children: const [
                    HomePage(),
                    CalendarPage(),
                    ProfilePage(),
                  ],
                );
              },
            ),
            bottomNavigationBar: CrystalNavigationBar(
              currentIndex: Provider.of<TabProvider>(context).selectedIndex,
              height: 60,
              unselectedItemColor: Colors.white70,
              backgroundColor: Colors.black.withOpacity(0.1),
              onTap: (index) {
                Provider.of<TabProvider>(context, listen: false).setIndex(index);
              },
              items: [
                CrystalNavigationBarItem(
                  icon: IconlyBold.home,
                  unselectedIcon: IconlyLight.home,
                  selectedColor: AppThemeData.primaryColor,
                ),
                CrystalNavigationBarItem(
                  icon: IconlyBold.calendar,
                  unselectedIcon: IconlyLight.calendar,
                  selectedColor: AppThemeData.primaryColor,
                ),
                CrystalNavigationBarItem(
                  icon: IconlyBold.user_2,
                  unselectedIcon: IconlyLight.user,
                  selectedColor: AppThemeData.primaryColor,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
