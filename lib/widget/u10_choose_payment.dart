import 'package:flutter/material.dart';
import 'package:medi_care/Theam/theme.dart';
import 'package:provider/provider.dart';
import '../Model/u_payment_page_model.dart';

class ChoosePayment extends StatelessWidget {
  const ChoosePayment({super.key, required this.onPaymentMethodSelected});

  final Function(String) onPaymentMethodSelected;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PaymentPageModel>(context);

    return Container(
      decoration: BoxDecoration(
        color: AppThemeData.primaryColor,
        borderRadius: BorderRadius.circular(15.0), // Set border radius here
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Choose a Mode of Payment',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              model.setSelectedPaymentMethod('Pay Online');
              onPaymentMethodSelected('Pay Online');
            },
            leading: const Icon(
              Icons.payment,
              color: Colors.white,
            ),
            title: const Text(
              "Pay Online\n₹300",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            trailing: model.selectedPaymentMethod == 'Pay Online'
                ? const Icon(
              Icons.check,
              color: Colors.white,
            )
                : null,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              color: Colors.white,
              thickness: 1,
            ),
          ),
          ListTile(
            onTap: () {
              model.setSelectedPaymentMethod('Pay at Clinic');
              onPaymentMethodSelected('Pay at Clinic');
            },
            leading: const Icon(
              Icons.store,
              color: Colors.white,
            ),
            title: const Text(
              "Pay at Clinic\n₹300",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            trailing: model.selectedPaymentMethod == 'Pay at Clinic'
                ? const Icon(
              Icons.check,
              color: Colors.white,
            )
                : null,
          ),
        ],
      ),
    );
  }
}
