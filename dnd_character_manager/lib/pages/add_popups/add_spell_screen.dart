import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:dnd_character_manager/models/spell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../cubits/spell_cubit/spell_cubit.dart';

class AddSpellScreen extends StatelessWidget {
  final Spell spell;
  const AddSpellScreen({super.key, required this.spell});

  @override
  Widget build(BuildContext context) {
    print('Jeff ${spell.spellID}');
    TextEditingController name = TextEditingController(text: spell.name);
    TextEditingController spellAtkOrDC = TextEditingController(text: spell.spellAtkOrDC);
    TextEditingController description = TextEditingController(text: spell.description);

    return BlocBuilder<SpellCubit, SpellState>(
      builder: (context, state) {
        return Form(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                BigTextBox(
                  onTapOutside: (clickOut) {
                    context.read<SpellCubit>().setSpellsData(spell.copyWith(
                          name: name.text,
                          spellAtkOrDC: spellAtkOrDC.text,
                          description: description.text,
                        ));
                    context.read<SpellCubit>().readSpellsByCharID(spell.charID);
                  },
                  onEditingComplete: () {
                    context.read<SpellCubit>().setSpellsData(spell.copyWith(
                          name: name.text,
                          spellAtkOrDC: spellAtkOrDC.text,
                          description: description.text,
                        ));
                    context.read<SpellCubit>().readSpellsByCharID(spell.charID);
                  },
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: name,
                  hintText: 'Spell name',
                  subtitle: 'Spell name',
                ),
                BigTextBox(
                  onTapOutside: (clickOut) {
                    context.read<SpellCubit>().setSpellsData(spell.copyWith(
                          name: name.text,
                          spellAtkOrDC: spellAtkOrDC.text,
                          description: description.text,
                        ));
                    context.read<SpellCubit>().readSpellsByCharID(spell.charID);
                  },
                  onEditingComplete: () {
                    context.read<SpellCubit>().setSpellsData(spell.copyWith(
                          name: name.text,
                          spellAtkOrDC: spellAtkOrDC.text,
                          description: description.text,
                        ));
                    context.read<SpellCubit>().readSpellsByCharID(spell.charID);
                  },
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: spellAtkOrDC,
                  hintText: 'CHA + 5 or DC 12 DEX',
                  subtitle: 'Spell Attack or DC Save',
                ),
                BigTextBox(
                  onTapOutside: (clickOut) {
                    context.read<SpellCubit>().setSpellsData(spell.copyWith(
                          name: name.text,
                          spellAtkOrDC: spellAtkOrDC.text,
                          description: description.text,
                        ));
                    context.read<SpellCubit>().readSpellsByCharID(spell.charID);
                  },
                  onEditingComplete: () {
                    context.read<SpellCubit>().setSpellsData(spell.copyWith(
                          name: name.text,
                          spellAtkOrDC: spellAtkOrDC.text,
                          description: description.text,
                        ));
                    context.read<SpellCubit>().readSpellsByCharID(spell.charID);
                  },
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: description,
                  hintText: 'e.g. Graphic description of Fireball',
                  subtitle: 'Description (Optional)',
                  minLines: 5,
                ),
                TextButton(
                  onPressed: () {
                    context.read<SpellCubit>().readSpellsByCharID(spell.charID);
                    context.pop();
                  },
                  child: Text(
                    'Add Spell',
                    style: dndFont.copyWith(color: black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<SpellCubit>().deleteSpellBySpellID(spell.spellID!);
                    context.read<SpellCubit>().readSpellsByCharID(spell.charID);
                    context.pop();
                  },
                  child: Text(
                    'Cancel',
                    style: dndFont.copyWith(color: black),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
