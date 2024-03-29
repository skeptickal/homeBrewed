import 'package:equatable/equatable.dart';

class DndCharacter extends Equatable {
  //DNA
  final String userID;
  final String charID;

  //BIO TAB
  final String race;
  final String name;
  final String dndClass;
  //String CharacterID
  //String? subRace;
  //String? subClass1;
  //String? subClass2;
  //String? bio
  //String? alignment (use dropdown menu of alignments)
  //String? bonds
  //String? flaws
  //String? personalityTraits

  //STATS TAB
  //PlayerLevel? playerLevel | PlayerLevel({int classLevel, int? subclass1Lvl, int? subclass2Lvl, int totalPlayerLevel})
  //Hp? hp | Hp({int currentHp, int maxHp, int tempHp})
  //int? initiative - calc with DEX? or keep separate for special things
  //int? armorClass
  //int? speed
  //bool? inspiration
  //int? proficiencyBonus
  //List<Proficiency>? | Proficiency({String type, String prof}) e.g. Proficiency(type: 'ARMOR', prof: 'Heavy Armor')
  //String? toolProficiencies
  //int? strength    -- do I calculate all 24 skills and saving throws using these values + prof? or allow for manual edit
  //int? dexterity
  //int? constitution
  //int? intelligence
  //int? wisdom
  //int? charisma
  //HitDice? hitDice | HitDice({int currentHitDice, int maxHitDice, String hitDiceType})
  //DeathSaves? deathSaves | DeathSave({int successes, int failures})
  //int? passivePerception

  //RESOURCES TAB
  //List<Resource> resources | Resource({String resourceName, int currentResourceValue, int maxResourceValue})
  //                               e.g. Resource(resourceName: 'Divine Sense', currentResourceValue: 2, maxResourceValue 3)

  //WEAPONS TAB
  //List<Weapon>? weapons | Weapon({String weaponName, String attackRoll, String description})

  //ITEMS TAB
  //List<Item>? items | Item({String itemName, String itemDesc})

  //SPELLS TAB
  //List<Spell>? spells | Spell({String spellName, int spellLevel, String spellDesc})
  //SpellSplots? spellSlots | SpellSlots({int maxSpellSlots, int currentSpellSlots})
  //String? spellCastingAbility,
  //int? spellSaveDC.
  //int? spellAttackBonus,

  //ABILITIES TAB
  //List<Abilities>? abilities | Abilities({String abilityName, String abilityDesc})

  //INCOME TAB
  //CurrentIncome? currentIncome | CurrentIncome({int copperPieces, int silverPieces, int goldPieces, int ethereumPieces, int platinumPieces})

  //NOTES TAB
  //String? notes

  const DndCharacter({
    required this.charID,
    required this.userID,
    required this.race,
    required this.name,
    required this.dndClass,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'charID': charID,
      'userID': userID,
      'race': race,
      'name': name,
      'dndClass': dndClass,
    };
    return data;
  }

  factory DndCharacter.fromJson(Map<String, dynamic> json) {
    return DndCharacter(
      charID: json['charID'].toString(),
      userID: json['userID'].toString(),
      race: json['race'].toString(),
      name: json['name'].toString(),
      dndClass: json['dndClass'].toString(),
    );
  }

  @override
  String toString() {
    return 'name: $name \n userID: $userID, \n race: $race \n dndClass: $dndClass \n charID: $charID';
  }

  @override
  List<Object?> get props => [
        userID,
        name,
        dndClass,
        race,
        charID,
      ];
}
