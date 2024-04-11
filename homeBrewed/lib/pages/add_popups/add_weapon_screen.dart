import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../cubits/weapon_cubit/weapon_cubit.dart';
import '../../models/weapon.dart';

class AddWeaponScreen extends StatelessWidget {
  final Weapon weapon;

  const AddWeaponScreen({Key? key, required this.weapon}) : super(key: key);
  FormGroup buildForm() => fb.group(<String, Object>{
        'name': FormControl<String>(value: weapon.name),
        'attackRoll': FormControl<String>(value: weapon.attackRoll),
        'damageRoll': FormControl<String>(value: weapon.damageRoll),
        'description': FormControl<String>(value: weapon.description),
      });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeaponCubit, WeaponState>(
      builder: (context, state) {
        return ReactiveFormBuilder(
            form: buildForm,
            builder: (context, form, child) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ReactiveTextField<String>(
                      formControlName: 'name',
                      decoration: InputDecoration(labelText: 'Weapon Name', labelStyle: dndFont),
                    ),
                    ReactiveTextField<String>(
                      formControlName: 'attackRoll',
                      decoration: InputDecoration(labelText: 'Attack Roll', labelStyle: dndFont),
                    ),
                    ReactiveTextField<String>(
                      formControlName: 'damageRoll',
                      decoration: InputDecoration(labelText: 'Damage Roll', labelStyle: dndFont),
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
                        Weapon updatedWeapon = Weapon(
                          weaponID: weapon.weaponID,
                          charID: weapon.charID,
                          name: form.control('name').value,
                          attackRoll: form.control('attackRoll').value,
                          damageRoll: form.control('damageRoll').value,
                          description: form.control('description').value,
                        );

                        context.read<WeaponCubit>().setWeaponsData(updatedWeapon);
                        context.read<WeaponCubit>().readWeaponsByCharID(weapon.charID);
                        context.pop();
                      },
                      child: Text(
                        'Save Weapon',
                        style: dndFont.copyWith(color: themeColor),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<WeaponCubit>().deleteWeaponByWeaponID(weapon.weaponID!);
                        context.read<WeaponCubit>().readWeaponsByCharID(weapon.charID);
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
