import 'package:equatable/equatable.dart';

class Weapon extends Equatable {
  final String? charID;
  final String? weaponID;
  final String? name;
  final String? description;
  final String? damageRoll;
  final String? attackRoll;

  const Weapon({
    this.weaponID,
    this.charID,
    required this.name,
    this.description,
    required this.damageRoll,
    required this.attackRoll,
  });

  Weapon copyWith({String? charID, String? name, String? description, String? damageRoll, String? attackRoll, String? weaponID}) {
    return Weapon(
      weaponID: weaponID ?? this.weaponID,
      charID: charID ?? this.charID,
      name: name ?? this.name,
      description: description ?? this.description,
      damageRoll: damageRoll ?? this.damageRoll,
      attackRoll: attackRoll ?? this.attackRoll,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'weaponID': weaponID,
      'charID': charID,
      'name': name,
      'description': description,
      'damageRoll': damageRoll,
      'attackRoll': attackRoll,
    };
    return data;
  }

  factory Weapon.fromJson(Map<String, dynamic> json) {
    return Weapon(
      weaponID: json['weaponID'].toString(),
      charID: json['charID'].toString(),
      name: json['name'].toString(),
      description: json['description'].toString(),
      damageRoll: json['damageRoll'].toString(),
      attackRoll: json['attackRoll'].toString(),
    );
  }

  @override
  List<Object?> get props => [charID, name, description, damageRoll, attackRoll];
}
