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
  final bool? acrobaticsProf;
  final bool? animalHandlingProf;
  final bool? arcanaProf;
  final bool? athleticsProf;
  final bool? deceptionProf;
  final bool? historyProf;
  final bool? insightProf;
  final bool? intimidationProf;
  final bool? investigationProf;
  final bool? medicineProf;
  final bool? natureProf;
  final bool? perceptionProf;
  final bool? performanceProf;
  final bool? persuasionProf;
  final bool? religionProf;
  final bool? sleightOfHandProf;
  final bool? stealthProf;
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
      totalPlayerLevel: json['totalPlayerLevel']?.toString() ?? '0',
      classLevel: json['classLevel']?.toString() ?? '0',
      subClass1Lvl: json['subClass1Lvl']?.toString() ?? '0',
      subClass2Lvl: json['subClass2Lvl']?.toString() ?? '0',
      charID: json['charID'].toString(),
      currentHp: json['currentHp']?.toString() ?? '0',
      maxHp: json['maxHp']?.toString() ?? '0',
      tempHp: json['tempHp']?.toString() ?? '0',
      speed: json['speed']?.toString() ?? '0',
      inspiration: json['inspiration']?.toString() ?? '0',
      proficiencyBonus: json['proficiencyBonus']?.toString() ?? '0',
      strength: json['strength']?.toString() ?? '10',
      dexterity: json['dexterity']?.toString() ?? '10',
      constitution: json['constitution']?.toString() ?? '10',
      intelligence: json['intelligence']?.toString() ?? '10',
      wisdom: json['wisdom']?.toString() ?? '10',
      charisma: json['charisma']?.toString() ?? '10',
      hitDice: json['hitDice']?.toString() ?? '0',
      hitDiceType: json['hitDiceType']?.toString() ?? 'd8',
      deathSaveSuccesses: json['deathSaveSuccesses']?.toString() ?? '0',
      deathSaveFailures: json['deathSaveFailures']?.toString() ?? '0',
      passivePerception: json['passivePerception']?.toString() ?? '0',
      acrobaticsProf: json['acrobaticsProf'] ?? false,
      animalHandlingProf: json['animalHandlingProf'] ?? false,
      arcanaProf: json['arcanaProf'] ?? false,
      athleticsProf: json['athleticsProf'] ?? false,
      deceptionProf: json['deceptionProf'] ?? false,
      historyProf: json['historyProf'] ?? false,
      insightProf: json['insightProf'] ?? false,
      intimidationProf: json['intimidationProf'] ?? false,
      investigationProf: json['investigationProf'] ?? false,
      medicineProf: json['medicineProf'] ?? false,
      natureProf: json['natureProf'] ?? false,
      perceptionProf: json['perceptionProf'] ?? false,
      performanceProf: json['performanceProf'] ?? false,
      persuasionProf: json['persuasionProf'] ?? false,
      religionProf: json['religionProf'] ?? false,
      sleightOfHandProf: json['sleightOfHandProf'] ?? false,
      stealthProf: json['stealthProf'] ?? false,
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
