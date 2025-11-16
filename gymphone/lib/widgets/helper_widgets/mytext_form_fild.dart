import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymphone/constants/colos/Mycolors.dart';

/// A clean and customizable TextFormField with a white background by default.
class MyTextFormFild extends StatelessWidget {
  // Core
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final TextStyle? textStyle;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final int maxLines;
  final int minLines;
  final int? maxLength;

  // Design
  final double borderRadius;
  final Color backgroundColor;
  final double elevation;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  // Behavior
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;

  const MyTextFormFild({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.textStyle,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.borderRadius = 12.0,
    this.backgroundColor = Colors.white, // ✅ Always white by default
    this.elevation = 0.0,
    this.enabledBorderColor = const Color(0xFFFFFFFF),
    this.focusedBorderColor = Colors.black,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: enabledBorderColor, width: 1.2),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: focusedBorderColor, width: 1.6),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: elevation,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: TextFormField(
            cursorColor: MyColor.black,
            controller: controller,
            enabled: enabled,
            obscureText: obscureText,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            maxLines: maxLines,
            minLines: minLines,
            maxLength: maxLength,
            style: textStyle ?? const TextStyle(color: Colors.black),
            validator: validator,
            onChanged: onChanged,
            onTap: onTap,
            onFieldSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              floatingLabelStyle: TextStyle(color: MyColor.black),
              labelText: labelText,
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              enabledBorder: border,
              focusedBorder: focusedBorder,

              filled: true, // ✅ enable background color
              fillColor: backgroundColor, // ✅ white background visible
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
