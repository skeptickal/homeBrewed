import 'package:dnd_character_manager/cubits/weapon_cubit/weapon_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../client/spacing.dart';
import '../../constants/theme_data.dart';
import '../add_weapon_screen.dart';

class WeaponsTab extends StatelessWidget {
  final String charID;
  const WeaponsTab({super.key, required this.charID});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const _EditBlock(),
          _WeaponsList(charID: charID),
          _AddWeapon(charID: charID),
          const _EditBlock(),
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
        List<Padding> weapons = state.weapons.map(
          (weapon) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: blueGrey), // Border properties
                ),
                child: ListTile(
                  onTap: () {}, // context.push('/character_viewer', extra: bio),
                  leading: Icon(
                    Icons.person,
                    color: blueGrey,
                  ),
                  title: Text(
                    weapon.name ?? '',
                    style: dndFont.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${weapon.attackRoll ?? ''} | ${weapon.damageRoll ?? ''}',
                    style: dndFont.copyWith(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                  trailing: IconButton(
                      icon: Icon(
                        Icons.delete_forever_outlined,
                        color: black,
                      ),
                      onPressed: () {} //_onPressedDeleteIcon(context, userState.myUser!.userID!, bio.charID!, bio.name!),
                      ),
                ),
              ),
            );
          },
        ).toList();
        return Column(children: [...weapons]);
      },
    );
  }
}

class _EditBlock extends StatelessWidget {
  const _EditBlock();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeaponCubit, WeaponState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<WeaponCubit>().weaponEdit(!state.weaponEdit!);
                  },
                  icon: const Icon(
                    Icons.edit,
                  ),
                ),
                Text(
                  !state.weaponEdit! ? 'Enable Edit' : 'Disable Edit',
                  style: dndFont.copyWith(color: state.weaponEdit! ? black : disableGrey),
                ),
              ],
            ),
            seperation,
          ],
        );
      },
    );
  }
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
