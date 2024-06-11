import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medi_care/Theam/theme.dart';
import 'package:medi_care/widget/text_form_field.dart';
import '../Model/d_login_model.dart';
import 'd1.2_sigin.dart';

class DoctorLoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  DoctorLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DoctorLoginProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppThemeData.backgroundBlack,
          title: const Text(
            "Doctor login",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppThemeData.primaryColor),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.only(left: 11, right: 10),
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    hintText: 'Email Address',
                    prefixIcon: Icons.email_outlined,
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    hintText: 'Password',
                    prefixIcon: Icons.lock_outline,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Consumer<DoctorLoginProvider>(
                    builder: (context, provider, child) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            await provider.signIn(
                              emailController.text,
                              passwordController.text,
                              context,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11))),
                            backgroundColor: AppThemeData.primaryColor,
                          ),
                          child: const Text(
                            "LOG IN",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorSiginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Doctor register",
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
      ),
    );
  }
}
