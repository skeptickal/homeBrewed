import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:dnd_character_manager/models/weapon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubits/weapon_cubit/weapon_cubit.dart';

class AddWeaponScreen extends StatelessWidget {
  final Weapon weapon;
  const AddWeaponScreen({super.key, required this.weapon});

  @override
  Widget build(BuildContext context) {
    print('Jeff ${weapon.weaponID}');
    TextEditingController name = TextEditingController(text: weapon.name);
    TextEditingController attackRoll = TextEditingController(text: weapon.attackRoll);
    TextEditingController damageRoll = TextEditingController(text: weapon.damageRoll);
    TextEditingController description = TextEditingController(text: weapon.description);

    return BlocBuilder<WeaponCubit, WeaponState>(
      builder: (context, state) {
        return Form(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                BigTextBox(
                  onTapOutside: (clickOut) {
                    context.read<WeaponCubit>().setWeaponsData(weapon.copyWith(
                          name: name.text,
                          attackRoll: attackRoll.text,
                          damageRoll: damageRoll.text,
                          description: description.text,
                        ));
                    context.read<WeaponCubit>().readWeaponsByCharID(weapon.charID);
                  },
                  onEditingComplete: () {
                    context.read<WeaponCubit>().setWeaponsData(weapon.copyWith(
                          name: name.text,
                          attackRoll: attackRoll.text,
                          damageRoll: damageRoll.text,
                          description: description.text,
                        ));
                    context.read<WeaponCubit>().readWeaponsByCharID(weapon.charID);
                  },
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: name,
                  hintText: 'Weapon name',
                  subtitle: 'Weapon name',
                ),
                BigTextBox(
                  onTapOutside: (clickOut) {
                    context.read<WeaponCubit>().setWeaponsData(weapon.copyWith(
                          name: name.text,
                          attackRoll: attackRoll.text,
                          damageRoll: damageRoll.text,
                          description: description.text,
                        ));
                    context.read<WeaponCubit>().readWeaponsByCharID(weapon.charID);
                  },
                  onEditingComplete: () {
                    context.read<WeaponCubit>().setWeaponsData(weapon.copyWith(
                          name: name.text,
                          attackRoll: attackRoll.text,
                          damageRoll: damageRoll.text,
                          description: description.text,
                        ));
                    context.read<WeaponCubit>().readWeaponsByCharID(weapon.charID);
                  },
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: attackRoll,
                  hintText: '1d20 + 5 (STR)',
                  subtitle: 'Attack Roll',
                ),
                BigTextBox(
                  onTapOutside: (clickOut) {
                    context.read<WeaponCubit>().setWeaponsData(weapon.copyWith(
                          name: name.text,
                          attackRoll: attackRoll.text,
                          damageRoll: damageRoll.text,
                          description: description.text,
                        ));
                    context.read<WeaponCubit>().readWeaponsByCharID(weapon.charID);
                  },
                  onEditingComplete: () {
                    context.read<WeaponCubit>().setWeaponsData(weapon.copyWith(
                          name: name.text,
                          attackRoll: attackRoll.text,
                          damageRoll: damageRoll.text,
                          description: description.text,
                        ));
                    context.read<WeaponCubit>().readWeaponsByCharID(weapon.charID);
                  },
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: damageRoll,
                  hintText: '1d10 + 2 Bludgeoning',
                  subtitle: 'Damage Roll + Type',
                ),
                BigTextBox(
                  onTapOutside: (clickOut) {
                    context.read<WeaponCubit>().setWeaponsData(weapon.copyWith(
                          name: name.text,
                          attackRoll: attackRoll.text,
                          damageRoll: damageRoll.text,
                          description: description.text,
                        ));
                    context.read<WeaponCubit>().readWeaponsByCharID(weapon.charID);
                  },
                  onEditingComplete: () {
                    context.read<WeaponCubit>().setWeaponsData(weapon.copyWith(
                          name: name.text,
                          attackRoll: attackRoll.text,
                          damageRoll: damageRoll.text,
                          description: description.text,
                        ));
                    context.read<WeaponCubit>().readWeaponsByCharID(weapon.charID);
                  },
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: description,
                  hintText: 'Has a chance to burn target',
                  subtitle: 'Description (Optional)',
                  minLines: 5,
                ),
                TextButton(
                  onPressed: () {
                    context.read<WeaponCubit>().readWeaponsByCharID(weapon.charID);
                    context.pop();
                  },
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
}
