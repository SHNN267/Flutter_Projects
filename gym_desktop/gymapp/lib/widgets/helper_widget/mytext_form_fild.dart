import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A fully customizable TextFormField widget.
/// - Every property has a default value.
/// - If you don't pass a parameter, the widget uses a reasonable default.
class MyTextFormFild extends StatelessWidget {
  // Content / Control
  final TextEditingController? controller;
  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final TextDirection? textDirection;

  // Size constraints
  final double? width; // If null → takes available width
  final double? height; // If null → depends on content or maxLines
  final EdgeInsetsGeometry padding;

  // Appearance: background, border, shadow
  final Color backgroundColor;
  final double borderRadius;
  final double elevation;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color cursorColor;

  // Behavior / Input settings
  final bool enabled;
  final bool obscureText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final int minLines;
  final int? maxLength;

  // Icons and decorations
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  // Validation and callbacks
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;

  /// Constructor with optional parameters — all have defaults
  const MyTextFormFild({
    super.key,
    this.controller,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.labelStyle,
    this.hintStyle,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.width = 400,
    this.height,
    this.padding = const EdgeInsets.all(6.0),
    this.backgroundColor = const Color(0xFFF7F7F7), // off-white by default
    this.borderRadius = 12.0,
    this.elevation = 0.0,
    this.enabledBorderColor = const Color(0xFFBDBDBD),
    this.focusedBorderColor = Colors.black,
    this.cursorColor = Colors.black,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    // Define the default enabled border style
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: enabledBorderColor, width: 1.2),
    );

    // Define the border style when focused
    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: focusedBorderColor, width: 1.6),
    );

    // The actual TextFormField widget
    Widget textField = TextFormField(
      controller: controller,
      // Use initialValue only if no controller is provided
      initialValue: controller == null ? initialValue : null,
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      cursorColor: cursorColor,
      textAlign: textAlign,
      textDirection: textDirection,
      style: textStyle ?? const TextStyle(color: Colors.black),
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        isDense: true, // Makes the field more compact
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        labelText: labelText,
        hintText: hintText,
        labelStyle: labelStyle,
        hintStyle: hintStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: border,
        focusedBorder: focusedBorder,
      ),
    );

    // Add padding around the text field
    Widget inner = Padding(padding: padding, child: textField);

    // Apply custom width or height if provided
    if (width != null || height != null) {
      inner = SizedBox(width: width, height: height, child: inner);
    }

    // Wrap with Material to allow elevation (shadow)
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: elevation,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: inner,
        ),
      ),
    );
  }
}
