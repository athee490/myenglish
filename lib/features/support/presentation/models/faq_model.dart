import 'package:equatable/equatable.dart';

class FaqModel extends Equatable {
  String question;
  String answer;
  bool isExpanded;

  FaqModel({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });

  @override
  List<Object?> get props => [question, answer, isExpanded];
}
