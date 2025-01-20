import 'package:homeBrewed/constants/theme_data.dart';
import 'package:flutter/material.dart';

SizedBox seperation = const SizedBox(height: 10);
Container horizontalLine = Container(
  padding: const EdgeInsets.only(top: 10),
  decoration: BoxDecoration(
    border: Border(bottom: BorderSide(color: themeColor)),
  ),
);

class SmallHorizontalLine extends StatelessWidget {
  const SmallHorizontalLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.4),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: themeColor)),
        ),
      ),
    );
  }
}
