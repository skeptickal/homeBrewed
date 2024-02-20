import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final EdgeInsets padding;
  final TextEditingController controller;
  final String hintText;
  final String subtitle;
  final int? minLines;

  const CustomTextBox({
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
          Text(subtitle, style: dndFont.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            minLines: minLines,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: textInputDecoration.copyWith(hintText: hintText),
          ),
        ],
      ),
    );
  }
}

final textInputDecoration = InputDecoration(
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
