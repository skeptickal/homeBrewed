import 'package:homeBrewed/constants/theme_data.dart';
import 'package:homeBrewed/pages/dice_roll_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget child;
  final String title;
  const ScreenWrapper({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => _showDiceRoll(context),
              icon: const FaIcon(
                FontAwesomeIcons.diceD20,
              )),
        ],
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

void _showDiceRoll(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: themeColor,
        title: const DiceRollScreen(),
      );
    },
  );
}
