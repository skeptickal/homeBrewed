import 'package:equatable/equatable.dart';

class Income extends Equatable {
  final String? charID;
  final String? copper;
  final String? silver;
  final String? electrum;
  final String? gold;
  final String? platinum;

  const Income({
    this.charID,
    this.copper,
    this.silver,
    this.electrum,
    this.gold,
    this.platinum,
  });

  Income copyWith({String? charID, String? copper, String? silver, String? electrum, String? gold, String? platinum}) {
    return Income(
      charID: charID ?? this.charID,
      copper: copper ?? this.copper,
      silver: silver ?? this.silver,
      electrum: electrum ?? this.electrum,
      gold: gold ?? this.gold,
      platinum: platinum ?? this.platinum,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'charID': charID,
      'copper': copper,
      'silver': silver,
      'electrum': electrum,
      'gold': gold,
      'platinum': platinum,
    };
    return data;
  }

  factory Income.fromJson(Map<String, dynamic> json) {
    return Income(
      charID: json['charID'].toString(),
      copper: json['copper'].toString(),
      silver: json['silver'].toString(),
      electrum: json['electrum'].toString(),
      gold: json['gold'].toString(),
      platinum: json['platinum'].toString(),
    );
  }

  @override
  List<Object?> get props => [charID, copper, silver, electrum, gold, platinum];
}
