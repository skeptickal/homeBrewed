import 'package:equatable/equatable.dart';

class DndAction extends Equatable {
  final String? charID;
  final String? dndActionID;
  final String? name;
  final String? description;

  const DndAction({
    this.dndActionID,
    this.charID,
    this.name,
    this.description,
  });

  DndAction copyWith({String? charID, String? name, String? description, String? dndActionID}) {
    return DndAction(
      dndActionID: dndActionID ?? this.dndActionID,
      charID: charID ?? this.charID,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'dndActionID': dndActionID,
      'charID': charID,
      'name': name,
      'description': description,
    };
    return data;
  }

  factory DndAction.fromJson(Map<String, dynamic> json) {
    return DndAction(
      dndActionID: json['dndActionID'].toString(),
      charID: json['charID'].toString(),
      name: json['name'].toString(),
      description: json['description'].toString(),
    );
  }

  @override
  List<Object?> get props => [charID, name, description, dndActionID];
}
