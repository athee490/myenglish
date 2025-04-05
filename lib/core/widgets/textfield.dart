import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:resize/resize.dart';

import '../../features/course_syllabus/presentation/widget/common_widget.dart';


///Custom TextField designed for this application
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
    this.suffix,
    this.prefix,
    this.contentPadding,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines,
    this.validator,
    this.maxLength,
    this.onTap,
    this.color,
    this.textInputAction,
    this.onChanged,
    this.autoValidateMode,
  }) : super(key: key);

  final String label;
  final String? hint;
  final Color? color;
  final TextEditingController? controller;
  final TextInputType type;
  final double? hintSize;
  final double? textSize;
  final FocusNode? focusNode;
  final bool? borderEnabled;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final EdgeInsets? contentPadding;
  final bool obscureText;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  late final FocusNode fNode;
  @override
  void initState() {
    fNode = FocusNode();
    if (!widget.readOnly) {
      fNode.addListener(() {
        setState(() {});
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        if (!widget.readOnly) {
          fNode.requestFocus();
        }
        widget.onTap?.call();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: (fNode.hasPrimaryFocus && !widget.readOnly)
                  ? AppColors.primary
                  : AppColors.greyC3,
            ),
            color: widget.color ?? AppColors.white),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                widget.label,
                fontWeight: FontWeight.w700,
              ),
              vHeight(4.h),
              SizedBox(
                height: widget.suffixIcon != null ? 30 : null,
                child: TextFormField(
                  controller: widget.controller,
                  focusNode: fNode,
                  maxLength: widget.maxLength,
                  maxLines: widget.maxLines ?? 1,
                  obscureText: widget.obscureText,
                  keyboardType: widget.type,
                  inputFormatters: widget.inputFormatters,
                  readOnly: widget.readOnly,
                  onTap: widget.onTap,
                  textInputAction: widget.textInputAction,
                  onChanged: widget.onChanged,
                  style: TextStyle(color: AppColors.textBlack, fontSize: 14.sp),
                  validator: widget.validator,
                  autovalidateMode: widget.autoValidateMode,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: widget.hint,
                    hintStyle:
                        TextStyle(fontSize: 14.sp, color: AppColors.greyC3),
                    suffix: widget.suffix,
                    prefix: widget.prefix,
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: widget.suffixIcon,
                    isDense: true,
                    contentPadding: widget.contentPadding ?? EdgeInsets.zero,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    fNode.dispose();
    super.dispose();
  }
}

class PasswordTextField extends ConsumerStatefulWidget {
  PasswordTextField({
    Key? key,
    this.controller,
    required this.label,
    this.hint,
    this.type = TextInputType.text,
    this.focusNode,
    this.borderEnabled,
    this.inputFormatters,
    this.suffixIcon,
    this.contentPadding,
    this.obscureText = true,
    this.readOnly = false,
    this.maxLines,
    this.validator,
    this.maxLength,
    this.hasError = false,
    this.textInputAction,
    this.onChanged,
    this.errorText,
    this.toggleVisibility,
    this.autoValidateMode,
  }) : super(key: key);

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType type;
  final FocusNode? focusNode;
  final bool? borderEnabled;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final EdgeInsets? contentPadding;
  bool obscureText;
  final bool readOnly;
  final int? maxLines;
  bool hasError;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? errorText;
  void Function()? toggleVisibility;
  final AutovalidateMode? autoValidateMode;

  @override
  ConsumerState<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends ConsumerState<PasswordTextField> {
  late final FocusNode focusNode;
  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        focusNode.requestFocus();
      },
      child: StatefulBuilder(builder: (context, setState) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: (focusNode.hasPrimaryFocus && !widget.readOnly)
                    ? AppColors.primary
                    : widget.hasError
                        ? AppColors.red
                        : AppColors.greyC3,
              ),
              color: AppColors.white),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  widget.label,
                  fontWeight: FontWeight.w700,
                ),
                vHeight(4.h),
                SizedBox(
                  height: 30,
                  child: TextFormField(
                    controller: widget.controller,
                    focusNode: focusNode,
                    maxLength: widget.maxLength,
                    maxLines: widget.maxLines ?? 1,
                    obscureText: widget.obscureText,
                    keyboardType: widget.type,
                    inputFormatters: widget.inputFormatters,
                    autovalidateMode: widget.autoValidateMode,
                    readOnly: widget.readOnly,
                    textInputAction: widget.textInputAction,
                    style:
                        TextStyle(color: AppColors.textBlack, fontSize: 14.sp),
                    // validator: widget.validator,
                    decoration: InputDecoration(
                      errorMaxLines: 1,
                      hintText: widget.hint,
                      hintStyle:
                          TextStyle(fontSize: 14.sp, color: AppColors.greyC3),
                      suffixIcon: InkWell(
                          onTap: widget.toggleVisibility,
                          child: AppText(
                              widget.obscureText
                                  ? AppStrings.show
                                  : AppStrings.hide,
                              textSize: 13.sp,
                              textDecoration: TextDecoration.underline)),
                      isDense: true,
                      contentPadding: widget.contentPadding ?? EdgeInsets.zero,
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                if (widget.errorText != null && widget.hasError)
                  AppText(
                    widget.errorText!,
                    textSize: 12.sp,
                    textColor: AppColors.red,
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}

///Custom Dropdown Widget designed for this application
class AppDropDownTextField extends StatelessWidget {
  final String label;
  String? hint;
  List<String> items;
  final void Function(String?)? onChanged;
  final AutovalidateMode? autoValidateMode;
  final String? Function(String?)? validator;
  String? value;
  AppDropDownTextField({
    Key? key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.autoValidateMode,
    this.hint,
    this.validator,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.greyC3,
            ),
            color: AppColors.white),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  label,
                  fontWeight: FontWeight.w700,
                ),
                vHeight(4.h),
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    value: value,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.greyC3,
                      size: 25.w,
                    ),
                    validator: validator,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle:
                          TextStyle(fontSize: 14.sp, color: AppColors.black),
                      isDense: true,
                      // suffixIcon: Icon(Icons.arrow_downward_sharp),
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    items: items
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: AppText(e),
                            ))
                        .toList(),
                    onChanged: onChanged,
                    autovalidateMode: autoValidateMode,
                  ),
                ),
              ],
            )));
  }
}


///Custom TextField with CountryCode Widget designed for this application
class AppMobileWithCountryTextField extends StatefulWidget {
  const AppMobileWithCountryTextField({
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
    this.suffix,
    this.contentPadding,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines,
    this.validator,
    this.maxLength,
    this.onTap,
    this.color,
    this.textInputAction,
    this.onChanged,
    this.autoValidateMode,
  }) : super(key: key);

  final String label;
  final String? hint;
  final Color? color;
  final TextEditingController? controller;
  final TextInputType type;
  final double? hintSize;
  final double? textSize;
  final FocusNode? focusNode;
  final bool? borderEnabled;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final EdgeInsets? contentPadding;
  final bool obscureText;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;

  @override
  _AppMobileWithCountryTextFieldState createState() =>
      _AppMobileWithCountryTextFieldState();
}

class _AppMobileWithCountryTextFieldState
    extends State<AppMobileWithCountryTextField> {
  late final FocusNode fNode;

  @override
  void initState() {
    setState(() {
      fNode = FocusNode();
      if (!widget.readOnly) {
        fNode.addListener(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        setState(() {
          if (!widget.readOnly) {
            fNode.requestFocus();
          }
          widget.onTap?.call();
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: (fNode.hasPrimaryFocus && !widget.readOnly)
                  ? AppColors.primary
                  : AppColors.greyC3,
            ),
            color: widget.color ?? AppColors.white),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                widget.label,
                fontWeight: FontWeight.w700,
              ),
              vHeight(4.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.prefixIcon != null) ...[
                    GestureDetector(
                      onTap: () {
                        if (!widget.readOnly) {
                          fNode.requestFocus();
                        }
                        widget.onTap?.call();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: widget.prefixIcon!,
                      ),
                    ),
                  ],
                  Expanded(
                    child: SizedBox(
                      height: widget.suffixIcon != null ? 30 : null,
                      child: TextFormField(
                        controller: widget.controller,
                        focusNode: fNode,
                        maxLength: widget.maxLength,
                        maxLines: widget.maxLines ?? 1,
                        obscureText: widget.obscureText,
                        keyboardType: widget.type,
                        inputFormatters: widget.inputFormatters,
                        readOnly: widget.readOnly,
                        onTap: widget.onTap,
                        textInputAction: widget.textInputAction,
                        onChanged: widget.onChanged,
                        style: TextStyle(
                            color: AppColors.textBlack, fontSize: 14.sp),
                        validator: widget.validator,
                        autovalidateMode: widget.autoValidateMode,
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: widget.hint,
                          hintStyle: TextStyle(
                              fontSize: 14.sp, color: AppColors.greyC3),
                          suffix: widget.suffix,
                          suffixIcon: widget.suffixIcon,
                          isDense: true,
                          contentPadding:
                              widget.contentPadding ?? EdgeInsets.zero,
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          // Remove prefix icon from InputDecoration
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    fNode.dispose();
    super.dispose();
  }
}

///Custom Country Code Dropdown Widget designed for this application
class AppDropDownCountryField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final bool dialCodeSearch;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final VoidCallback? onTap;
  final bool readOnly;
  final FormFieldSetter<PhoneNumber>? onSaved;
  final ValueChanged<PhoneNumber>? onChanged;
  final ValueChanged<PhoneNumber>? onCountryChanged;
  final FutureOr<String?> Function(String?)? validator;
  final bool autovalidate;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;
  final bool enabled;
  final Brightness keyboardAppearance;
  final String? initialValue;
  final String? initialCountryCode;
  final List<String>? countries;
  final InputDecoration? decoration;
  final TextStyle? style;
  final bool disableLengthCheck;
  final bool showDropdownIcon;
  final BoxDecoration dropdownDecoration;
  final TextStyle? dropdownTextStyle;
  final List<TextInputFormatter>? inputFormatters;
  final String searchText;
  final IconPosition iconPosition;
  final Icon dropDownIcon;
  final bool autofocus;
  final AutovalidateMode? autovalidateMode;
  final bool showCountryFlag;
  final bool showCountryCode;
  final bool showCountryName;
  final String? invalidNumberMessage;
  final Color? cursorColor;
  final EdgeInsetsGeometry flagsButtonPadding;
  final TextInputAction? textInputAction;

  const AppDropDownCountryField({
    Key? key,
    required this.label,
    this.initialCountryCode,
    this.obscureText = false,
    this.textAlign = TextAlign.left,
    this.textAlignVertical,
    this.onTap,
    this.readOnly = false,
    this.initialValue,
    this.keyboardType = TextInputType.phone,
    this.autovalidate = true,
    this.controller,
    this.focusNode,
    this.decoration,
    this.style,
    this.dropdownTextStyle,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.countries,
    this.onCountryChanged,
    this.onSaved,
    this.showDropdownIcon = true,
    this.dropdownDecoration = const BoxDecoration(),
    this.inputFormatters,
    this.enabled = true,
    this.keyboardAppearance = Brightness.light,
    this.searchText = 'Search by Country Name',
    this.iconPosition = IconPosition.trailing,
    this.dropDownIcon = const Icon(
      Icons.keyboard_arrow_down_rounded,
      color: Color(0xFF777474),
    ),
    this.autofocus = false,
    this.textInputAction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.showCountryFlag = true,
    this.showCountryCode = true,
    this.showCountryName = true,
    this.dialCodeSearch = true,
    this.cursorColor,
    this.disableLengthCheck = false,
    this.flagsButtonPadding = const EdgeInsets.symmetric(vertical: 10),
    this.invalidNumberMessage,
  }) : super(key: key);

  @override
  State<AppDropDownCountryField> createState() =>
      _AppDropDownCountryFieldState();
}

class _AppDropDownCountryFieldState extends State<AppDropDownCountryField> {
  late List<Country> _countryList;
  late Country _selectedCountry;
  late List<Country> filteredCountries;
  late String number;

  String? validationMessage;

  @override
  void initState() {
    super.initState();
    _countryList = widget.countries == null
        ? countries
        : countries
            .where((country) => widget.countries!.contains(country.code))
            .toList();
    filteredCountries = _countryList;
    number = widget.initialValue ?? '';
    if (widget.initialCountryCode == null && number.startsWith('+')) {
      number = number.substring(1);
      // parse initial value
      _selectedCountry = countries.firstWhere(
          (country) => number.startsWith(country.dialCode),
          orElse: () => _countryList.first);
      number = number.substring(_selectedCountry.dialCode.length);
    } else {
      _selectedCountry = _countryList.firstWhere(
          (item) => item.name == (widget.initialCountryCode ?? 'US'),
          orElse: () => _countryList.first);
    }
    if (widget.autovalidateMode == AutovalidateMode.always) {
      var x = widget.validator?.call(widget.initialValue);
      if (x is String) {
        setState(() => validationMessage = x);
      } else {
        (x as Future).then((msg) => setState(() => validationMessage = msg));
      }
    }
  }

  Future<void> _changeCountry() async {
    filteredCountries = _countryList;
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => Dialog(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search),
                    labelText: widget.searchText,
                  ),
                  onChanged: (value) {
                    filteredCountries = widget.dialCodeSearch &&
                            isNumeric(value)
                        ? _countryList
                            .where(
                                (country) => country.dialCode.contains(value))
                            .toList()
                        : _countryList
                            .where((country) => country.name
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                    if (mounted) setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredCountries.length,
                    itemBuilder: (ctx, index) => Column(
                      children: <Widget>[
                        ListTile(
                          leading: Image.asset(
                            'assets/flags/${filteredCountries[index].code.toLowerCase()}.png',
                            package: 'intl_phone_field',
                            width: 30,
                          ),
                          title: Text(
                            filteredCountries[index].name,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          // title: Text(
                          //   '+${filteredCountries[index].dialCode}',
                          //   style: const TextStyle(fontWeight: FontWeight.w600),
                          // ),
                          onTap: () {
                            _selectedCountry = filteredCountries[index];
                            widget.onCountryChanged?.call(
                              PhoneNumber(
                                countryCodeName: _selectedCountry.name,
                                countryISOCode: _selectedCountry.code,
                                countryCode: '+${_selectedCountry.dialCode}',
                                number: '',
                              ),
                            );
                            Navigator.of(context).pop();
                          },
                        ),
                        const Divider(thickness: 1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.greyC3,
            ),
            color: AppColors.white),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  widget.label,
                  fontWeight: FontWeight.w700,
                ),
                vHeight(4.h),
                InkWell(
                  onTap: widget.enabled ? _changeCountry : null,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (widget.showCountryFlag) ...[
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/flags/${_selectedCountry.code.toLowerCase()}.png',
                            package: 'intl_phone_field',
                            width: 22,
                            height: 20,
                          ),
                        ),
                      ],
                      if (widget.showCountryName) ...[
                        Expanded(
                          flex: 3,
                          child: Text(
                            _selectedCountry.name,
                            style: widget.dropdownTextStyle,
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                      if (widget.showCountryCode) ...[
                        Expanded(
                          flex: 1,
                          child: Text(
                            '+${_selectedCountry.dialCode}',
                            style: widget.dropdownTextStyle,
                          ),
                        )
                      ],
                      if (widget.enabled &&
                          widget.showDropdownIcon &&
                          widget.iconPosition == IconPosition.leading) ...[
                        const SizedBox(width: 4),
                        widget.dropDownIcon,
                      ],
                      if (widget.enabled &&
                          widget.showDropdownIcon &&
                          widget.iconPosition == IconPosition.trailing) ...[
                        widget.dropDownIcon,
                        const SizedBox(width: 4),
                      ],
                    ],
                  ),
                ),
              ],
            )));
  }

  bool isNumeric(String s) => s.isNotEmpty && double.tryParse(s) != null;
}

enum IconPosition {
  leading,
  trailing,
}

///Custom TextField designed for this application
class SearchTextField extends StatefulWidget {
  const SearchTextField({
    Key? key,
    this.controller,
    this.hint,
    this.type = TextInputType.text,
    this.hintSize,
    this.textSize,
    this.focusNode,
    this.borderEnabled,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.contentPadding,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines,
    this.validator,
    this.maxLength,
    this.onTap,
    this.color,
    this.textInputAction,
    this.onChanged,
    this.autoValidateMode,
  }) : super(key: key);

  final String? hint;
  final Color? color;
  final TextEditingController? controller;
  final TextInputType type;
  final double? hintSize;
  final double? textSize;
  final FocusNode? focusNode;
  final bool? borderEnabled;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final EdgeInsets? contentPadding;
  final bool obscureText;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late final FocusNode fNode;
  @override
  void initState() {
    fNode = FocusNode();
    if (!widget.readOnly) {
      fNode.addListener(() {
        setState(() {});
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        if (!widget.readOnly) {
          fNode.requestFocus();
        }
        widget.onTap?.call();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: (fNode.hasPrimaryFocus && !widget.readOnly)
                  ? AppColors.primary
                  : AppColors.greyC3,
            ),
            color: widget.color ?? AppColors.white),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: widget.prefixIcon != null ? 20 : null,
                child: TextFormField(
                  controller: widget.controller,
                  focusNode: fNode,
                  maxLength: widget.maxLength,
                  maxLines: widget.maxLines ?? 1,
                  obscureText: widget.obscureText,
                  keyboardType: widget.type,
                  inputFormatters: widget.inputFormatters,
                  readOnly: widget.readOnly,
                  onTap: widget.onTap,
                  textInputAction: widget.textInputAction,
                  onChanged: widget.onChanged,
                  style: TextStyle(color: AppColors.textBlack, fontSize: 14.sp),
                  validator: widget.validator,
                  autovalidateMode: widget.autoValidateMode,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: widget.hint,
                    hintStyle:
                        TextStyle(fontSize: 14.sp, color: AppColors.greyC3),
                    suffix: widget.suffix,
                    suffixIcon: widget.suffixIcon,
                    prefixIcon: widget.prefixIcon,
                    isDense: true,
                    contentPadding: widget.contentPadding ?? EdgeInsets.zero,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    fNode.dispose();
    super.dispose();
  }
}

///Custom Dropdown with Headings Widget designed for this application
// class CustomDropdown extends StatefulWidget {
//   List<Grades> items;
//   String? label;
//   bool isFullScreen;
//   bool showLabel;
//   bool showSuffixIcon;
//   bool showPrefixIcon;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final ValueChanged<String>? onGradeChanged;
//   final void Function()? onTap;
//
//   CustomDropdown(
//       {Key? key,
//       required this.items,
//       this.label,
//       this.showSuffixIcon = false,
//       this.showPrefixIcon = false,
//       this.showLabel = false,
//       this.isFullScreen = true,
//       this.onGradeChanged,
//       this.onTap,
//       this.suffixIcon,
//       this.prefixIcon})
//       : super(key: key);
//
//   @override
//   State<CustomDropdown> createState() => _CustomDropdownState();
// }
//
// class _CustomDropdownState extends State<CustomDropdown> {
//   String? selectedGrade;
//
//   Future<void> _changeGrade() async {
//     await showDialog(
//       context: context,
//       useRootNavigator: false,
//       builder: (context) => Dialog(
//         child: Container(
//           width: MediaQuery.of(context).size.width * .50,
//           padding: const EdgeInsets.all(15),
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: widget.items.length,
//             itemBuilder: (ctx, index) => Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(widget.items[index].label,
//                     style: TextStyle(
//                         fontSize: 15.sp, fontWeight: FontWeight.w800)),
//                 const Divider(thickness: 1),
//                 ListView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: widget.items[index].value.length,
//                   itemBuilder: (ctx, outer) => InkWell(
//                       child: Container(
//                         padding: const EdgeInsets.all(5),
//                         decoration: (widget.items[index].value[outer] ==
//                                 selectedGrade)
//                             ? BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 border: Border.all(color: AppColors.primary),
//                                 color: AppColors.primary)
//                             : const BoxDecoration(),
//                         child: Row(
//                           children: [
//                             SizedBox(width: 12.h),
//                             Text(
//                                 widget.items[index].value[outer]
//                                             .toLowerCase() !=
//                                         'others'
//                                     ? '${widget.items[index].value[outer]} Grade'
//                                     : widget.items[index].value[outer],
//                                 style: TextStyle(
//                                     fontSize: 14.sp,
//                                     fontWeight: FontWeight.w400)),
//                           ],
//                         ),
//                       ),
//                       onTap: () {
//                         if (widget.onGradeChanged != null) {
//                           widget.onGradeChanged!(
//                               widget.items[index].value[outer]);
//                           selectedGrade = widget.items[index].value[outer];
//                         }
//                       }),
//                 ),
//                 const Divider(thickness: 1),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//     if (mounted) setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return (widget.isFullScreen)
//         ? Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(18),
//                 border: Border.all(
//                   color: AppColors.greyC3,
//                 ),
//                 color: AppColors.white),
//             child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (widget.showLabel) ...{
//                       AppText(
//                         widget.label!,
//                         fontWeight: FontWeight.w700,
//                       ),
//                       vHeight(4.h),
//                     },
//                     InkWell(
//                       onTap: _changeGrade,
//                       child: Container(
//                         decoration: (widget.showPrefixIcon)
//                             ? BoxDecoration(
//                                 borderRadius: BorderRadius.circular(18),
//                                 border: Border.all(
//                                   color: AppColors.greyC3,
//                                 ),
//                                 color: AppColors.white)
//                             : const BoxDecoration(),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             if (widget.showPrefixIcon) ...{
//                               Expanded(flex: 1, child: widget.prefixIcon!)
//                             },
//                             Expanded(
//                               flex: 3,
//                               child: Text((selectedGrade != null)
//                                   ? (selectedGrade!.toLowerCase() == 'others')
//                                       ? '$selectedGrade'
//                                       : '$selectedGrade Grade'
//                                   : 'Select Grade'),
//                             ),
//                             if (widget.showSuffixIcon) ...{widget.suffixIcon!}
//                           ],
//                         ),
//                       ), // Fix is here, don't invoke the function here
//                     ),
//                   ],
//                 )))
//         : Material(
//             child: InkWell(
//               onTap: _changeGrade,
//               child: Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(18),
//                     border: Border.all(
//                       color: AppColors.greyC3,
//                     ),
//                     color: AppColors.white),
//                 child: Padding(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Expanded(
//                         flex: 3,
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 6.5),
//                           child: Container(
//                             child: Text((selectedGrade != null)
//                                 ? (selectedGrade!.toLowerCase() == 'others')
//                                     ? '$selectedGrade'
//                                     : '$selectedGrade Grade'
//                                 : 'Select Grade'),
//                           ),
//                         ),
//                       ),
//                       const Expanded(
//                         flex: 1,
//                         child: Icon(
//                           Icons.arrow_drop_down,
//                           color: Color(0xFF777474),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ), // Fix is here, don't invoke the function here
//             ),
//           );
//   }
// }

///Custom Dropdown with Headings Widget designed for this application
// class CustomDropdown extends StatefulWidget {
//   List<Grades> items;
//   String? label;
//   bool isFullScreen;
//   bool showLabel;
//   bool showSuffixIcon;
//   bool showPrefixIcon;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final ValueChanged<String>? onGradeChanged;
//   final void Function()? onTap;
//
//   CustomDropdown(
//       {Key? key,
//         required this.items,
//         this.label,
//         this.showSuffixIcon = false,
//         this.showPrefixIcon = false,
//         this.showLabel = false,
//         this.isFullScreen = true,
//         this.onGradeChanged,
//         this.onTap,
//         this.suffixIcon,
//         this.prefixIcon})
//       : super(key: key);
//
//   @override
//   State<CustomDropdown> createState() => _CustomDropdownState();
// }
//
// class _CustomDropdownState extends State<CustomDropdown> {
//   String? selectedGrade;
//
//   Future<void> _changeGrade() async {
//     await showDialog(
//       context: context,
//       useRootNavigator: false,
//       builder: (context) => Dialog(
//         child: Container(
//           width: MediaQuery.of(context).size.width * .50,
//           padding: const EdgeInsets.all(15),
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: widget.items.length,
//             itemBuilder: (ctx, index) => Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                     widget.items[index].label,
//                     style: TextStyle(
//                         fontSize: 15.sp, fontWeight: FontWeight.w800)),
//                 const Divider(thickness: 1),
//                 ExpansionTile(
//                   title: Text("Select Grade"),
//                   children: widget.items[index].value.map((grade) {
//                     return InkWell(
//                       onTap: () {
//                         if (widget.onGradeChanged != null) {
//                           widget.onGradeChanged!(grade);
//                           selectedGrade = grade;
//                         }
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(5),
//                         decoration: (grade == selectedGrade)
//                             ? BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             border: Border.all(color: AppColors.primary),
//                             color: AppColors.primary)
//                             : const BoxDecoration(),
//                         child: Row(
//                           children: [
//                             SizedBox(width: 12.h),
//                             Text(
//                                 grade.toLowerCase() != 'others'
//                                     ? '$grade Grade'
//                                     : grade,
//                                 style: TextStyle(
//                                     fontSize: 14.sp,
//                                     fontWeight: FontWeight.w400)),
//                           ],
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//                 const Divider(thickness: 1),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//     if (mounted) setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return (widget.isFullScreen)
//         ? Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(18),
//             border: Border.all(
//               color: AppColors.greyC3,
//             ),
//             color: AppColors.white),
//         child: Padding(
//             padding:
//             EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (widget.showLabel) ...{
//                   AppText(
//                     widget.label!,
//                     fontWeight: FontWeight.w700,
//                   ),
//                   vHeight(4.h),
//                 },
//                 InkWell(
//                   onTap: _changeGrade,
//                   child: Container(
//                     decoration: (widget.showPrefixIcon)
//                         ? BoxDecoration(
//                         borderRadius: BorderRadius.circular(18),
//                         border: Border.all(
//                           color: AppColors.greyC3,
//                         ),
//                         color: AppColors.white)
//                         : const BoxDecoration(),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         if (widget.showPrefixIcon) ...{
//                           Expanded(flex: 1, child: widget.prefixIcon!)
//                         },
//                         Expanded(
//                           flex: 3,
//                           child: Text((selectedGrade != null)
//                               ? (selectedGrade!.toLowerCase() == 'others')
//                               ? '$selectedGrade'
//                               : '$selectedGrade Grade'
//                               : 'Select Grade'),
//                         ),
//                         if (widget.showSuffixIcon) ...{widget.suffixIcon!}
//                       ],
//                     ),
//                   ), // Fix is here, don't invoke the function here
//                 ),
//               ],
//             )))
//         : Material(
//       child: InkWell(
//         onTap: _changeGrade,
//         child: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(18),
//               border: Border.all(
//                 color: AppColors.greyC3,
//               ),
//               color: AppColors.white),
//           child: Padding(
//             padding:
//             EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Expanded(
//                   flex: 3,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 6.5),
//                     child: Container(
//                       child: Text((selectedGrade != null)
//                           ? (selectedGrade!.toLowerCase() == 'others')
//                           ? '$selectedGrade'
//                           : '$selectedGrade Grade'
//                           : 'Select Grade'),
//                     ),
//                   ),
//                 ),
//                 const Expanded(
//                   flex: 1,
//                   child: Icon(
//                     Icons.arrow_drop_down,
//                     color: Color(0xFF777474),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ), // Fix is here, don't invoke the function here
//       ),
//     );
//   }
// }





class CustomDropdown extends StatefulWidget {
  List<Grades> items;
  String? label;
  String? selectedGrade;
  bool isFullScreen;
  bool showLabel;
  bool showSuffixIcon;
  bool showPrefixIcon;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final ValueChanged<String>? onGradeChanged;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;// Add validator parameter

  CustomDropdown({
    Key? key,
    required this.items,
    this.label,
    this.selectedGrade,
    this.showSuffixIcon = false,
    this.autoValidateMode,
    this.showPrefixIcon = false,
    this.showLabel = false,
    this.isFullScreen = true,
    this.onGradeChanged,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon,
    this.validator, // Initialize validator parameter
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  // String? selectedGrade;

  Future<void> _changeGrade() async {
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width * .50,
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isFullScreen) ...{
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.items.length,
                  itemBuilder: (ctx, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.items[index].label,
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w800)),
                          const Divider(thickness: 1),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.items[index].value.length,
                            itemBuilder: (ctx, outer) => InkWell(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration:
                                      (widget.items[index].value[outer] ==
                                          widget.selectedGrade)
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: AppColors.primary),
                                              color: AppColors.primary)
                                          : const BoxDecoration(),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 12.h),
                                      Text(
                                          widget.items[index].value[outer] !=
                                                  'View All Courses'
                                              ? '${widget.items[index].value[outer]} Grade'
                                              : widget
                                                  .items[index].value[outer],
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  if (widget.onGradeChanged != null) {
                                    widget.onGradeChanged!(
                                        widget.items[index].value[outer]);
                                    widget.selectedGrade =
                                        widget.items[index].value[outer];
                                  }
                                }

                                ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              } else ...{
                // Padding(
                //   padding: const EdgeInsets.only(left: 10, right: 10),
                //   child: InkWell(
                //     onTap: () {
                //       widget.onGradeChanged!('View All Courses');
                //       selectedGrade = 'View All Courses';
                //       print("selectedGrade $selectedGrade");
                //     },
                //     child: Container(
                //       padding: const EdgeInsets.all(5),
                //       decoration: (selectedGrade == 'View All Courses')
                //           ? BoxDecoration(
                //               borderRadius: BorderRadius.circular(5),
                //               border: Border.all(color: AppColors.primary),
                //               color: AppColors.primary)
                //           : const BoxDecoration(),
                //       child: Row(
                //         children: [
                //           // Text('View All Courses',
                //           //     style: TextStyle(
                //           //         fontSize: 15.sp,
                //           //         fontWeight: FontWeight.w800)),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                ExpansionTile(
                  title: Text('View All Courses',
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w800)),
                  initiallyExpanded: ((widget.selectedGrade != 'View All Courses') &&
                      widget.selectedGrade != null),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.items.length,
                        itemBuilder: (ctx, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(widget.items[index].label,
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w800)),
                                const Divider(thickness: 1),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: widget.items[index].value.length,
                                  itemBuilder: (ctx, outer) => InkWell(
                                      child: Container(
                                        // padding: const EdgeInsets.all(5),
                                        padding: EdgeInsets.fromLTRB(
                                            10.w, 5.h, 10.w, 5.h),
                                        decoration: (widget.items[index]
                                                    .value[outer] ==
                                            widget.selectedGrade)
                                            ? BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: AppColors.primary),
                                                color: AppColors.primary)
                                            : const BoxDecoration(),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 12.h),
                                            Text(
                                                widget.items[index]
                                                            .value[outer] !=
                                                        'View All Courses'
                                                    ? '${widget.items[index].value[outer]} Grade'
                                                    : widget.items[index]
                                                        .value[outer],
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        if (widget.onGradeChanged != null) {
                                          widget.onGradeChanged!(
                                              widget.items[index].value[outer]);
                                          widget.selectedGrade =
                                              widget.items[index].value[outer];
                                        }
                                      }),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              }
            ],
          ),
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (widget.isFullScreen)
        ? Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.greyC3,
                ),
                color: AppColors.white),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.showLabel) ...{
                      AppText(
                        widget.label!,
                        fontWeight: FontWeight.w700,
                      ),
                      vHeight(4.h),
                    },
                    InkWell(
                      onTap: _changeGrade,
                      child: Container(
                        decoration: (widget.showPrefixIcon)
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: AppColors.greyC3,
                                ),
                                color: AppColors.white)
                            : const BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            if (widget.showPrefixIcon) ...{
                              Expanded(flex: 1, child: widget.prefixIcon!)
                            },
                            Expanded(
                              flex: 3,
                              child: Text((widget.selectedGrade != null)
                                  ? (widget.selectedGrade == 'View All Courses')
                                      ? '${widget.selectedGrade}'
                                      : '${widget.selectedGrade} Grade'
                                  : 'Select Training'),
                            ),
                            if (widget.showSuffixIcon) ...{widget.suffixIcon!}
                          ],
                        ),
                      ), // Fix is here, don't invoke the function here
                    ),
                  ],
                )))
        : Material(
            child: InkWell(
              onTap: _changeGrade,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: AppColors.greyC3,
                    ),
                    color: AppColors.white),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6.5),
                          child: Container(
                            child: Text((widget.selectedGrade != null)
                                ? (widget.selectedGrade == 'View All Courses')
                                    ? '${widget.selectedGrade}'
                                    : '${widget.selectedGrade} Grade'
                                : 'Select Training'),
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Color(0xFF777474),
                        ),
                      ),
                    ],
                  ),
                ),
              ), // Fix is here, don't invoke the function here
            ),
          );
  }
}
