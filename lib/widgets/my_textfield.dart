import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yolustunde_mobile/theme/colors.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield({
    Key? key,
    this.text,
    this.controller,
    this.validator,
    this.maxLines = 1,
    this.onTap,
    this.readOnly = false,
    this.hintText,
    this.suffixText,
    this.prefixText,
    this.onChanged,
    this.fillColor,
    this.hintColor,
    this.textColor = Colors.white,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters,
    this.keyboardType,
    this.obscureText = false,
    this.border = false,
    this.maxLength,
    this.showCounterText = false,
  }) : super(key: key);

  final String? text;
  final String? hintText;
  final String? suffixText;
  final String? prefixText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLines;
  final void Function()? onTap;
  final bool readOnly;
  final void Function(String)? onChanged;
  final Color? fillColor;
  final Color? hintColor;
  final Color? textColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool border;
  final int? maxLength;
  final bool showCounterText;
  factory MyTextfield.white({
    Key? key,
    String? text,
    String? hintText,
    String? suffixText,
    String? prefixText,
    TextEditingController? controller,
    String? Function(String?)? validator,
    int? maxLines,
    void Function()? onTap,
    bool readOnly = false,
    void Function(String)? onChanged,
    Color? fillColor = Colors.white,
    Widget? prefixIcon,
    Widget? suffixIcon,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    bool border = true,
    Color hintColor = MyColors.greyLight,
    Color textColor = Colors.black,
    int? maxLength,
    bool showCounterText = false,
  }) {
    return MyTextfield(
      key: key,
      text: text,
      hintText: hintText,
      suffixText: suffixText,
      prefixText: prefixText,
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      onTap: onTap,
      readOnly: readOnly,
      onChanged: onChanged,
      fillColor: fillColor,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      border: border,
      hintColor: hintColor,
      textColor: textColor,
      maxLength: maxLength,
      showCounterText: showCounterText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (text != null) ...[
          Text(text!),
          SizedBox(height: 6),
        ],
        SizedBox(
          child: TextFormField(
            maxLength: maxLength,
            obscureText: obscureText,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            onChanged: onChanged,
            readOnly: readOnly,
            onTap: onTap,
            maxLines: maxLines,
            validator: validator,
            controller: controller,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              counterText: showCounterText ? null : "",
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              isDense: true,
              hintText: hintText,
              suffixText: suffixText,
              prefixText: prefixText,

              // prefixStyle: TextStyle(color: MyColors.red),
              contentPadding: EdgeInsets.only(left: 18, right: 10, top: 18, bottom: 18),
              fillColor: fillColor ?? MyColors.grey.withOpacity(0.8),
              filled: true,
              hintStyle: TextStyle(color: hintColor ?? Colors.white.withOpacity(0.6)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: border ? BorderSide(color: MyColors.greyLight2) : BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: border ? BorderSide(color: MyColors.greyLight2) : BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: border ? BorderSide(color: MyColors.yellow) : BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
