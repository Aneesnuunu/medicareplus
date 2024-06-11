import 'package:flutter/material.dart';
import '../Theam/theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackButtonPressed;


  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackButtonPressed,

  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppThemeData.primaryColor),
        onPressed: onBackButtonPressed ?? () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppThemeData.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),

    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}



// import 'package:flutter/material.dart';
// import '../Theam/theme.dart';
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final VoidCallback? onBackButtonPressed;
//
//   const CustomAppBar({
//     super.key,
//     required this.title,
//     this.onBackButtonPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back, color: AppThemeData.primaryColor),
//         onPressed: onBackButtonPressed ?? () {
//           Navigator.of(context).pop();
//         },
//       ),
//       title: Text(
//         title,
//         style: const TextStyle(
//           color: AppThemeData.primaryColor,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       backgroundColor: Colors.white,
//       elevation: 0,
//     );
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
