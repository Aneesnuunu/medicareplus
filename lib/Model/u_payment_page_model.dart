import 'package:flutter/material.dart';

class PaymentPageModel extends ChangeNotifier {
  String? selectedPaymentMethod;

  void setSelectedPaymentMethod(String paymentMethod) {
    selectedPaymentMethod = paymentMethod;
    notifyListeners();
  }
}
