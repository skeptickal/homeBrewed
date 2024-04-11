import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String? charID;
  final String? itemID;
  final String? name;
  final String? description;
  final String? amount;

  const Item({
    this.itemID,
    this.charID,
    this.name,
    this.description,
    this.amount,
  });

  Item copyWith({String? charID, String? name, String? description, String? itemID, String? amount}) {
    return Item(
      itemID: itemID ?? this.itemID,
      charID: charID ?? this.charID,
      name: name ?? this.name,
      description: description ?? this.description,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'itemID': itemID,
      'charID': charID,
      'name': name,
      'description': description,
      'amount': amount,
    };
    return data;
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemID: json['itemID'].toString(),
      charID: json['charID'].toString(),
      name: json['name'].toString(),
      description: json['description'].toString(),
      amount: json['amount'].toString(),
    );
  }

  @override
  List<Object?> get props => [charID, name, description, itemID, amount];
}
