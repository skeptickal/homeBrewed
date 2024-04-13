import 'package:homeBrewed/cubits/spell_cubit/spell_cubit.dart';
import 'package:homeBrewed/models/spell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../client/spacing.dart';
import '../../constants/theme_data.dart';
import '../add_popups/add_spell_screen.dart';
import '../edit_popups/edit_spell_screen.dart';

class SpellsTab extends StatelessWidget {
  final String charID;
  const SpellsTab({super.key, required this.charID});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          _SpellsList(charID: charID),
          seperation,
          _AddSpell(charID: charID),
        ],
      ),
    );
  }
}

class _SpellsList extends StatelessWidget {
  final String? charID;
  const _SpellsList({required this.charID});

  @override
  Widget build(BuildContext context) {
    context.read<SpellCubit>().readSpellsByCharID(charID);
    return BlocBuilder<SpellCubit, SpellState>(
      builder: (context, state) {
        List<Padding> spells = state.spells!.map(
          (spell) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: themeColor), borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  onTap: () => _onPressedTile(context: context, description: spell.description ?? '', name: spell.name ?? ''),
                  leading: IconButton(
                    onPressed: () {
                      _showPostEditPanel(context, spell);
                    },
                    icon: const FaIcon(FontAwesomeIcons.wandMagic),
                  ),
                  title: Text(
                    spell.name ?? '',
                    style: dndFont.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    spell.spellAtkOrDC ?? '',
                    style: dndFont.copyWith(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_forever_outlined,
                      color: black,
                    ),
                    onPressed: () => _onPressedDeleteIcon(
                      context: context,
                      spellID: spell.spellID!,
                      name: spell.name!,
                      charID: charID!,
                    ),
                  ),
                ),
              ),
            );
          },
        ).toList();
        return Column(children: [
          seperation,
          SelectableText(
            'Spells',
            style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          TextButton(
            child: Text(
              'What is my Spell Casting Ability?',
              style: dndFont.copyWith(fontStyle: FontStyle.italic, color: themeColor),
            ),
            onPressed: () => _onPressedSpellCastingAbilityQuestion(context),
          ),
          TextButton(
            child: Text(
              'What is my Spell Save DC (Difficulty Class)?',
              style: dndFont.copyWith(fontStyle: FontStyle.italic, color: themeColor),
            ),
            onPressed: () => _onPressedSpellSaveDCQuestion(context),
          ),
          seperation,
          ...spells
        ]);
      },
    );
  }
}

void _onPressedDeleteIcon({required BuildContext context, required String spellID, required String name, required String charID}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Are you sure you want to delete $name?',
        style: TextStyle(color: white, fontSize: 18),
      ),
      backgroundColor: themeColor,
      surfaceTintColor: themeColor,
      actions: [
        TextButton(
          child: Text(
            'Delete Permanently',
            style: TextStyle(color: white),
          ),
          onPressed: () {
            context.read<SpellCubit>().deleteSpellBySpellID(spellID).then((result) {
              context.read<SpellCubit>().readSpellsByCharID(charID);
              context.pop();
            });
          },
        ),
      ],
    ),
  );
}

void _onPressedTile({required BuildContext context, required String name, required String description}) {
  showDialog(
    context: context,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Column(
            children: [
              SelectableText(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, color: white, fontWeight: FontWeight.bold),
              ),
              seperation,
              SelectableText(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: white, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          backgroundColor: themeColor,
          surfaceTintColor: themeColor,
          actions: [
            TextButton(
              child: Text(
                'Back',
                style: TextStyle(color: white),
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    ),
  );
}

void _onPressedSpellCastingAbilityQuestion(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Column(
            children: [
              SelectableText(
                'Spellcasting Ability:\n',
                style: TextStyle(fontSize: 22, color: white, fontWeight: FontWeight.bold),
              ),
              SelectableText(
                '• Clerics, Druids, and Rangers: Your spellcasting ability is determined by your Wisdom modifier.\n\n'
                '• Sorcerers, Bards, Paladins, and Warlocks: Your spellcasting ability is determined by your Charisma modifier.\n\n'
                '• Wizards: Your spellcasting ability is determined by your Intelligence modifier.\n\n'
                'Your Spell Attack Modifier is = your proficiency bonus + your spellcasting modifier\n\n'
                'e.g. Bard with Proficiency 3: \n3 + 4(CHA) = 7',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 18, color: white),
              ),
            ],
          ),
          backgroundColor: themeColor,
          surfaceTintColor: themeColor,
          actions: [
            TextButton(
              child: Text(
                'Back',
                style: TextStyle(color: white),
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    ),
  );
}

void _onPressedSpellSaveDCQuestion(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Column(
            children: [
              SelectableText(
                'Spell Save DC (Difficulty Class):\n',
                style: TextStyle(fontSize: 22, color: white, fontWeight: FontWeight.bold),
              ),
              SelectableText(
                '• Your Spell Save DC is a number that represents the difficulty for enemies to resist your spells. It\'s calculated as follows:\n\n'
                '• Spell Save DC = 8 + your proficiency bonus + your spellcasting ability modifier.\n\n'
                'e.g. Bard with Proficiency 3: \n8 + 3(Prof) + 4(CHA) = 15',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 18, color: white),
              ),
            ],
          ),
          backgroundColor: themeColor,
          surfaceTintColor: themeColor,
          actions: [
            TextButton(
              child: Text(
                'Back',
                style: TextStyle(color: white),
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    ),
  );
}

class _AddSpell extends StatelessWidget {
  final String charID;
  const _AddSpell({required this.charID});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: themeColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          iconSize: 25,
          color: white,
          icon: const Icon(Icons.add),
          onPressed: () => _showEditPanel(context, charID),
        ),
      ),
    );
  }
}

void _showEditPanel(BuildContext context, String charID) {
  const uuid = Uuid();
  Spell spell = Spell(charID: charID, spellID: uuid.v4());
  context.read<SpellCubit>().setSpellsData(spell);
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              title: AddSpellScreen(spell: spell),
              backgroundColor: backgroundColor,
              surfaceTintColor: backgroundColor,
            ),
          ),
        );
      });
}

void _showPostEditPanel(BuildContext context, Spell spell) {
  showDialog(
    barrierDismissible: false,
    //barrierColor: black,
    context: context,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          surfaceTintColor: backgroundColor,
          backgroundColor: backgroundColor,
          title: EditSpellScreen(spell: spell),
        ),
      ),
    ),
  );
}
