import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:medi_care/Theam/theme.dart';
import 'package:provider/provider.dart';
import '../Model/u09_book_appoi_model.dart';
import '../User/u10_payment.dart';
import '../widget/appbar.dart';
import '../widget/u09_build_date_container.dart';

class UserAppointmentBookingPage extends StatelessWidget {
  const   UserAppointmentBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookAppointmentModel(),
      child: _UserAppointmentBookingContent(),
    );
  }
}

class _UserAppointmentBookingContent extends StatefulWidget {
  @override
  _UserAppointmentBookingContentState createState() =>
      _UserAppointmentBookingContentState();
}

class _UserAppointmentBookingContentState
    extends State<_UserAppointmentBookingContent> {
  Future<List<String>> fetchAvailableTimeSlots(DateTime date) async {
    final dateKey = DateFormat('yyyy-MM-dd').format(date);
    final doc = await FirebaseFirestore.instance
        .collection('doctor_availability')
        .doc(dateKey)
        .get();

    //  slots from 9:00 AM to 8:00 PM with 30-minute intervals
    List<String> allTimeSlots = [];
    for (int i = 9; i < 20; i++) {
      String timeSlot = DateFormat('hh:mm a').format(DateTime(0, 0, 0, i, 0));
      allTimeSlots.add(timeSlot);
      if (!(i == 13 || i == 17)) {
        // Skip adding 1:30 PM and 5:30 PM
        timeSlot = DateFormat('hh:mm a').format(DateTime(0, 0, 0, i, 30));
        allTimeSlots.add(timeSlot);
      }
    }

    if (doc.exists) {
      List<dynamic> unavailable = doc['unavailableTimeSlots'];
      return allTimeSlots.where((time) => !unavailable.contains(time)).toList();
    } else {
      return allTimeSlots;
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<BookAppointmentModel>(context);

    DateTime now = DateTime.now();
    DateTime tomorrow = now.add(const Duration(days: 1));
    DateTime dayAfterTomorrow = now.add(const Duration(days: 2));

    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: CustomAppBar(
            title: "Book Your Appointment",
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Select Date",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: AppThemeData.primaryColor,
                  ),
                ),

                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DateContainer(date: now, model: model),
                    DateContainer(date: tomorrow, model: model),
                    DateContainer(date: dayAfterTomorrow, model: model),
                  ],
                ),
                const SizedBox(height: 20),
                Consumer<BookAppointmentModel>(
                  builder: (context, model, child) {
                    return Text(
                      model.selectedDate != null
                          ? '${DateFormat('EEEE').format(model.selectedDate!)}, ${DateFormat('yyyy-MM-dd').format(model.selectedDate!)}'
                          : 'No Date Selected',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),
                const Text(
                  "Time Slot",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: AppThemeData.primaryColor,
                  ),
                ),
                const SizedBox(height: 30),
                FutureBuilder<List<String>>(
                  future: fetchAvailableTimeSlots(model.selectedDate ?? now),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}',style: const TextStyle(color: Colors.white),);
                    } else {
                      final timeSlots = snapshot.data!;
                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: timeSlots.map((time) {
                          final isSelected = model.selectedTime == time;
                          return GestureDetector(
                            onTap: () {
                              model.setTime(time);
                            },
                            child: Container(
                              width: 90, // Fixed width
                              height: 50, // Fixed height
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white
                                    : AppThemeData.primaryColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color:
                                  isSelected ? Colors.black : Colors.white,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                time,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                  isSelected ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed:
                    model.selectedDate != null && model.selectedTime != null
                        ? () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            selectedDate: model.selectedDate!,
                            selectedTime: model.selectedTime!,
                          ),
                        ),
                      );
                    }
                        : null,
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
