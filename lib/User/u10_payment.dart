
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medi_care/Theam/theme.dart';
import 'package:medi_care/User/u11_payment_success.dart';
import '../widget/appbar.dart';
import '../widget/u10_choose_payment.dart';
import '../widget/u10_clinic_details.dart';
import '../widget/u10_doctor_details.dart';
import 'package:provider/provider.dart';

class PaymentPageModel extends ChangeNotifier {
  String? _selectedPaymentMethod;

  String? get selectedPaymentMethod => _selectedPaymentMethod;

  void setSelectedPaymentMethod(String paymentMethod) {
    _selectedPaymentMethod = paymentMethod;
    notifyListeners();
  }
}


class PaymentPage extends StatelessWidget {
  final DateTime? selectedDate;
  final String? selectedTime;

  const PaymentPage({super.key, this.selectedDate, this.selectedTime});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentPageModel(),
      child: _PaymentPageContent(
          selectedDate: selectedDate, selectedTime: selectedTime),
    );
  }
}

class _PaymentPageContent extends StatefulWidget {
  final DateTime? selectedDate;
  final String? selectedTime;

  const _PaymentPageContent({this.selectedDate, this.selectedTime});

  @override
  State<_PaymentPageContent> createState() => _PaymentPageContentState();
}

class _PaymentPageContentState extends State<_PaymentPageContent> {
  bool _isLoading = false;

  void _confirmClinicVisit(PaymentPageModel model) async {
    if (model.selectedPaymentMethod == 'Pay at Clinic') {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        setState(() {
          _isLoading = true;
        });

        final userRef = FirebaseFirestore.instance
            .collection('User')
            .doc(currentUser.uid)
            .collection('appointments')
            .doc(); // Generate a new document ID

        final dateKey = DateFormat('yyyy-MM-dd').format(widget.selectedDate!);
        final appointmentData = {
          'date': dateKey,
          'time': widget.selectedTime,
          'dayName': DateFormat('EEEE').format(widget.selectedDate!),
        };

        try {
          // Update user appointment
          await userRef.set(appointmentData);

          // Reference to the doctor's availability document
          final docRef = FirebaseFirestore.instance
              .collection('doctor_availability')
              .doc(dateKey);

          // Check if the document exists
          final docSnapshot = await docRef.get();

          if (docSnapshot.exists) {
            // Document exists, update it
            await docRef.update({
              'unavailableTimeSlots': FieldValue.arrayUnion([widget.selectedTime])
            });
          } else {
            // Document does not exist, create it
            await docRef.set({
              'unavailableTimeSlots': [widget.selectedTime]
            });
          }

          // Navigate to PaymentSuccessPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaymentSuccessPage()),
          );
        } catch (error) {
          // Handle errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to book appointment: $error')),
          );
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please choose "Pay at Clinic" as the payment mode.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PaymentPageModel>(context);

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Book in-Clinic Appointment",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const U10DoctorDetails(),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppThemeData.primaryColor,
                  borderRadius:
                  BorderRadius.circular(15.0), // Set border radius here
                ),
                height: 100,
                child: Column(
                  children: [
                    const Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Appointment time",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.access_time,
                        color: Colors.white,
                      ),
                      title: Text(
                        DateFormat('dd/MM/yyyy').format(widget.selectedDate!),
                        style:
                        const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      subtitle: Text(
                        DateFormat('EEEE').format(widget.selectedDate!),
                        style:
                        const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      trailing: Text(
                        widget.selectedTime ?? '',
                        style:
                        const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const U10ClinicDetails(),
              const SizedBox(
                height: 15,
              ),
              ChoosePayment(
                onPaymentMethodSelected: (paymentMethod) {
                  model.setSelectedPaymentMethod(paymentMethod);
                },
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : () => _confirmClinicVisit(model),
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(11))),
                    backgroundColor: AppThemeData.primaryColor,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    "Confirm Clinic Visit",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
