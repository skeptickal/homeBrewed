import 'package:equatable/equatable.dart';

class DndCharacter extends Equatable {
  final String userID;
  final String race;
  final String name;
  final String dndClass;

  const DndCharacter({
    required this.userID,
    required this.race,
    required this.name,
    required this.dndClass,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'userID': userID,
      'race': race,
      'name': name,
      'dndClass': dndClass,
    };
    return data;
  }

  factory DndCharacter.fromJson(Map<String, dynamic> json) {
    return DndCharacter(
      userID: json['userID'].toString(),
      race: json['race'].toString(),
      name: json['name'].toString(),
      dndClass: json['dndClass'].toString(),
    );
  }

  @override
  String toString() {
    return 'name: $name \n userID: $userID, \n race: $race \n dndClass: $dndClass';
  }

  @override
  List<Object?> get props => [userID, name, dndClass, race];
}
