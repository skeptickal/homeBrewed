import 'package:equatable/equatable.dart';

class Resource extends Equatable {
  final String? charID;
  final String? resourceID;
  final String? name;
  final String? description;
  final String? currentResourceValue;
  final String? maxResourceValue;

  const Resource({
    this.resourceID,
    this.charID,
    required this.name,
    this.description,
    required this.currentResourceValue,
    required this.maxResourceValue,
  });

  Resource copyWith({String? charID, String? name, String? description, String? currentResourceValue, String? maxResourceValue, String? resourceID}) {
    return Resource(
      resourceID: resourceID ?? this.resourceID,
      charID: charID ?? this.charID,
      name: name ?? this.name,
      description: description ?? this.description,
      currentResourceValue: currentResourceValue ?? this.currentResourceValue,
      maxResourceValue: maxResourceValue ?? this.maxResourceValue,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'resourceID': resourceID,
      'charID': charID,
      'name': name,
      'description': description,
      'currentResourceValue': currentResourceValue,
      'maxResourceValue': maxResourceValue,
    };
    return data;
  }

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      resourceID: json['ResourceID'].toString(),
      charID: json['charID'].toString(),
      name: json['name'].toString(),
      description: json['description'].toString(),
      currentResourceValue: json['currentResourceValue'].toString(),
      maxResourceValue: json['maxResourceValue'].toString(),
    );
  }

  @override
  List<Object?> get props => [charID, name, description, currentResourceValue, maxResourceValue, resourceID];
}
