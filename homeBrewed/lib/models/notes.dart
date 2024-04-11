import 'package:equatable/equatable.dart';

class Notes extends Equatable {
  final String? charID;
  final String? notes;

  const Notes({
    this.charID,
    this.notes,
  });

  Notes copyWith({
    String? charID,
    String? notes,
  }) {
    return Notes(
      charID: charID ?? this.charID,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'charID': charID,
      'notes': notes,
    };
    return data;
  }

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
      charID: json['charID'].toString(),
      notes: json['notes']?.toString() ?? '',
    );
  }

  @override
  List<Object?> get props => [
        charID,
        notes,
      ];
}
