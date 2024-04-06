import 'package:dnd_character_manager/cubits/weapon_cubit/weapon_cubit.dart';
import 'package:dnd_character_manager/models/weapon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

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
      child: Column(
        children: [
          _WeaponsList(charID: charID),
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
    return BlocBuilder<WeaponCubit, WeaponState>(
      builder: (context, state) {
        context.read<WeaponCubit>().readWeaponsByCharID(charID);
        print('Jackson: ${state.weapons}');
        List<Padding> weapons = state.weapons!.map(
          (weapon) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: blueGrey), borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  onTap: () => _onPressedTile(context: context, description: weapon.description ?? '', name: weapon.name ?? ''),
                  leading: IconButton(
                    onPressed: () => _showPostEditPanel(context, weapon),
                    icon: const FaIcon(FontAwesomeIcons.penToSquare),
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
      backgroundColor: blueGrey,
      surfaceTintColor: blueGrey,
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
    builder: (context) => SingleChildScrollView(
      child: AlertDialog(
        title: Text(
          description,
          style: TextStyle(color: white, fontSize: 18),
        ),
        backgroundColor: blueGrey,
        surfaceTintColor: blueGrey,
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
  );
}

class _AddWeapon extends StatelessWidget {
  final String charID;
  const _AddWeapon({required this.charID});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () => _showEditPanel(context, charID),
          icon: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
        seperation,
      ],
    );
  }
}

void _showEditPanel(BuildContext context, String charID) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: AddWeaponScreen(charID: charID),
        );
      });
}

void _showPostEditPanel(BuildContext context, Weapon weapon) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: EditWeaponScreen(weapon: weapon),
        );
      });
}
