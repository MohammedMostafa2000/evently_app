import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.isSecure = false,
    this.onClicked,
    this.hintText,
    this.maxLines = 1,
    this.controller,
  });
  final String? label;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? hintText;
  final bool isSecure;
  final VoidCallback? onClicked;
  final int? maxLines;
  final TextEditingController? controller;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: TextStyle(
        color: Theme.of(context).inputDecorationTheme.hintStyle?.color,
      ),
      maxLines: widget.maxLines,
      obscureText: widget.isSecure,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: IconButton(
          onPressed: widget.onClicked,
          icon: Icon(widget.suffixIcon),
        ),
        labelText: widget.label,
      ),
    );
  }
}
