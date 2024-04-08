import 'package:d20/d20.dart';
import 'package:dnd_character_manager/client/spacing.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DiceRollScreen extends StatelessWidget {
  const DiceRollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController diceRoll = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Roll (Standard Format)',
          style: dndFont.copyWith(fontSize: 18, color: themeColor, fontWeight: FontWeight.bold),
        ),
        Text(
          'e.g. 2d8 + 4d6 + 5',
          style: dndFont.copyWith(fontSize: 16, color: themeColor, fontStyle: FontStyle.italic),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: TextField(
            maxLines: 1,
            controller: diceRoll,
            keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
          ),
        ),
        seperation,
        IconButton(
          onPressed: () {
            _showRollDialog(context, diceRoll.text);
          },
          icon: const FaIcon(
            FontAwesomeIcons.diceD20,
            size: 30,
          ),
        ),
        Text(
          '(rolls 1d20 if left blank)',
          style: TextStyle(fontSize: 16, color: themeColor, fontStyle: FontStyle.italic),
        )
      ],
    );
  }
}

void _showRollDialog(
  BuildContext context,
  String? roll,
) {
  String rollResult;
  try {
    if (roll == '') {
      roll = 'd20';
    }
    final d20 = D20();
    rollResult = d20.roll(roll!).toString();
  } catch (e) {
    rollResult = 'Invalid input';
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Roll Result of $roll: ',
          style: dndFont,
        ),
        content: Text(
          textAlign: TextAlign.center,
          rollResult,
          style: (const TextStyle(fontSize: 18)),
        ),
      );
    },
  );
}
