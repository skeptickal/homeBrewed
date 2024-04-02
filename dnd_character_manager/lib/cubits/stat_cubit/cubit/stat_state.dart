part of 'stat_cubit.dart';

@immutable
class StatState extends Equatable {
  final Stats? stats;
  final bool? statEdit;
  final List<Stats> statsList;

  const StatState({this.stats, this.statEdit, required this.statsList});

  StatState copyWith({stats, statEdit, statsList}) {
    return StatState(
      stats: stats ?? this.stats,
      statEdit: statEdit ?? this.statEdit,
      statsList: statsList ?? this.statsList,
    );
  }

  @override
  List<Object?> get props => [stats, statEdit, statsList];
}

final class StatInitial extends StatState {
  StatInitial()
      : super(
          statsList: [
            const Stats(
              totalPlayerLevel: '10',
              classLevel: '5',
              subClass1Lvl: '3',
              subClass2Lvl: '2',
              charID: '123456789',
              currentHp: '50',
              maxHp: '100',
              tempHp: '10',
              speed: '30',
              inspiration: 'true',
              proficiencyBonus: '3',
              strength: '16',
              dexterity: '14',
              constitution: '15',
              intelligence: '12',
              wisdom: '10',
              charisma: '8',
              hitDice: '5',
              hitDiceType: 'd8',
              deathSaveSuccesses: '2',
              deathSaveFailures: '1',
              passivePerception: '12',
              acrobaticsRoll: '5',
              animalHandlingRoll: '3',
              arcanaRoll: '2',
              athleticsRoll: '4',
              deceptionRoll: '2',
              historyRoll: '3',
              insightRoll: '4',
              intimidationRoll: '2',
              investigationRoll: '3',
              medicineRoll: '1',
              natureRoll: '3',
              perceptionRoll: '4',
              performanceRoll: '2',
              persuasionRoll: '1',
              religionRoll: '3',
              sleightOfHandRoll: '2',
              stealthRoll: '4',
              survivalRoll: '3',
            ),
          ],
          stats: const Stats(
            totalPlayerLevel: '10',
            classLevel: '5',
            subClass1Lvl: '3',
            subClass2Lvl: '2',
            charID: '123456789',
            currentHp: '50',
            maxHp: '100',
            tempHp: '10',
            speed: '30',
            inspiration: 'true',
            proficiencyBonus: '3',
            strength: '16',
            dexterity: '14',
            constitution: '15',
            intelligence: '12',
            wisdom: '10',
            charisma: '8',
            hitDice: '5',
            hitDiceType: 'd8',
            deathSaveSuccesses: '2',
            deathSaveFailures: '1',
            passivePerception: '12',
            acrobaticsRoll: '5',
            animalHandlingRoll: '3',
            arcanaRoll: '2',
            athleticsRoll: '4',
            deceptionRoll: '2',
            historyRoll: '3',
            insightRoll: '4',
            intimidationRoll: '2',
            investigationRoll: '3',
            medicineRoll: '1',
            natureRoll: '3',
            perceptionRoll: '4',
            performanceRoll: '2',
            persuasionRoll: '1',
            religionRoll: '3',
            sleightOfHandRoll: '2',
            stealthRoll: '4',
            survivalRoll: '3',
          ),
          statEdit: false,
        );
}
