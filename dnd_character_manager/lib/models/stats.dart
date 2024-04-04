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
  final String? acrobaticsProf;
  final String? animalHandlingProf;
  final String? arcanaProf;
  final String? athleticsProf;
  final String? deceptionProf;
  final String? historyProf;
  final String? insightProf;
  final String? intimidationProf;
  final String? investigationProf;
  final String? medicineProf;
  final String? natureProf;
  final String? perceptionProf;
  final String? performanceProf;
  final String? persuasionProf;
  final String? religionProf;
  final String? sleightOfHandProf;
  final String? stealthProf;
  final bool? survivalProf;

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
    this.acrobaticsProf,
    this.animalHandlingProf,
    this.arcanaProf,
    this.athleticsProf,
    this.deceptionProf,
    this.historyProf,
    this.insightProf,
    this.intimidationProf,
    this.investigationProf,
    this.medicineProf,
    this.natureProf,
    this.perceptionProf,
    this.performanceProf,
    this.persuasionProf,
    this.religionProf,
    this.sleightOfHandProf,
    this.stealthProf,
    this.survivalProf,
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
      'acrobaticsProf': acrobaticsProf,
      'animalHandlingProf': animalHandlingProf,
      'arcanaProf': arcanaProf,
      'athleticsProf': athleticsProf,
      'deceptionProf': deceptionProf,
      'historyProf': historyProf,
      'insightProf': insightProf,
      'intimidationProf': intimidationProf,
      'investigationProf': investigationProf,
      'medicineProf': medicineProf,
      'natureProf': natureProf,
      'perceptionProf': perceptionProf,
      'performanceProf': performanceProf,
      'persuasionProf': persuasionProf,
      'religionProf': religionProf,
      'sleightOfHandProf': sleightOfHandProf,
      'stealthProf': stealthProf,
      'survivalProf': survivalProf,
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
      acrobaticsProf: json['acrobaticsProf'].toString(),
      animalHandlingProf: json['animalHandlingProf'].toString(),
      arcanaProf: json['arcanaProf'].toString(),
      athleticsProf: json['athleticsProf'].toString(),
      deceptionProf: json['deceptionProf'].toString(),
      historyProf: json['historyProf'].toString(),
      insightProf: json['insightProf'].toString(),
      intimidationProf: json['intimidationProf'].toString(),
      investigationProf: json['investigationProf'].toString(),
      medicineProf: json['medicineProf'].toString(),
      natureProf: json['natureProf'].toString(),
      perceptionProf: json['perceptionProf'].toString(),
      performanceProf: json['performanceProf'].toString(),
      persuasionProf: json['persuasionProf'].toString(),
      religionProf: json['religionProf'].toString(),
      sleightOfHandProf: json['sleightOfHandProf'].toString(),
      stealthProf: json['stealthProf'].toString(),
      survivalProf: json['survivalProf'] ?? false,
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
        acrobaticsProf,
        animalHandlingProf,
        arcanaProf,
        athleticsProf,
        deceptionProf,
        historyProf,
        insightProf,
        intimidationProf,
        investigationProf,
        medicineProf,
        natureProf,
        perceptionProf,
        performanceProf,
        persuasionProf,
        religionProf,
        sleightOfHandProf,
        stealthProf,
        survivalProf,
      ];
}
