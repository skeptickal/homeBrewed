import 'package:dnd_character_manager/cubits/stat_cubit/cubit/stat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../client/spacing.dart';
import '../../constants/text_fields.dart';
import '../../constants/theme_data.dart';

class StatTab extends StatelessWidget {
  final String charID;
  const StatTab({super.key, required this.charID});

  @override
  Widget build(BuildContext context) {
    context.read<StatCubit>().readStatsData(charID);
    return BlocBuilder<StatCubit, StatState>(
      builder: (context, state) {
        return const SingleChildScrollView(
          child: Column(
            children: [
              _EditBlock(),
              _Levels(),
              _Hps(),
              _CoreStats(),
              _SkillChecks(),
              _StatNotes(),
            ],
          ),
        );
      },
    );
  }
}

class _StatNotes extends StatelessWidget {
  const _StatNotes();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatCubit, StatState>(
      builder: (context, state) {
        TextEditingController statNotes = TextEditingController();
        return BigTextBox(
          onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(statNotes: statNotes.text)),
          onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(statNotes: statNotes.text)),
          minLines: 10,
          enabled: state.statEdit!,
          padding: const EdgeInsets.all(6),
          controller: statNotes,
          hintText: 'e.g. Add +3 to Strength for Giant\'s Belt',
          subtitle: 'Notes for Stats',
        );
      },
    );
  }
}

class _SkillChecks extends StatelessWidget {
  const _SkillChecks();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatCubit, StatState>(
      builder: (context, state) {
        CheckboxListTile acrobaticsProfCheck = CheckboxListTile(
          title: Text(
            'Acrobatics (DEX): ${((int.tryParse(state.stats!.dexterity ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.acrobaticsProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
          ),
          checkColor: blueGrey,
          tristate: true,
          value: state.stats!.acrobaticsProf,
          onChanged: state.statEdit!
              ? (newBool) {
                  context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(
                          acrobaticsProf: !state.stats!.acrobaticsProf!,
                        ),
                      );
                }
              : null,
        );
        CheckboxListTile animalHandlingProfCheck = CheckboxListTile(
          title: Text(
            'AnimalHandling (WIS): ${((int.tryParse(state.stats!.wisdom ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.animalHandlingProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
          ),
          checkColor: blueGrey,
          tristate: true,
          value: state.stats!.animalHandlingProf,
          onChanged: state.statEdit!
              ? (newBool) {
                  context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(
                          animalHandlingProf: !state.stats!.animalHandlingProf!,
                        ),
                      );
                }
              : null,
        );
        CheckboxListTile arcanaProfCheck = CheckboxListTile(
          title: Text(
            'Arcana (INT): ${((int.tryParse(state.stats!.intelligence ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.arcanaProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
          ),
          checkColor: blueGrey,
          tristate: true,
          value: state.stats!.arcanaProf,
          onChanged: state.statEdit!
              ? (newBool) {
                  context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(
                          arcanaProf: !state.stats!.arcanaProf!,
                        ),
                      );
                }
              : null,
        );
        CheckboxListTile athleticsProfCheck = CheckboxListTile(
          title: Text(
            'Athletics (STR): ${((int.tryParse(state.stats!.strength ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.athleticsProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
          ),
          checkColor: blueGrey,
          tristate: true,
          value: state.stats!.athleticsProf,
          onChanged: state.statEdit!
              ? (newBool) {
                  context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(
                          athleticsProf: !state.stats!.athleticsProf!,
                        ),
                      );
                }
              : null,
        );
        CheckboxListTile deceptionProfCheck = CheckboxListTile(
          title: Text(
            'Deception (CHA): ${((int.tryParse(state.stats!.charisma ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.deceptionProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
          ),
          checkColor: blueGrey,
          tristate: true,
          value: state.stats!.deceptionProf,
          onChanged: state.statEdit!
              ? (newBool) {
                  context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(
                          deceptionProf: !state.stats!.deceptionProf!,
                        ),
                      );
                }
              : null,
        );
        CheckboxListTile historyProfCheck = CheckboxListTile(
          title: Text(
            'History (INT): ${((int.tryParse(state.stats!.intelligence ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.historyProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
          ),
          checkColor: blueGrey,
          tristate: true,
          value: state.stats!.historyProf,
          onChanged: state.statEdit!
              ? (newBool) {
                  context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(
                          historyProf: !state.stats!.historyProf!,
                        ),
                      );
                }
              : null,
        );
        CheckboxListTile insightProfCheck = CheckboxListTile(
          title: Text(
            'Insight (WIS): ${((int.tryParse(state.stats!.wisdom ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.insightProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
          ),
          checkColor: blueGrey,
          tristate: true,
          value: state.stats!.insightProf,
          onChanged: state.statEdit!
              ? (newBool) {
                  context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(
                          insightProf: !state.stats!.insightProf!,
                        ),
                      );
                }
              : null,
        );
        CheckboxListTile intimidationProfCheck = CheckboxListTile(
          title: Text(
            'Intimidation (CHA): ${((int.tryParse(state.stats!.charisma ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.intimidationProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
          ),
          checkColor: blueGrey,
          tristate: true,
          value: state.stats!.intimidationProf,
          onChanged: state.statEdit!
              ? (newBool) {
                  context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(
                          intimidationProf: !state.stats!.intimidationProf!,
                        ),
                      );
                }
              : null,
        );
        CheckboxListTile investigationProfCheck = CheckboxListTile(
          title: Text(
            'Investigation (INT): ${((int.tryParse(state.stats!.intelligence ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.investigationProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
          ),
          checkColor: blueGrey,
          tristate: true,
          value: state.stats!.investigationProf,
          onChanged: state.statEdit!
              ? (newBool) {
                  context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(
                          investigationProf: !state.stats!.investigationProf!,
                        ),
                      );
                }
              : null,
        );
        CheckboxListTile medicineProfCheck = CheckboxListTile(
          title: Text(
            'Medicine (WIS): ${((int.tryParse(state.stats!.wisdom ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.medicineProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
          ),
          checkColor: blueGrey,
          tristate: true,
          value: state.stats!.medicineProf,
          onChanged: state.statEdit!
              ? (newBool) {
                  context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(
                          medicineProf: !state.stats!.medicineProf!,
                        ),
                      );
                }
              : null,
        );
        CheckboxListTile natureProfCheck = CheckboxListTile(
          title: Text(
            'Nature (INT): ${((int.tryParse(state.stats!.intelligence ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.natureProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
          ),
          checkColor: blueGrey,
          tristate: true,
          value: state.stats!.natureProf,
          onChanged: state.statEdit!
              ? (newBool) {
                  context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(
                          natureProf: !state.stats!.natureProf!,
                        ),
                      );
                }
              : null,
        );
        CheckboxListTile perceptionProfCheck = CheckboxListTile(
          title: Text(
            'Perception (WIS): ${((int.tryParse(state.stats!.wisdom ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.perceptionProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
          ),
          checkColor: blueGrey,
          tristate: true,
          value: state.stats!.perceptionProf,
          onChanged: state.statEdit!
              ? (newBool) {
                  context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(
                          perceptionProf: !state.stats!.perceptionProf!,
                        ),
                      );
                }
              : null,
        );
        CheckboxListTile performanceProfCheck = CheckboxListTile(
          title: Text(
            'Performance (CHA): ${((int.tryParse(state.stats!.charisma ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.performanceProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
          ),
          checkColor: blueGrey,
          tristate: true,
          value: state.stats!.performanceProf,
          onChanged: state.statEdit!
              ? (newBool) {
                  context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(
                          performanceProf: !state.stats!.performanceProf!,
                        ),
                      );
                }
              : null,
        );
        CheckboxListTile persuasionProfCheck = CheckboxListTile(
          title: Text(
            'Persuasion (CHA): ${((int.tryParse(state.stats!.charisma ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.persuasionProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
          ),
          checkColor: blueGrey,
          tristate: true,
          value: state.stats!.persuasionProf,
          onChanged: state.statEdit!
              ? (newBool) {
                  context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(
                          persuasionProf: !state.stats!.persuasionProf!,
                        ),
                      );
                }
              : null,
        );
        CheckboxListTile religionProfCheck = CheckboxListTile(
          title: Text(
            'Religion (INT): ${((int.tryParse(state.stats!.intelligence ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.religionProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
          ),
          checkColor: blueGrey,
          tristate: true,
          value: state.stats!.religionProf,
          onChanged: state.statEdit!
              ? (newBool) {
                  context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(
                          religionProf: !state.stats!.religionProf!,
                        ),
                      );
                }
              : null,
        );
        CheckboxListTile sleightOfHandProfCheck = CheckboxListTile(
          title: Text(
            'Sleight of Hand (DEX): ${((int.tryParse(state.stats!.dexterity ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.sleightOfHandProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
          ),
          checkColor: blueGrey,
          tristate: true,
          value: state.stats!.sleightOfHandProf,
          onChanged: state.statEdit!
              ? (newBool) {
                  context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(
                          sleightOfHandProf: !state.stats!.sleightOfHandProf!,
                        ),
                      );
                }
              : null,
        );
        CheckboxListTile stealthProfCheck = CheckboxListTile(
          title: Text(
            'Stealth (DEX): ${((int.tryParse(state.stats!.dexterity ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.stealthProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
          ),
          checkColor: blueGrey,
          tristate: true,
          value: state.stats!.stealthProf,
          onChanged: state.statEdit!
              ? (newBool) {
                  context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(
                          stealthProf: !state.stats!.stealthProf!,
                        ),
                      );
                }
              : null,
        );
        CheckboxListTile survivalProfCheck = CheckboxListTile(
          title: Text(
            'Survival (WIS): ${((int.tryParse(state.stats!.wisdom ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.survivalProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
          ),
          checkColor: blueGrey,
          tristate: true,
          value: state.stats!.survivalProf,
          onChanged: state.statEdit!
              ? (newBool) {
                  context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(
                          survivalProf: !state.stats!.survivalProf!,
                        ),
                      );
                }
              : null,
        );
        return Column(
          children: [
            acrobaticsProfCheck,
            animalHandlingProfCheck,
            arcanaProfCheck,
            athleticsProfCheck,
            deceptionProfCheck,
            historyProfCheck,
            insightProfCheck,
            intimidationProfCheck,
            investigationProfCheck,
            medicineProfCheck,
            natureProfCheck,
            perceptionProfCheck,
            performanceProfCheck,
            persuasionProfCheck,
            religionProfCheck,
            sleightOfHandProfCheck,
            stealthProfCheck,
            survivalProfCheck,
          ],
        );
      },
    );
  }
}

class _EditBlock extends StatelessWidget {
  const _EditBlock();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatCubit, StatState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<StatCubit>().statEdit(!state.statEdit!);
                  },
                  icon: const Icon(
                    Icons.edit,
                  ),
                ),
                Text(
                  'Edit',
                  style: dndFont,
                ),
              ],
            ),
            seperation,
            seperation,
          ],
        );
      },
    );
  }
}

class _CoreStats extends StatelessWidget {
  const _CoreStats();

  @override
  Widget build(BuildContext context) {
    const EdgeInsets threex3GridPadding = EdgeInsets.symmetric(horizontal: 30);

    return BlocBuilder<StatCubit, StatState>(
      builder: (context, state) {
        TextEditingController str = TextEditingController();
        str.text = state.stats!.strength ?? '20';
        TextEditingController dex = TextEditingController();
        dex.text = state.stats!.dexterity ?? '';
        TextEditingController con = TextEditingController();
        con.text = state.stats!.constitution ?? '';
        TextEditingController int1 = TextEditingController();
        int1.text = state.stats!.intelligence ?? '';
        TextEditingController wis = TextEditingController();
        wis.text = state.stats!.wisdom ?? '';
        TextEditingController cha = TextEditingController();
        cha.text = state.stats!.charisma ?? '';
        return Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: StatTextBox(
                    onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(strength: str.text)),
                    onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(strength: str.text)),
                    enabled: state.statEdit!,
                    padding: threex3GridPadding,
                    controller: str,
                    hintText: 'STR',
                    subtitle: 'STR (${((int.tryParse(state.stats!.strength ?? '10') ?? 10) - 10) ~/ 2})',
                  ),
                ),
                Flexible(
                  child: StatTextBox(
                    onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(dexterity: dex.text)),
                    onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(dexterity: dex.text)),
                    enabled: state.statEdit!,
                    padding: threex3GridPadding,
                    controller: dex,
                    hintText: 'DEX',
                    subtitle: 'DEX (${((int.tryParse(state.stats!.dexterity ?? '10') ?? 10) - 10) ~/ 2})',
                  ),
                ),
                Flexible(
                  child: StatTextBox(
                    onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(constitution: con.text)),
                    onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(constitution: con.text)),
                    enabled: state.statEdit!,
                    padding: threex3GridPadding,
                    controller: con,
                    hintText: 'CON',
                    subtitle: 'CON (${((int.tryParse(state.stats!.constitution ?? '10') ?? 10) - 10) ~/ 2})',
                  ),
                ),
              ],
            ),
            seperation,
            Row(
              children: [
                Flexible(
                  child: StatTextBox(
                    onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(intelligence: int1.text)),
                    onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(intelligence: int1.text)),
                    enabled: state.statEdit!,
                    padding: threex3GridPadding,
                    controller: int1,
                    hintText: 'INT',
                    subtitle: 'INT (${((int.tryParse(state.stats!.intelligence ?? '10') ?? 10) - 10) ~/ 2})',
                  ),
                ),
                Flexible(
                  child: StatTextBox(
                    onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(wisdom: wis.text)),
                    onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(wisdom: wis.text)),
                    enabled: state.statEdit!,
                    padding: threex3GridPadding,
                    controller: wis,
                    hintText: 'WIS',
                    subtitle: 'WIS (${((int.tryParse(state.stats!.wisdom ?? '10') ?? 10) - 10) ~/ 2})',
                  ),
                ),
                Flexible(
                  child: StatTextBox(
                    onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(charisma: cha.text)),
                    onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(charisma: cha.text)),
                    enabled: state.statEdit!,
                    padding: threex3GridPadding,
                    controller: cha,
                    hintText: 'CHA',
                    subtitle: 'CHA (${((int.tryParse(state.stats!.charisma ?? '10') ?? 10) - 10) ~/ 2})',
                  ),
                ),
              ],
            ),
            seperation,
            horizontalLine,
            seperation,
          ],
        );
      },
    );
  }
}

class _Hps extends StatelessWidget {
  const _Hps();

  @override
  Widget build(BuildContext context) {
    const EdgeInsets twox1RowPadding = EdgeInsets.symmetric(horizontal: 40);
    return BlocBuilder<StatCubit, StatState>(
      builder: (context, state) {
        TextEditingController currentHp = TextEditingController();
        currentHp.text = state.stats!.currentHp ?? '0';
        TextEditingController maxHp = TextEditingController();
        maxHp.text = state.stats!.maxHp ?? '0';
        TextEditingController tempHp = TextEditingController();
        tempHp.text = state.stats!.tempHp ?? '0';
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: StatTextBox(
                    onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(currentHp: currentHp.text)),
                    onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(currentHp: currentHp.text)),
                    enabled: state.statEdit!,
                    padding: twox1RowPadding,
                    controller: currentHp,
                    hintText: 'Current HP',
                    subtitle: 'Current HP',
                  ),
                ),
                Flexible(
                  child: StatTextBox(
                    onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(maxHp: maxHp.text)),
                    onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(maxHp: maxHp.text)),
                    enabled: state.statEdit!,
                    padding: twox1RowPadding,
                    controller: maxHp,
                    hintText: 'MAX HP',
                    subtitle: 'MAX HP',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: StatTextBox(
                    onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(tempHp: tempHp.text)),
                    onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(tempHp: tempHp.text)),
                    enabled: state.statEdit!,
                    padding: const EdgeInsets.symmetric(horizontal: 140),
                    controller: tempHp,
                    hintText: 'Temp HP',
                    subtitle: 'Temp HP',
                  ),
                ),
              ],
            ),
            seperation,
            horizontalLine,
            seperation,
          ],
        );
      },
    );
  }
}

class _Levels extends StatelessWidget {
  const _Levels();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatCubit, StatState>(
      builder: (context, state) {
        TextEditingController playerLevel = TextEditingController();
        playerLevel.text = state.stats!.totalPlayerLevel ?? '0';
        TextEditingController classLevel = TextEditingController();
        classLevel.text = state.stats!.classLevel ?? '1';
        TextEditingController subClass1Lvl = TextEditingController();
        subClass1Lvl.text = state.stats!.subClass1Lvl ?? '1';
        TextEditingController subClass2Lvl = TextEditingController();
        subClass2Lvl.text = state.stats!.subClass2Lvl ?? '1';
        return Column(children: [
          Row(
            children: [
              Flexible(
                child: StatTextBox(
                  onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(totalPlayerLevel: playerLevel.text),
                      ),
                  onEditingComplete: () => context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(totalPlayerLevel: playerLevel.text),
                      ),
                  enabled: state.statEdit!,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  controller: playerLevel,
                  hintText: 'Player Level',
                  subtitle: 'Player Level',
                ),
              ),
              Flexible(
                child: StatTextBox(
                  onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(classLevel: classLevel.text)),
                  onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(classLevel: classLevel.text)),
                  enabled: state.statEdit!,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  controller: classLevel,
                  hintText: 'Class Level',
                  subtitle: 'Class Level',
                ),
              ),
            ],
          ),
          seperation,
          Row(
            children: [
              Flexible(
                child: StatTextBox(
                  onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(subClass1Lvl: subClass1Lvl.text)),
                  onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(subClass1Lvl: subClass1Lvl.text)),
                  enabled: state.statEdit!,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  controller: subClass1Lvl,
                  hintText: 'Subclass (1) Level',
                  subtitle: 'Subclass (1) Level',
                ),
              ),
              Flexible(
                child: StatTextBox(
                  onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(subClass2Lvl: subClass2Lvl.text)),
                  onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(subClass2Lvl: subClass2Lvl.text)),
                  enabled: state.statEdit!,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  controller: subClass2Lvl,
                  hintText: 'Subclass (2) Level',
                  subtitle: 'Subclass (2) Level',
                ),
              ),
            ],
          ),
          seperation,
          Text(
            'hint: Class + Subclass Level should = Player Level',
            style: dndFont,
          ),
          seperation,
          horizontalLine,
          seperation,
        ]);
      },
    );
  }
}
