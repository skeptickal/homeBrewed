import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final int? maxLines;
  final EdgeInsets padding;
  final TextEditingController controller;
  final String hintText;
  final String subtitle;
  final int? minLines;
  final bool obscureText;

  const CustomTextBox({
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
          Center(child: Text(subtitle, style: dndFont.copyWith(fontSize: 14, fontWeight: FontWeight.bold, color: white))),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            minLines: minLines,
            obscureText: obscureText,
            maxLines: !obscureText ? maxLines : 1,
            keyboardType: TextInputType.multiline,
            decoration: textInputDecoration.copyWith(hintText: hintText),
          ),
        ],
      ),
    );
  }
}

class BigTextBox extends StatelessWidget {
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
          Center(child: Text(subtitle, style: dndFont.copyWith(fontSize: 14, fontWeight: FontWeight.bold, color: white))),
          const SizedBox(height: 4),
          Focus(
            onFocusChange: (hasFocus) => hasFocus ? null : onEditingComplete!(),
            child: TextField(
              style: TextStyle(color: !enabled ? disableGrey : white),
              textInputAction: TextInputAction.none,
              onTapOutside: onTapOutside,
              onEditingComplete: onEditingComplete,
              readOnly: !enabled,
              controller: controller,
              minLines: minLines,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: dndFieldInputDecoration(enabled: enabled, hintText: hintText),
            ),
          ),
        ],
      ),
    );
  }
}

class StatTextBox extends StatelessWidget {
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
          Center(child: Text(subtitle, textAlign: TextAlign.center, style: dndFont.copyWith(fontSize: 14, fontWeight: FontWeight.bold, color: white))),
          Focus(
            onFocusChange: (hasFocus) => hasFocus ? null : onEditingComplete!(),
            child: TextFormField(
              style: TextStyle(color: !enabled ? const Color.fromARGB(255, 124, 124, 124) : white),
              onTapOutside: onTapOutside,
              onEditingComplete: onEditingComplete,
              textAlign: TextAlign.center,
              readOnly: !enabled,
              controller: controller,
              minLines: minLines,
              maxLines: null,
              textInputAction: action,
              keyboardType: inputType ?? TextInputType.number,
              decoration: dndFieldInputDecoration(enabled: enabled, hintText: hintText),
            ),
          ),
        ],
      ),
    );
  }
}

final textInputDecoration = InputDecoration(
  fillColor: black,
  filled: true,
  hintStyle: dndFont.copyWith(fontSize: 14, color: white),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: white, width: 2.0),
  ),
);

InputDecoration dndFieldInputDecoration({required bool enabled, required String hintText}) {
  return InputDecoration(
    hintText: hintText,
    fillColor: black,
    filled: true,
    hintStyle: dndFont.copyWith(fontSize: 14, color: white),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: themeColor, width: enabled ? 2.0 : 0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: white, width: enabled ? 2.0 : 1),
    ),
  );
}
