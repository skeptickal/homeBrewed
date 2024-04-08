import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget child;
  final String title;
  const ScreenWrapper({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        title: Text(
          title,
          style: dndFont.copyWith(color: white),
        ),
        centerTitle: true,
        backgroundColor: themeColor,
      ),
      body: child,
    );
  }
}
