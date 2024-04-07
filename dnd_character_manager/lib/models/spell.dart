import 'package:equatable/equatable.dart';

class Spell extends Equatable {
  final String? charID;
  final String? spellID;
  final String? name;
  final String? description;
  final String? spellAtkOrDC;

  const Spell({
    this.spellID,
    this.charID,
    this.name,
    this.description,
    this.spellAtkOrDC,
  });

  Spell copyWith({String? charID, String? name, String? description, String? spellAtkOrDC, String? spellID}) {
    return Spell(
      spellID: spellID ?? this.spellID,
      charID: charID ?? this.charID,
      name: name ?? this.name,
      description: description ?? this.description,
      spellAtkOrDC: spellAtkOrDC ?? this.spellAtkOrDC,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'spellID': spellID,
      'charID': charID,
      'name': name,
      'description': description,
      'spellAtkOrDC': spellAtkOrDC,
    };
    return data;
  }

  factory Spell.fromJson(Map<String, dynamic> json) {
    return Spell(
      spellID: json['spellID'].toString(),
      charID: json['charID'].toString(),
      name: json['name'].toString(),
      description: json['description'].toString(),
      spellAtkOrDC: json['spellAtkOrDC'].toString(),
    );
  }

  @override
  List<Object?> get props => [charID, name, description, spellAtkOrDC, spellID];
}
