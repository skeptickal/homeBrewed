import 'dart:io';

import 'package:homeBrewed/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextBox extends StatelessWidget {
  final String? Function(String?)? validator;
  final int? maxLines;
  final EdgeInsets padding;
  final TextEditingController controller;
  final String hintText;
  final String subtitle;
  final int? minLines;
  final bool obscureText;

  const CustomTextBox({
    this.validator,
    this.maxLines,
    required this.padding,
    required this.controller,
    required this.hintText,
    required this.subtitle,
    this.minLines,
    required this.obscureText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: SelectableText(subtitle, style: dndFont.copyWith(fontSize: 14, fontWeight: FontWeight.bold, color: black))),
          const SizedBox(height: 4),
          TextFormField(
            
            validator: validator,
            controller: controller,
            minLines: minLines,
            obscureText: obscureText,
            maxLines: !obscureText ? maxLines : 1,
            keyboardType: TextInputType.multiline,
            decoration: textInputDecoration.copyWith(hintText: hintText, fillColor: backgroundColor),
          ),
        ],
      ),
    );
  }
}

class BigTextBox extends StatelessWidget {
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function()? onEditingComplete;
  final bool enabled;
  final EdgeInsets padding;
  final TextEditingController controller;
  final String hintText;
  final String subtitle;
  final int? minLines;

  const BigTextBox({
    this.maxLength,
    this.maxLines,
    this.keyboardType,
    this.readOnly,
    this.onTapOutside,
    this.onEditingComplete,
    required this.enabled,
    required this.padding,
    required this.controller,
    required this.hintText,
    required this.subtitle,
    this.minLines,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: SelectableText(subtitle, style: dndFont.copyWith(fontSize: 14, fontWeight: FontWeight.bold))),
          const SizedBox(height: 4),
          Focus(
            onFocusChange: (hasFocus) => hasFocus ? null : onEditingComplete!(),
            child: TextField(
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              maxLength: maxLength,
              style: TextStyle(color: !enabled ? disableGrey : black),
              onTapOutside: onTapOutside,
              onEditingComplete: onEditingComplete,
              readOnly: !enabled,
              controller: controller,
              minLines: minLines,
              maxLines: maxLines,
              keyboardType: keyboardType ?? TextInputType.multiline,
              decoration: dndFieldInputDecoration(enabled: enabled, hintText: hintText),
            ),
          ),
        ],
      ),
    );
  }
}

class StatTextBox extends StatelessWidget {
  final int? maxLength;
  final TextInputAction? action;
  final TextInputType? inputType;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function()? onEditingComplete;
  final bool enabled;
  final EdgeInsets padding;
  final TextEditingController controller;
  final String hintText;
  final String subtitle;
  final int? minLines;

  const StatTextBox({
    this.maxLength,
    this.action,
    this.inputType,
    this.onTapOutside,
    this.onEditingComplete,
    required this.enabled,
    required this.padding,
    required this.controller,
    required this.hintText,
    required this.subtitle,
    this.minLines,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: SelectableText(subtitle, textAlign: TextAlign.center, style: dndFont.copyWith(fontSize: 14, fontWeight: FontWeight.bold))),
          Focus(
            onFocusChange: (hasFocus) => hasFocus ? null : onEditingComplete!(),
            child: TextFormField(
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              maxLength: maxLength,
              style: TextStyle(color: !enabled ? const Color.fromARGB(255, 124, 124, 124) : black),
              onTapOutside: onTapOutside,
              onEditingComplete: onEditingComplete,
              textAlign: TextAlign.center,
              readOnly: !enabled,
              controller: controller,
              minLines: minLines,
              maxLines: null,
              textInputAction: action,
              keyboardType: Platform.isIOS ? const TextInputType.numberWithOptions(signed: true, decimal: true) : TextInputType.number,
              decoration: dndFieldInputDecoration(enabled: enabled, hintText: hintText),
            ),
          ),
        ],
      ),
    );
  }
}

final textInputDecoration = InputDecoration(
  fillColor: backgroundColor,
  filled: true,
  hintStyle: dndFont.copyWith(fontSize: 14),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: themeColor, width: 2.0),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: black, width: 2.0),
  ),
);

InputDecoration dndFieldInputDecoration({required bool enabled, required String hintText}) {
  return InputDecoration(
    focusColor: themeColor,
    hintText: hintText,
    fillColor: backgroundColor,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: themeColor, width: enabled ? 2.0 : 1),
    ),
    hintStyle: dndFont.copyWith(fontSize: 14),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: themeColor, width: enabled ? 2.0 : 0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: themeColor, width: enabled ? 2.0 : 1),
    ),
  );
}
