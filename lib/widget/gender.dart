// import 'package:flutter/material.dart';
// import 'package:slide_switcher/slide_switcher.dart';
//
// class GenderSelect extends StatefulWidget {
//   const GenderSelect({super.key});
//
//   @override
//   State<GenderSelect> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<GenderSelect> {
//   int switcherIndex1 = 0;
//   int switcherIndex2 = 0;
//   int switcherIndex3 = 0;
//   int switcherIndex4 = 0;
//   int switcherIndex5 = 0;
//   int switcherIndex6 = 0;
//   int switcherIndex7 = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SlideSwitcher(
//               children: [
//                 Text(
//                   'First',
//                   style: TextStyle(
//                       fontSize: 15,
//                       color: switcherIndex4 == 0
//                           ? Colors.white.withOpacity(0.9)
//                           : Colors.grey),
//                 ),
//                 Text(
//                   'Second',
//                   style: TextStyle(
//                       fontSize: 15,
//                       color: switcherIndex4 == 1
//                           ? Colors.white.withOpacity(0.9)
//                           : Colors.grey),
//                 ),
//                 Text(
//                   'Third',
//                   style: TextStyle(
//                       fontSize: 15,
//                       color: switcherIndex4 == 2
//                           ? Colors.white.withOpacity(0.9)
//                           : Colors.grey),
//                 ),
//               ],
//               onSelect: (int index) => setState(() => switcherIndex4 = index),
//               containerColor: Colors.transparent,
//               containerBorder: Border.all(color: Colors.white),
//               slidersGradients: const [
//                 LinearGradient(
//                   colors: [
//                     Color.fromRGBO(47, 105, 255, 1),
//                     Color.fromRGBO(188, 47, 255, 1),
//                   ],
//                 ),
//                 LinearGradient(
//                   colors: [
//                     Color.fromRGBO(47, 105, 255, 1),
//                     Color.fromRGBO(0, 192, 169, 1),
//                   ],
//                 ),
//                 LinearGradient(
//                   colors: [
//                     Color.fromRGBO(255, 105, 105, 1),
//                     Color.fromRGBO(255, 62, 62, 1),
//                   ],
//                 ),
//               ],
//               indents: 9,
//               containerHeight: 50,
//               containerWight: 315,
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
