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
        toolbarHeight: 150,
        iconTheme: IconThemeData(color: white),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Column(
            children: [
              Text(
                title,
                style: dndFont.copyWith(color: white, fontSize: 30),
              ),
              SizedBox(
                height: 25,
              ),
              IconButton(
                  onPressed: () => _showDiceRoll(context),
                  icon: const FaIcon(
                    FontAwesomeIcons.diceD20,
                    size: 35,
                  )),
            ],
          ),
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
