import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayProvider extends ChangeNotifier {
  late Razorpay _razorpay;
  RazorpayProvider() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  makePayment(double amountInRupees) {
    var options = {
      'key': 'rzp_test_OvqXboknnCpdyp',
      'amount': amountInRupees * 100,
      'name': 'Ramasser Group Virtual Academy',
      "currency": "INR",
      'description': 'Payment',
      'prefill': {
        'contact': '8888888888',
        'email': 'test@razorpay.com',
      },
      'theme': {
        'color': '#1CA3EF',
      },
      // 'external': {
      //   'wallets': ['paytm']
      // }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      log(e.toString());
    }
    // notifyListeners();
  }

  skip() {
    Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentContext!, AppRoutes.studentHome, (route) => false);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    showToast(
      "SUCCESS: ${response.paymentId ?? ''}",
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showToast(
      "ERROR: ${response.code} - ${response.message ?? ''}",
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showToast("EXTERNAL_WALLET: ${response.walletName ?? ''}");
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
