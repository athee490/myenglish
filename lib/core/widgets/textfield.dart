import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:resize/resize.dart';

/// Custom TextField designed for this application
class PrimaryTextField extends StatefulWidget {
  const PrimaryTextField({
    Key? key,
    this.controller,
    required this.label,
    this.hint,
    this.type = TextInputType.text,
    this.hintSize,
    this.textSize,
    this.focusNode,
    this.borderEnabled,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.enabled,
    this.validator,
    this.maxLength,
    this.maxLines = 1,
  }) : super(key: key);

  final TextEditingController? controller;
  final String label;
  final String? hint;
  final TextInputType type;
  final double? hintSize;
  final double? textSize;
  final FocusNode? focusNode;
  final bool? borderEnabled;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final bool? enabled;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? maxLines;

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: widget.label,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 6.h),
          TextFormField(
            controller: widget.controller,
            keyboardType: widget.type,
            focusNode: widget.focusNode,
            inputFormatters: widget.inputFormatters,
            onChanged: widget.onChanged,
            enabled: widget.enabled,
            validator: widget.validator,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            style: TextStyle(fontSize: widget.textSize ?? 15.sp),
            decoration: InputDecoration(
              counterText: '',
              hintText: widget.hint ?? '',
              hintStyle: TextStyle(
                fontSize: widget.hintSize ?? 14.sp,
                color: AppColors.textLightGrey,
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              filled: true,
              fillColor: AppColors.fieldFill,
              border: widget.borderEnabled ?? true
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(color: AppColors.fieldBorder),
                    )
                  : InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: AppColors.fieldBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
            ),
          ),
        ],
      ),
    );
  }
}
