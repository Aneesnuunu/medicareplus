import 'package:calendar_flutter_aj/calender_flutter.dart';
import 'package:flutter/material.dart';
import 'package:medi_care/Theam/theme.dart';
import '../widget/appbar.dart';
import 'u06.1_navigationbar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Calendar",
        onBackButtonPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainHome()), // Navigate to HomePage
          );
        },
      ),
      body: Center(
        child: CalendarFlutterAj(
          selectedDate: (selectedDate) {
            // Handle selected date
          },
          backArrow: const DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0xffAED2EC),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_left_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          forwardArrow: const DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0xffAED2EC),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_right_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          calenderBackgroundColor: AppThemeData.primaryColor,
          showCalenderGradient: true,
          showMonthGradient: true,
          showYearGradient: true,
          dividerColor: AppThemeData.primaryColor,
          calenderGradient: const LinearGradient(
            colors: [
              Color(0xff5F94B9),
              Color(0xff6094BA),
              Color(0xff85A3CB),
              Color(0xff8DA4CE),
              Color(0xff8898CE),
              Color(0xff8395CD),
            ],
          ),
          yearGradient: const LinearGradient(
            colors: [
              Color(0xff5F94B9),
              Color(0xff6094BA),
              Color(0xff85A3CB),
              Color(0xff8DA4CE),
              Color(0xff8898CE),
              Color(0xff8395CD),
            ],
          ),
          monthGradient: const LinearGradient(
            colors: [
              Color(0xff5F94B9),
              Color(0xff6094BA),
              Color(0xff85A3CB),
              Color(0xff8DA4CE),
              Color(0xff8898CE),
              Color(0xff8395CD),
            ],
          ),
          calenderSelectedDateBackgroundcolor: AppThemeData.primaryColor,
          showCalenderSelectedDateBackgroundcolor: true,
          calenderSelectedDateColor: Colors.white,
          calenderSelectedDateFontSize: 18,
          calenderSelectedDateBorderRadius: BorderRadius.circular(50),
          dayTextStyle: const TextStyle(
            color: Colors.white,
          ),
          monthBackgroundColor: AppThemeData.primaryColor,
          monthTextStyle: const TextStyle(
            color: Colors.white,
          ),
          weekdaysTextStyle: const TextStyle(
            color: Colors.white,
          ),
          yearBackgroundColor: AppThemeData.primaryColor,
          yearTextStyle: const TextStyle(
            color: Colors.white,
          ),
          calenderUnSelectedDatesColor: Colors.white,
          yearPopHeadingText: "year",
          yearPopHeadingTextStyle: const TextStyle(
            color: Colors.white,
          ),
          yearsListTextStyle: const TextStyle(
            color: Colors.white,
          ),
          monthPopHeadingText: "month",
          monthPopHeadingTextStyle: const TextStyle(
            color: Colors.white,
          ),
          monthsListTextStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
