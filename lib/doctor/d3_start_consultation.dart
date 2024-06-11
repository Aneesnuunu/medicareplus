// import 'package:flutter/material.dart';
//
// import '../Theam/theme.dart';
//
// class DoctorStartConsultation extends StatelessWidget {
//   const DoctorStartConsultation({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(
//           child: Text(
//             "Patient Details",
//             style: TextStyle(
//                 color: AppThemeData.primaryColor,
//                 fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             width: MediaQuery.of(context).size.width,
//             height: 50,
//             child: ElevatedButton(
//               onPressed: () {
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //     builder: (context) => const BookAppointment(),
//                 //   ),
//                 // );
//               },
//               style: ElevatedButton.styleFrom(
//                 shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(11))),
//                 backgroundColor: AppThemeData.primaryColor,
//               ),
//               child: const Text(
//                 "Start Consultation",
//                 style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
