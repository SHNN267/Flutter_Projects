import 'package:flutter/material.dart';

/// Reusable customizable button.
/// - you can pass backgroundColor, width, height, text, textStyle (font),
///   borderRadius, elevation, padding, onPressed, prefix/suffix icon, etc.
/// - sensible defaults are provided so you can use it with minimal args.
class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  // sizing
  final double?
  width; // null -> takes available width (wrap by SizedBox or Row)
  final double? height; // null -> defaultHeight
  final EdgeInsetsGeometry padding;

  // visuals
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final BorderSide? border; // if you want stroke

  // text style
  final TextStyle?
  textStyle; // if provided, overrides textColor/fontSize/fontFamily
  final double fontSize;
  final String? fontFamily;
  final FontWeight fontWeight;

  // icons
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final MainAxisAlignment contentAlignment;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 120,
    this.height,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.backgroundColor = Colors.teal, // default navy-ish
    this.textColor = Colors.white,
    this.borderRadius = 10.0,
    this.elevation = 2.0,
    this.border,
    this.textStyle,
    this.fontSize = 16,
    this.fontFamily,
    this.fontWeight = FontWeight.w600,
    this.prefixIcon,
    this.suffixIcon,
    this.contentAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextStyle =
        textStyle ??
        TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontFamily: fontFamily,
          fontWeight: fontWeight,
        );

    final buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: contentAlignment,
      children: [
        if (prefixIcon != null) ...[prefixIcon!, const SizedBox(width: 8)],
        Flexible(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: effectiveTextStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (suffixIcon != null) ...[const SizedBox(width: 8), suffixIcon!],
      ],
    );

    final shaped = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      side: border ?? BorderSide.none,
    );

    Widget button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: elevation,
        padding: padding,
        shape: shaped,
      ),
      child: buttonChild,
    );

    // If width/height specified, wrap with SizedBox
    if (width != null || height != null) {
      button = SizedBox(width: width, height: height, child: button);
    }

    return button;
  }
}
