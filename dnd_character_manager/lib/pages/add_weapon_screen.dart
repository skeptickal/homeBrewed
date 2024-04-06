import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:dnd_character_manager/models/weapon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../cubits/weapon_cubit/weapon_cubit.dart';

class AddWeaponScreen extends StatelessWidget {
  final String charID;
  const AddWeaponScreen({super.key, required this.charID});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController attackRoll = TextEditingController();
    TextEditingController damageRoll = TextEditingController();
    TextEditingController description = TextEditingController();

    return BlocBuilder<WeaponCubit, WeaponState>(
      builder: (context, state) {
        return Form(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                CustomTextBox(
                  padding: const EdgeInsets.all(6),
                  controller: name,
                  hintText: 'Weapon name',
                  subtitle: 'Weapon name',
                  obscureText: false,
                ),
                CustomTextBox(
                  padding: const EdgeInsets.all(6),
                  controller: attackRoll,
                  hintText: '1d20 + 5 (STR)',
                  subtitle: 'Attack Roll',
                  obscureText: false,
                ),
                CustomTextBox(
                  padding: const EdgeInsets.all(6),
                  controller: damageRoll,
                  hintText: '1d10 + 2 Bludgeoning',
                  subtitle: 'Damage Roll + Type',
                  obscureText: false,
                ),
                CustomTextBox(
                  padding: const EdgeInsets.all(6),
                  controller: description,
                  hintText: 'Has a chance to burn target',
                  subtitle: 'Description (Optional)',
                  obscureText: false,
                ),
                TextButton(
                  onPressed: () => _addWeapon(
                    context: context,
                    name: name.text,
                    attackRoll: attackRoll.text,
                    damageRoll: damageRoll.text,
                    description: description.text,
                    charID: charID,
                  ),
                  child: Text(
                    'Add Weapon',
                    style: dndFont,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addWeapon({required BuildContext context, String? name, String? attackRoll, String? damageRoll, String? charID, String? description}) {
    const uuid = Uuid();
    Weapon newWeapon = Weapon(
      weaponID: uuid.v4(),
      charID: charID,
      name: name,
      attackRoll: attackRoll,
      damageRoll: damageRoll,
      description: description,
    );
    context.read<WeaponCubit>().setWeaponsData(newWeapon);
    context.pop();
  }
}
