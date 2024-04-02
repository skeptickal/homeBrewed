import 'package:equatable/equatable.dart';

class Stats extends Equatable {
  final String? charID;
  final String? totalPlayerLevel;
  final String? classLevel;
  final String? subClass1Lvl;
  final String? subClass2Lvl;
  final String? currentHp;
  final String? maxHp;
  final String? tempHp;
  final String? speed;
  final String? inspiration;
  final String? proficiencyBonus;
  final String? strength;
  final String? dexterity;
  final String? constitution;
  final String? intelligence;
  final String? wisdom;
  final String? charisma;
  final String? hitDice;
  final String? hitDiceType;
  final String? deathSaveSuccesses;
  final String? deathSaveFailures;
  final String? passivePerception;
  final String? acrobaticsRoll;
  final String? animalHandlingRoll;
  final String? arcanaRoll;
  final String? athleticsRoll;
  final String? deceptionRoll;
  final String? historyRoll;
  final String? insightRoll;
  final String? intimidationRoll;
  final String? investigationRoll;
  final String? medicineRoll;
  final String? natureRoll;
  final String? perceptionRoll;
  final String? performanceRoll;
  final String? persuasionRoll;
  final String? religionRoll;
  final String? sleightOfHandRoll;
  final String? stealthRoll;
  final String? survivalRoll;

  const Stats({
    this.totalPlayerLevel,
    this.classLevel,
    this.subClass1Lvl,
    this.subClass2Lvl,
    this.charID,
    this.currentHp,
    this.maxHp,
    this.tempHp,
    this.speed,
    this.inspiration,
    this.proficiencyBonus,
    this.strength,
    this.dexterity,
    this.constitution,
    this.intelligence,
    this.wisdom,
    this.charisma,
    this.hitDice,
    this.hitDiceType,
    this.deathSaveSuccesses,
    this.deathSaveFailures,
    this.passivePerception,
    this.acrobaticsRoll,
    this.animalHandlingRoll,
    this.arcanaRoll,
    this.athleticsRoll,
    this.deceptionRoll,
    this.historyRoll,
    this.insightRoll,
    this.intimidationRoll,
    this.investigationRoll,
    this.medicineRoll,
    this.natureRoll,
    this.perceptionRoll,
    this.performanceRoll,
    this.persuasionRoll,
    this.religionRoll,
    this.sleightOfHandRoll,
    this.stealthRoll,
    this.survivalRoll,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'totalPlayerLevel': totalPlayerLevel,
      'classLevel': classLevel,
      'subClass1Lvl': subClass1Lvl,
      'subClass2Lvl': subClass2Lvl,
      'charID': charID,
      'currentHp': currentHp,
      'maxHp': maxHp,
      'tempHp': tempHp,
      'speed': speed,
      'inspiration': inspiration,
      'proficiencyBonus': proficiencyBonus,
      'strength': strength,
      'dexterity': dexterity,
      'constitution': constitution,
      'intelligence': intelligence,
      'wisdom': wisdom,
      'charisma': charisma,
      'hitDice': hitDice,
      'hitDiceType': hitDiceType,
      'deathSaveSuccesses': deathSaveSuccesses,
      'deathSaveFailures': deathSaveFailures,
      'passivePerception': passivePerception,
      'acrobaticsRoll': acrobaticsRoll,
      'animalHandlingRoll': animalHandlingRoll,
      'arcanaRoll': arcanaRoll,
      'athleticsRoll': athleticsRoll,
      'deceptionRoll': deceptionRoll,
      'historyRoll': historyRoll,
      'insightRoll': insightRoll,
      'intimidationRoll': intimidationRoll,
      'investigationRoll': investigationRoll,
      'medicineRoll': medicineRoll,
      'natureRoll': natureRoll,
      'perceptionRoll': perceptionRoll,
      'performanceRoll': performanceRoll,
      'persuasionRoll': persuasionRoll,
      'religionRoll': religionRoll,
      'sleightOfHandRoll': sleightOfHandRoll,
      'stealthRoll': stealthRoll,
      'survivalRoll': survivalRoll,
    };
    return data;
  }

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      totalPlayerLevel: json['totalPlayerLevel'].toString(),
      classLevel: json['classLevel'].toString(),
      subClass1Lvl: json['subClass1Lvl'].toString(),
      subClass2Lvl: json['subClass2Lvl'].toString(),
      charID: json['charID'].toString(),
      currentHp: json['currentHp'].toString(),
      maxHp: json['maxHp'].toString(),
      tempHp: json['tempHp'].toString(),
      speed: json['speed'].toString(),
      inspiration: json['inspiration'].toString(),
      proficiencyBonus: json['proficiencyBonus'].toString(),
      strength: json['strength'].toString(),
      dexterity: json['dexterity'].toString(),
      constitution: json['constitution'].toString(),
      intelligence: json['intelligence'].toString(),
      wisdom: json['wisdom'].toString(),
      charisma: json['charisma'].toString(),
      hitDice: json['hitDice'].toString(),
      hitDiceType: json['hitDiceType'].toString(),
      deathSaveSuccesses: json['deathSaveSuccesses'].toString(),
      deathSaveFailures: json['deathSaveFailures'].toString(),
      passivePerception: json['passivePerception'].toString(),
      acrobaticsRoll: json['acrobaticsRoll'].toString(),
      animalHandlingRoll: json['animalHandlingRoll'].toString(),
      arcanaRoll: json['arcanaRoll'].toString(),
      athleticsRoll: json['athleticsRoll'].toString(),
      deceptionRoll: json['deceptionRoll'].toString(),
      historyRoll: json['historyRoll'].toString(),
      insightRoll: json['insightRoll'].toString(),
      intimidationRoll: json['intimidationRoll'].toString(),
      investigationRoll: json['investigationRoll'].toString(),
      medicineRoll: json['medicineRoll'].toString(),
      natureRoll: json['natureRoll'].toString(),
      perceptionRoll: json['perceptionRoll'].toString(),
      performanceRoll: json['performanceRoll'].toString(),
      persuasionRoll: json['persuasionRoll'].toString(),
      religionRoll: json['religionRoll'].toString(),
      sleightOfHandRoll: json['sleightOfHandRoll'].toString(),
      stealthRoll: json['stealthRoll'].toString(),
      survivalRoll: json['survivalRoll'].toString(),
    );
  }

  @override
  List<Object?> get props => [
        totalPlayerLevel,
        classLevel,
        subClass1Lvl,
        subClass2Lvl,
        charID,
        currentHp,
        maxHp,
        tempHp,
        speed,
        inspiration,
        proficiencyBonus,
        strength,
        dexterity,
        constitution,
        intelligence,
        wisdom,
        charisma,
        hitDice,
        hitDiceType,
        deathSaveSuccesses,
        deathSaveFailures,
        passivePerception,
        acrobaticsRoll,
        animalHandlingRoll,
        arcanaRoll,
        athleticsRoll,
        deceptionRoll,
        historyRoll,
        insightRoll,
        intimidationRoll,
        investigationRoll,
        medicineRoll,
        natureRoll,
        perceptionRoll,
        performanceRoll,
        persuasionRoll,
        religionRoll,
        sleightOfHandRoll,
        stealthRoll,
        survivalRoll,
      ];
}
