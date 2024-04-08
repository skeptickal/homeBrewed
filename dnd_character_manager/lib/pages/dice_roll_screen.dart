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
          'Roll',
          style: dndFont.copyWith(fontSize: 18, color: white, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: TextField(
            style: TextStyle(color: white),
            maxLines: 1,
            controller: diceRoll,
            decoration: InputDecoration(
              labelText: 'e.g. 2d8 + 4d6 + 5',
              labelStyle: TextStyle(color: white),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: white),
              ),
            ),
          ),
        ),
        seperation,
        IconButton(
          onPressed: () {
            _showRollDialog(context, diceRoll.text);
          },
          icon: FaIcon(
            FontAwesomeIcons.diceD20,
            size: 30,
            color: white,
          ),
        ),
        Text(
          '(rolls 1d20 if left blank)',
          style: TextStyle(fontSize: 16, color: white, fontStyle: FontStyle.italic),
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
        backgroundColor: themeColor,
        title: Center(
          child: Text(
            '$roll: ',
            style: dndFont.copyWith(fontSize: 20, color: white),
          ),
        ),
        content: Text(
          textAlign: TextAlign.center,
          '= $rollResult',
          style: (TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: white,
          )),
        ),
      );
    },
  );
}
