import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget child;
  const ScreenWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'D&D Character Manager',
          style: dndFont.copyWith(color: white),
        ),
        centerTitle: true,
        backgroundColor: blueGrey,
      ),
      body: child,
    );
  }
}
