import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/app_credentials.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/features/onboarding/domain/usecase/course_update_usecase.dart';
import 'package:myenglish/features/onboarding/presentation/student/models/payment_plan_ui_model.dart';
import 'package:myenglish/main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

enum Plans { fortyMins, sixtyMins }

class ChoosePlanProvider extends ChangeNotifier {
  final CourseUpdateUseCase _courseUpdateUseCase;
  bool accept = false;
  bool extend = false;
  Plans selectedPlanTab = Plans.fortyMins;
  Plan? selectedPlan;
  final Razorpay _razorpay = Razorpay();
  ChoosePlanProvider(this._courseUpdateUseCase) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  List<Plan> basicPlan = [
    Plan(
        months: 1,
        classDuration: '40 minutes',
        percentageOff: 0,
        monthlyPrice: 4250,
        discountedMonthlyPrice: 4250),
    Plan(
        months: 3,
        classDuration: '40 minutes',
        percentageOff: 10,
        monthlyPrice: 4250,
        discountedMonthlyPrice: 3825),
    Plan(
        months: 6,
        classDuration: '40 minutes',
        percentageOff: 15,
        monthlyPrice: 4250,
        discountedMonthlyPrice: 3612),
  ];
  List<Plan> extendedPlan = [
    Plan(
        months: 1,
        classDuration: '60 minutes',
        percentageOff: 0,
        monthlyPrice: 6375,
        discountedMonthlyPrice: 6375),
    Plan(
        months: 3,
        classDuration: '60 minutes',
        percentageOff: 10,
        monthlyPrice: 6375,
        discountedMonthlyPrice: 5738),
    Plan(
        months: 6,
        classDuration: '60 minutes',
        percentageOff: 15,
        monthlyPrice: 6375,
        discountedMonthlyPrice: 5418),
  ];

  toggleAcceptButton() {
    accept = !accept;
    notifyListeners();
  }

  togglePlansTab(Plans plan) {
    selectedPlanTab = plan;
    notifyListeners();
  }

  choosePlan(Plan plan) {
    selectedPlan = plan;
    notifyListeners();
  }

  submit() {
    if (!accept || selectedPlan == null) return;
    var options = {
      'key': AppCredentials.razorpayKey,
      'amount': selectedPlan!.totalPrice * 100,
      // 'name': 'My English Friend',
      'name': 'Ramasser Group Virtual Academy',
      "currency": "INR",
      'description': 'Payment',
      'image': 'http://188.166.228.50/uploads/file_1672294832040_playstore.png',
      'prefill': {
        'contact': '${Prefs().getString(Prefs.phoneNumber)}',
        'email': '${Prefs().getString(Prefs.email)}',
      },
      'theme': {
        'color': '#1CA3EF',
      },
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
    _courseUpdateUseCase
        .call(
      planDuration:
          '${selectedPlan!.planDuration.replaceAll('months', 'month')}s'
              .replaceAll('M', 'm'),
      amount: '${selectedPlan!.totalPrice.toInt()} INR',
      classDuration: selectedPlan!.classDuration,
      razorpayId: response.paymentId.toString(),
      extend: extend, //TODO:
    )
        .then((value) {
      Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!,
          AppRoutes.studentHome, (route) => false);
    });
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
