import 'package:equatable/equatable.dart';

class Bio extends Equatable {
  final String? userID;
  final String? race;
  final String? name;
  final String? dndClass;
  final String? charID;
  final String? subclass1;
  final String? subclass2;
  final String? alignment;
  final String? personality;
  final String? bonds;
  final String? flaws;
  final String? background;

  const Bio({
    this.userID,
    this.race,
    this.name,
    this.dndClass,
    this.charID,
    this.subclass1,
    this.subclass2,
    this.alignment,
    this.personality,
    this.bonds,
    this.flaws,
    this.background,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'userID': userID,
      'name': name,
      'race': race,
      'dndClass': dndClass,
      'charID': charID,
      'subclass1': subclass1,
      'subclass2': subclass2,
      'alignment': alignment,
      'personality': personality,
      'bonds': bonds,
      'flaws': flaws,
      'background': background,
    };
    return data;
  }

  factory Bio.fromJson(Map<String, dynamic> json) {
    return Bio(
      name: json['name'].toString(),
      dndClass: json['dndClass'].toString(),
      race: json['race'].toString(),
      userID: json['userID'].toString(),
      charID: json['charID'].toString(),
      subclass1: json['subclass1'].toString(),
      subclass2: json['subclass2'].toString(),
      alignment: json['alignment'].toString(),
      personality: json['personality'].toString(),
      bonds: json['bonds'].toString(),
      flaws: json['flaws'].toString(),
      background: json['background'].toString(),
    );
  }

  @override
  String toString() {
    return 'subclass1: $subclass1 \n charID: $charID, '
        '\n subclass2: $subclass2, \n alignment: $alignment, \n personality: $personality,'
        '\n bonds: $bonds, \n flaws: $flaws, \n background: $background';
  }

  @override
  List<Object?> get props => [
        userID,
        charID,
        subclass1,
        subclass2,
        alignment,
        personality,
        bonds,
        flaws,
        background,
      ];
}
