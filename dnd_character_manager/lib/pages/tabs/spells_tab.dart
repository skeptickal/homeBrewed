import 'package:dnd_character_manager/cubits/spell_cubit/spell_cubit.dart';
import 'package:dnd_character_manager/models/spell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../client/spacing.dart';
import '../../constants/theme_data.dart';
import '../add_spell_screen.dart';
import '../edit_spell_screen.dart';

class SpellsTab extends StatelessWidget {
  final String charID;
  const SpellsTab({super.key, required this.charID});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          Text(
            'Spells',
            style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
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
          title: Text(
            '$name\n\n$description',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: white),
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
          color: Colors.white,
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
          color: themeColor,
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
        return Center(child: SingleChildScrollView(child: AlertDialog(title: AddSpellScreen(spell: spell))));
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
          title: EditSpellScreen(spell: spell),
        ),
      ),
    ),
  );
}
