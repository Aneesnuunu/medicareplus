// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import '../Theam/theme.dart';
// import '../widget/appbar.dart';
//
// class DoctorAvailabilityManagementPage extends StatefulWidget {
//   const DoctorAvailabilityManagementPage({super.key});
//
//   @override
//   _DoctorAvailabilityManagementPageState createState() =>
//       _DoctorAvailabilityManagementPageState();
// }
//
// class _DoctorAvailabilityManagementPageState
//     extends State<DoctorAvailabilityManagementPage> {
//   DateTime? selectedDate;
//   Set<String> unavailableTimeSlots = {};
//
//   Future<void> fetchUnavailableTimeSlots(DateTime date) async {
//     final dateKey = DateFormat('yyyy-MM-dd').format(date);
//     final doc = await FirebaseFirestore.instance
//         .collection('doctor_availability')
//         .doc(dateKey)
//         .get();
//     if (doc.exists) {
//       setState(() {
//         unavailableTimeSlots = Set<String>.from(doc['unavailableTimeSlots']);
//       });
//     } else {
//       setState(() {
//         unavailableTimeSlots = {};
//       });
//     }
//   }
//
//   Future<void> saveUnavailableTimeSlots() async {
//     if (selectedDate != null) {
//       final dateKey = DateFormat('yyyy-MM-dd').format(selectedDate!);
//       await FirebaseFirestore.instance
//           .collection('doctor_availability')
//           .doc(dateKey)
//           .set({
//         'unavailableTimeSlots': unavailableTimeSlots.toList(),
//       });
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('Unavailability saved!')));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(title: 'Manage Availability'),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('Select Date',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
//             const SizedBox(height: 10),
//             GestureDetector(
//               onTap: () async {
//                 DateTime? picked = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime(DateTime.now().year + 1),
//                 );
//                 if (picked != null) {
//                   setState(() {
//                     selectedDate = picked;
//                   });
//                   await fetchUnavailableTimeSlots(picked);
//                 }
//               },
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Center(
//                   child: Text(
//                     selectedDate != null
//                         ? DateFormat('yyyy-MM-dd').format(selectedDate!)
//                         : 'Select Date',
//                     style: const TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text('Unavailable Time Slots',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
//             const SizedBox(height: 10),
//             selectedDate != null
//                 ? Wrap(
//               spacing: 8,
//               children: List.generate(22, (index) {
//                 final hour = 9 + index ~/ 2;
//                 final minute = (index % 2) * 30;
//                 final time = DateFormat('hh:mm a')
//                     .format(DateTime(2021, 1, 1, hour, minute));
//                 return ChoiceChip(
//                   label: Text(time),
//                   selected: unavailableTimeSlots.contains(time),
//                   onSelected: (selected) {
//                     setState(() {
//                       if (selected) {
//                         unavailableTimeSlots.add(time);
//                       } else {
//                         unavailableTimeSlots.remove(time);
//                       }
//                     });
//                   },
//                 );
//               }),
//             )
//                 : const Text('Please select a date first.', style: TextStyle(color: Colors.white)),
//             const Spacer(),
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: selectedDate != null ? saveUnavailableTimeSlots : null,
//                 style: ElevatedButton.styleFrom(
//                   shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(11))),
//                   backgroundColor: AppThemeData.primaryColor,
//                 ),
//                 child: const Text(
//                   'Save Unavailability',
//                   style: TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Theam/theme.dart';
import '../provider/d6_leave_model.dart';
import '../widget/appbar.dart';

class DoctorAvailabilityManagementPage extends StatelessWidget {
  const DoctorAvailabilityManagementPage({super.key});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DoctorAvailabilityModel(),
      child: _DoctorAvailabilityManagementPageContent(),
    );
  }
}

class _DoctorAvailabilityManagementPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<DoctorAvailabilityModel>(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Manage Availability'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Date',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 1),
                );
                if (picked != null) {
                  model.updateSelectedDate(picked);
                  await _fetchUnavailableTimeSlots(context, picked);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    model.selectedDate != null
                        ? DateFormat('yyyy-MM-dd').format(model.selectedDate!)
                        : 'Select Date',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Unavailable Time Slots',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            model.selectedDate != null
                ? Wrap(
              spacing: 8,
              children: List.generate(22, (index) {
                final hour = 9 + index ~/ 2;
                final minute = (index % 2) * 30;
                final time = DateFormat('hh:mm a').format(DateTime(2021, 1, 1, hour, minute));
                return ChoiceChip(
                  label: Text(time),
                  selected: model.unavailableTimeSlots.contains(time),
                  onSelected: (selected) {
                    if (selected) {
                      model.unavailableTimeSlots.add(time);
                    } else {
                      model.unavailableTimeSlots.remove(time);
                    }
                    model.updateUnavailableTimeSlots(model.unavailableTimeSlots);
                  },
                );
              }),
            )
                : const Text(
              'Please select a date first.',
              style: TextStyle(color: Colors.white),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: model.selectedDate != null ? () => _saveUnavailableTimeSlots(context) : null,
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(11))),
                  backgroundColor: AppThemeData.primaryColor,
                ),
                child: const Text(
                  'Save Unavailability',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchUnavailableTimeSlots(BuildContext context, DateTime date) async {
    final dateKey = DateFormat('yyyy-MM-dd').format(date);
    final doc = await FirebaseFirestore.instance.collection('doctor_availability').doc(dateKey).get();
    if (doc.exists) {
      Provider.of<DoctorAvailabilityModel>(context, listen: false)
          .updateUnavailableTimeSlots(Set<String>.from(doc['unavailableTimeSlots']));
    } else {
      Provider.of<DoctorAvailabilityModel>(context, listen: false).updateUnavailableTimeSlots({});
    }
  }

  Future<void> _saveUnavailableTimeSlots(BuildContext context) async {
    final model = Provider.of<DoctorAvailabilityModel>(context, listen: false);
    if (model.selectedDate != null) {
      final dateKey = DateFormat('yyyy-MM-dd').format(model.selectedDate!);
      await FirebaseFirestore.instance.collection('doctor_availability').doc(dateKey).set({
        'unavailableTimeSlots': model.unavailableTimeSlots.toList(),
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Unavailability saved!')));
    }
  }
}
