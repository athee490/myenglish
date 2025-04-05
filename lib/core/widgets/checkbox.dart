import 'package:flutter/material.dart';
import 'package:myenglish/core/constants/app_colors.dart';

///Custom [Checkbox] widget designed for the application
class AppCheckBox extends StatelessWidget {
  AppCheckBox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  bool value;
  void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 22,
          width: 22,
          decoration: BoxDecoration(
            color: AppColors.disabledButton,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Transform.scale(
          scale: 1.25,
          child: Checkbox(
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            value: value,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
