import 'package:homeBrewed/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../cubits/spell_cubit/spell_cubit.dart';
import '../../models/spell.dart';

class AddSpellScreen extends StatelessWidget {
  final Spell spell;

  const AddSpellScreen({Key? key, required this.spell}) : super(key: key);
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
            builder: (context, form, child) {
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
                        print('Jeff ${form.control('name').value}');
                        Spell updatedSpell = Spell(
                          spellID: spell.spellID,
                          charID: spell.charID,
                          name: form.control('name').value,
                          spellAtkOrDC: form.control('spellAtkOrDC').value,
                          description: form.control('description').value,
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
                    TextButton(
                      onPressed: () {
                        context.read<SpellCubit>().deleteSpellBySpellID(spell.spellID!);
                        context.read<SpellCubit>().readSpellsByCharID(spell.charID);
                        context.pop();
                      },
                      child: Text(
                        'Cancel',
                        style: dndFont.copyWith(color: themeColor),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
