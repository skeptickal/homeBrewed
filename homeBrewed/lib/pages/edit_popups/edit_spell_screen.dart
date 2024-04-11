import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../cubits/spell_cubit/spell_cubit.dart';
import '../../models/spell.dart';

class EditSpellScreen extends StatelessWidget {
  final Spell spell;

  const EditSpellScreen({Key? key, required this.spell}) : super(key: key);
  FormGroup buildForm() => fb.group(<String, Object>{
        'name': FormControl<String>(value: spell.name),
        'spellAtkOrDC': FormControl<String>(value: spell.spellAtkOrDC),
        'description': FormControl<String>(value: spell.description),
      });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpellCubit, SpellState>(
      builder: (context, state) {
        return ReactiveFormBuilder(
          form: buildForm,
          builder: (context, formGroup, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ReactiveTextField<String>(
                    formControlName: 'name',
                    decoration: InputDecoration(labelText: 'Spell Name', labelStyle: dndFont),
                  ),
                  ReactiveTextField<String>(
                    formControlName: 'spellAtkOrDC',
                    decoration: InputDecoration(labelText: 'Spell Attack or DC', labelStyle: dndFont),
                  ),
                  ReactiveTextField<String>(
                    minLines: 1,
                    maxLines: 10,
                    formControlName: 'description',
                    decoration: InputDecoration(labelText: 'Description', labelStyle: dndFont),
                  ),
                  TextButton(
                    onPressed: () {
                      Spell updatedSpell = Spell(
                        spellID: spell.spellID,
                        charID: spell.charID,
                        name: formGroup.control('name').value,
                        spellAtkOrDC: formGroup.control('spellAtkOrDC').value,
                        description: formGroup.control('description').value,
                      );

                      context.read<SpellCubit>().setSpellsData(updatedSpell);
                      context.read<SpellCubit>().readSpellsByCharID(spell.charID);
                      context.pop();
                    },
                    child: Text(
                      'Save Spell',
                      style: dndFont.copyWith(color: themeColor),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
