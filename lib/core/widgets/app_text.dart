import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:resize/resize.dart';

///custom [Text] widget image designed for the application
class AppText extends ConsumerWidget {
  final String? data;
  final Color? textColor;
  final TextStyle? textStyle;
  final String? fontFamily;
  final double? textSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextDecoration textDecoration;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? semanticsLabel;
  final double? letterspacing;
  final double? lineHeight;
  final double? padding;

  const AppText(
    String this.data, {
    Key? key,
    this.textColor,
    this.textStyle,
    this.fontFamily,
    this.textSize,
    this.fontWeight,
    this.textAlign = TextAlign.center,
    this.textDirection,
    this.textDecoration = TextDecoration.none,
    this.locale,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.letterspacing,
    this.lineHeight,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 0),
      child: Text(
        data.toString(),
        style: getStyle(),
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
      ),
    );
  }

  TextStyle getStyle() =>
      textStyle ??
      TextStyle(
        color: textColor ?? AppColors.textBlack,
        fontSize: textSize ?? 14.sp,
        height: lineHeight,
        fontWeight: fontWeight,
        fontFamily: fontFamily ?? 'Muli',
        letterSpacing: letterspacing,
        decoration: textDecoration,
      );
}
