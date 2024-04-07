import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:dnd_character_manager/models/weapon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubits/weapon_cubit/weapon_cubit.dart';

class EditWeaponScreen extends StatelessWidget {
  final Weapon weapon;
  const EditWeaponScreen({super.key, required this.weapon});

  @override
  Widget build(BuildContext context) {
    print('Jeff ${weapon.weaponID}');
    context.read<WeaponCubit>().readWeaponData(weapon.weaponID!);

    return BlocBuilder<WeaponCubit, WeaponState>(
      builder: (context, state) {
        TextEditingController name = TextEditingController();
        name.text = state.weapon!.name ?? '';
        TextEditingController attackRoll = TextEditingController();
        attackRoll.text = state.weapon!.attackRoll ?? '';
        TextEditingController damageRoll = TextEditingController();
        damageRoll.text = state.weapon!.damageRoll ?? '';
        TextEditingController description = TextEditingController();
        description.text = state.weapon!.description ?? '';
        print('Jeff pls ${state.weapon}');

        return Form(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                BigTextBox(
                  onTapOutside: (clickOut) => context.read<WeaponCubit>().setWeaponsData(
                        weapon.copyWith(name: name.text),
                      ),
                  onEditingComplete: () => context.read<WeaponCubit>().setWeaponsData(
                        weapon.copyWith(name: name.text),
                      ),
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: name,
                  hintText: 'Weapon name',
                  subtitle: 'Weapon name',
                ),
                BigTextBox(
                  onTapOutside: (clickOut) => context.read<WeaponCubit>().setWeaponsData(
                        weapon.copyWith(attackRoll: attackRoll.text),
                      ),
                  onEditingComplete: () => context.read<WeaponCubit>().setWeaponsData(
                        weapon.copyWith(attackRoll: attackRoll.text),
                      ),
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: attackRoll,
                  hintText: '1d20 + 5 (STR)',
                  subtitle: 'Attack Roll',
                ),
                BigTextBox(
                  onTapOutside: (clickOut) => context.read<WeaponCubit>().setWeaponsData(
                        weapon.copyWith(damageRoll: damageRoll.text),
                      ),
                  onEditingComplete: () => context.read<WeaponCubit>().setWeaponsData(
                        weapon.copyWith(damageRoll: damageRoll.text),
                      ),
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: damageRoll,
                  hintText: '1d10 + 2 Bludgeoning',
                  subtitle: 'Damage Roll + Type',
                ),
                BigTextBox(
                  onTapOutside: (clickOut) => context.read<WeaponCubit>().setWeaponsData(
                        weapon.copyWith(description: description.text),
                      ),
                  onEditingComplete: () => context.read<WeaponCubit>().setWeaponsData(
                        weapon.copyWith(description: description.text),
                      ),
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: description,
                  hintText: 'Has a chance to burn target',
                  subtitle: 'Description (Optional)',
                  minLines: 5,
                ),
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    'Done Editing',
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
