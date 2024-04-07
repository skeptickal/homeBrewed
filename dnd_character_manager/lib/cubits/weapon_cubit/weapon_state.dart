part of 'weapon_cubit.dart';

@immutable
class WeaponState extends Equatable {
  final List<Weapon>? weapons;
  final Weapon? currentSelectedWeapon;

  const WeaponState({required this.weapons, this.currentSelectedWeapon});

  WeaponState copyWith({weapons, currentSelectedWeapon}) {
    return WeaponState(weapons: weapons ?? this.weapons, currentSelectedWeapon: currentSelectedWeapon);
  }

  @override
  List<Object?> get props => [weapons, currentSelectedWeapon];
}

final class WeaponInitial extends WeaponState {
  WeaponInitial()
      : super(
          weapons: [],
          currentSelectedWeapon: const Weapon(
            charID: '1234',
            weaponID: '5678',
            damageRoll: '1',
            description: '2',
            attackRoll: '3',
            name: 'axe',
          ),
        );
}
