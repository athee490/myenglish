class PaymentPlanUiModel {
  final String duration;
  final String days;
  final String daysPerWeek;
  final double actualPrice;
  final double discountedPrice;
  final double percentageOff;

  PaymentPlanUiModel({
    required this.duration,
    required this.days,
    required this.daysPerWeek,
    required this.actualPrice,
    required this.discountedPrice,
    required this.percentageOff,
  });
}

class Plan {
  int months;
  String classDuration;
  late String planDuration;
  double percentageOff;
  double monthlyPrice;
  double discountedMonthlyPrice;
  late double amountDiscounted;
  late double totalPrice;
  Plan(
      {required this.months,
      required this.classDuration,
      required this.percentageOff,
      required this.monthlyPrice,
      required this.discountedMonthlyPrice}) {
    planDuration = '$months Month${months > 1 ? 's' : ''}';
    double discount = monthlyPrice - discountedMonthlyPrice;
    amountDiscounted = discount * months;
    totalPrice = months * discountedMonthlyPrice;
  }
}
