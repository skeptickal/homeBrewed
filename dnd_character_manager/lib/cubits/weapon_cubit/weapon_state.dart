part of 'weapon_cubit.dart';

@immutable
class WeaponState extends Equatable {
  final Weapon? weapon;
  final bool? weaponEdit;
  final List<Weapon>? weapons;

  const WeaponState({required this.weapon, this.weaponEdit, required this.weapons});

  WeaponState copyWith({weapon, weaponEdit, weapons}) {
    return WeaponState(weapon: weapon ?? this.weapon, weaponEdit: weaponEdit ?? this.weaponEdit, weapons: weapons ?? this.weapons);
  }

  @override
  List<Object?> get props => [weapon, weaponEdit, weapons];
}

final class WeaponInitial extends WeaponState {
  WeaponInitial()
      : super(
          weapons: [],
          weapon: null,
          weaponEdit: false,
        );
}
