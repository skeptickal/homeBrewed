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
              acrobaticsProf: '5',
              animalHandlingProf: '3',
              arcanaProf: '2',
              athleticsProf: '4',
              deceptionProf: '2',
              historyProf: '3',
              insightProf: '4',
              intimidationProf: '2',
              investigationProf: '3',
              medicineProf: '1',
              natureProf: '3',
              perceptionProf: '4',
              performanceProf: '2',
              persuasionProf: '1',
              religionProf: '3',
              sleightOfHandProf: '2',
              stealthProf: '4',
              survivalProf: false,
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
            acrobaticsProf: '5',
            animalHandlingProf: '3',
            arcanaProf: '2',
            athleticsProf: '4',
            deceptionProf: '2',
            historyProf: '3',
            insightProf: '4',
            intimidationProf: '2',
            investigationProf: '3',
            medicineProf: '1',
            natureProf: '3',
            perceptionProf: '4',
            performanceProf: '2',
            persuasionProf: '1',
            religionProf: '3',
            sleightOfHandProf: '2',
            stealthProf: '4',
            survivalProf: false,
          ),
          statEdit: false,
        );
}
