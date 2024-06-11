// import 'package:flutter/material.dart';
// import 'package:medi_care/User/u05_signin_screen.dart';
// import 'package:medi_care/User/u5.1_pass_reset.dart';
// import 'package:provider/provider.dart';
// import '../Theam/theme.dart';
// import '../doctor/d1.1_login.dart';
// import '../provider/login.dart';
// import '../widget/text_form_field.dart';
// import 'u06.1_navigationbar.dart';
//
// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     final loginProvider = Provider.of<LoginProvider>(context); // Access the LoginProvider
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         reverse: true,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 11, right: 10),
//           child: Container(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//             ),
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 300,
//                 ),
//                 CustomTextFormField(
//                   controller: loginProvider.emailController,
//                   hintText: 'Email Address',
//                   prefixIcon: Icons.email_outlined,
//                 ),
//                 CustomTextFormFieldPassword(
//                   controller: loginProvider.passwordController,
//                   hintText: 'Password',
//                   prefixIcon: Icons.lock_outline,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const ForgotPassword(),
//                           ),
//                         );
//                       },
//                       child: const Text(
//                         "Forgot Password?",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: AppThemeData.primaryColor,
//                           fontSize: 17,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: loginProvider.isLoading ? null : () async {
//                       loginProvider.setIsLoading(true); // Set loading state
//
//                       try {
//                         await loginProvider.signInWithEmailAndPassword();
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Logged in successfully'),
//                             duration: Duration(seconds: 2),
//                           ),
//                         );
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const MainHome(),
//                           ),
//                         );
//                       } catch (e) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Invalid email or password'),
//                           ),
//                         );
//                       } finally {
//                         loginProvider.setIsLoading(false); // Reset loading state
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(11)),
//                       ),
//                       backgroundColor: AppThemeData.primaryColor,
//                     ),
//                     child: loginProvider.isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                       "LOG IN",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const SiginPage(),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     "I haven't an account",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: AppThemeData.primaryColor,
//                       fontSize: 17,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 100,
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>  DoctorLoginPage(),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     "Doctor login",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: AppThemeData.primaryColor,
//                       fontSize: 17,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:medi_care/User/u05_signin_screen.dart';
import 'package:medi_care/User/u5.1_pass_reset.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../Theam/theme.dart';
import '../doctor/d1.1_login.dart';
import '../provider/login.dart';
import '../widget/text_form_field.dart';
import 'u06.1_navigationbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});


  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 11, right: 10),
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 300,
                ),
                CustomTextFormField(
                  controller: loginProvider.emailController,
                  hintText: 'Email Address',
                  prefixIcon: Icons.email_outlined,
                ),
                CustomTextFormFieldPassword(
                  controller: loginProvider.passwordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPassword(),
                          ),
                        );
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppThemeData.primaryColor,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: loginProvider.isLoading ? null : () async {
                      loginProvider.setIsLoading(true);

                      try {
                        await loginProvider.signInWithEmailAndPassword();

                        // Save authentication token to SharedPreferences
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString('auth_token', 'your_auth_token_here');

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Logged in successfully'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainHome(),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid email or password'),
                          ),
                        );
                      } finally {
                        loginProvider.setIsLoading(false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                      ),
                      backgroundColor: AppThemeData.primaryColor,
                    ),
                    child: loginProvider.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      "LOG IN",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SiginPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "I haven't an account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppThemeData.primaryColor,
                      fontSize: 17,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                TextButton(
                  onPressed: () async {
                    // Clear authentication token from SharedPreferences
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.remove('auth_token');

                    // Navigate to the doctor login page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorLoginPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Doctor login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppThemeData.primaryColor,
                      fontSize: 17,
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
