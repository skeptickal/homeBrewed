import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final EdgeInsets padding;
  final TextEditingController controller;
  final String hintText;
  final String subtitle;
  final int? minLines;
  final bool obscureText;

  const CustomTextBox({
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
          Center(child: Text(subtitle, style: dndFont.copyWith(fontSize: 14, fontWeight: FontWeight.bold))),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            minLines: minLines,
            obscureText: obscureText,
            maxLines: 1,
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
          Center(child: Text(subtitle, style: dndFont.copyWith(fontSize: 14, fontWeight: FontWeight.bold))),
          const SizedBox(height: 4),
          Focus(
            onFocusChange: (hasFocus) => hasFocus ? null : onEditingComplete!(),
            child: TextField(
              textInputAction: TextInputAction.none,
              onTapOutside: onTapOutside,
              onEditingComplete: onEditingComplete,
              enabled: enabled,
              controller: controller,
              minLines: minLines,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: textInputDecoration.copyWith(hintText: hintText),
            ),
          ),
        ],
      ),
    );
  }
}

class StatTextBox extends StatelessWidget {
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function()? onEditingComplete;
  final bool enabled;
  final EdgeInsets padding;
  final TextEditingController controller;
  final String hintText;
  final String subtitle;
  final int? minLines;

  const StatTextBox({
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
          Center(child: Text(subtitle, style: dndFont.copyWith(fontSize: 14, fontWeight: FontWeight.bold))),
          const SizedBox(height: 4),
          Focus(
            onFocusChange: (hasFocus) => hasFocus ? null : onEditingComplete!(),
            child: TextFormField(
              onTapOutside: onTapOutside,
              onEditingComplete: onEditingComplete,
              textAlign: TextAlign.center,
              enabled: enabled,
              controller: controller,
              minLines: minLines,
              maxLines: null,
              keyboardType: TextInputType.number,
              decoration: textInputDecoration.copyWith(hintText: hintText),
            ),
          ),
        ],
      ),
    );
  }
}

final textInputDecoration = InputDecoration(
  // suffixIcon: Align(
  //   widthFactor: 1.0,
  //   heightFactor: 1.0,
  //   child: IconButton(
  //     icon: Icon(Icons.save),
  //     onPressed: () {},
  //   ),
  // ),
  fillColor: white,
  filled: true,
  hintStyle: dndFont.copyWith(fontSize: 14),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: blueGrey, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: black, width: 2.0),
  ),
);
