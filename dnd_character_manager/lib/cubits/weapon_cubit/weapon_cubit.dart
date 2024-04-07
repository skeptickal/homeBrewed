import 'package:bloc/bloc.dart';
import 'package:dnd_character_manager/service/dnd_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/weapon.dart';

part 'weapon_state.dart';

class WeaponCubit extends Cubit<WeaponState> {
  final DndService dndService;

  WeaponCubit({DndService? dndService})
      : dndService = dndService ?? DndService(),
        super(
          WeaponInitial(),
        );

  Future<void> readWeaponData(String weaponID) async {
    final Weapon newlySelectedweapon = await dndService.readWeaponData(weaponID: weaponID);
    print('Jeff before emit: $newlySelectedweapon');
    emit(state.copyWith(currentSelectedWeapon: newlySelectedweapon));
    print('Jeff after emit ${state.currentSelectedWeapon}');
  }

  Future<void> setWeaponsData(Weapon weapon) async {
    await dndService.setWeaponsData(weapon: weapon);
    emit(state.copyWith(weapons: [...?state.weapons, weapon]));
  }

  Future<void> readWeaponsByCharID(String? charID) async {
    try {
      final List<Weapon> weapons = await dndService.readWeaponsByCharID(charID: charID);
      emit(state.copyWith(weapons: weapons));
    } catch (e) {
      print('error reading weapons from state');
    }
  }

  Future<void> deleteWeaponByWeaponID(String weaponID) async {
    await dndService.deleteWeaponByWeaponID(weaponID: weaponID);
  }
}
