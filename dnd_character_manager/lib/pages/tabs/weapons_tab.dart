import 'package:dnd_character_manager/cubits/weapon_cubit/weapon_cubit.dart';
import 'package:dnd_character_manager/models/weapon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../client/spacing.dart';
import '../../constants/theme_data.dart';
import '../add_weapon_screen.dart';
import '../edit_weapon_screen.dart';

class WeaponsTab extends StatelessWidget {
  final String charID;
  const WeaponsTab({super.key, required this.charID});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          _WeaponsList(charID: charID),
          seperation,
          _AddWeapon(charID: charID),
        ],
      ),
    );
  }
}

class _WeaponsList extends StatelessWidget {
  final String? charID;
  const _WeaponsList({required this.charID});

  @override
  Widget build(BuildContext context) {
    context.read<WeaponCubit>().readWeaponsByCharID(charID);
    return BlocBuilder<WeaponCubit, WeaponState>(
      builder: (context, state) {
        List<Padding> weapons = state.weapons!.map(
          (weapon) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: themeColor), borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  onTap: () => _onPressedTile(context: context, description: weapon.description ?? '', name: weapon.name ?? ''),
                  leading: IconButton(
                    onPressed: () {
                      _showPostEditPanel(context, weapon);
                    },
                    icon: const ImageIcon(AssetImage('assets/sword.png')),
                  ),
                  title: Text(
                    weapon.name ?? '',
                    style: dndFont.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Attack: ${weapon.attackRoll ?? ''}\nDamage: ${weapon.damageRoll ?? ''}',
                    style: dndFont.copyWith(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_forever_outlined,
                      color: black,
                    ),
                    onPressed: () => _onPressedDeleteIcon(
                      context: context,
                      weaponID: weapon.weaponID!,
                      name: weapon.name!,
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
            'Weapons',
            style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          seperation,
          ...weapons
        ]);
      },
    );
  }
}

void _onPressedDeleteIcon({required BuildContext context, required String weaponID, required String name, required String charID}) {
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
            context.read<WeaponCubit>().deleteWeaponByWeaponID(weaponID).then((result) {
              context.read<WeaponCubit>().readWeaponsByCharID(charID);
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
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, color: white, fontWeight: FontWeight.bold),
              ),
              seperation,
              Text(
                description,
                textAlign: TextAlign.start,
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

class _AddWeapon extends StatelessWidget {
  final String charID;
  const _AddWeapon({required this.charID});

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
  Weapon weapon = Weapon(charID: charID, weaponID: uuid.v4());
  context.read<WeaponCubit>().setWeaponsData(weapon);
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(child: SingleChildScrollView(child: AlertDialog(title: AddWeaponScreen(weapon: weapon))));
      });
}

void _showPostEditPanel(BuildContext context, Weapon weapon) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: EditWeaponScreen(weapon: weapon),
        ),
      ),
    ),
  );
}
