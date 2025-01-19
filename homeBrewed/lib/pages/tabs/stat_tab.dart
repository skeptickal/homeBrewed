import 'package:d20/d20.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homeBrewed/cubits/stat_cubit/cubit/stat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/spacing.dart';
import '../../constants/text_fields.dart';
import '../../constants/theme_data.dart';

class StatTab extends StatelessWidget {
  final String charID;
  const StatTab({super.key, required this.charID});

  @override
  Widget build(BuildContext context) {
    context.read<StatCubit>().readStatsData(charID);
    return const SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          _EditBlock(),
          _Levels(),
          _Hps(),
          _CoreStats(),
          _SavingThrows(),
          _SkillChecks(),
          _ProficienciesNotes(),
          _StatNotes(),
          _EditBlock(),
        ],
      ),
    );
  }
}

class _ProficienciesNotes extends StatelessWidget {
  const _ProficienciesNotes();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatCubit, StatState>(
      builder: (context, state) {
        TextEditingController proficiencies = TextEditingController();
        proficiencies.text = state.stats!.proficiencies ?? '';
        return Column(
          children: [
            BigTextBox(
              onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(proficiencies: proficiencies.text)),
              onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(proficiencies: proficiencies.text)),
              minLines: 10,
              enabled: state.statEdit!,
              padding: const EdgeInsets.all(6),
              controller: proficiencies,
              hintText: 'e.g. TYPE ARMOR - Light Armor, Tool proficiences, etc.',
              subtitle: 'Notes for Proficiencies',
            ),
            seperation,
            seperation
          ],
        );
      },
    );
  }
}

class _SavingThrows extends StatelessWidget {
  const _SavingThrows();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatCubit, StatState>(
      builder: (context, state) {
        TextEditingController proficiencyBonus = TextEditingController();
        proficiencyBonus.text = state.stats!.proficiencyBonus ?? '1';
        return Column(
          children: [
            SelectableText(
              'Proficiency',
              style: dndFont.copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70.0),
                  child: Icon(Icons.check_box_outline_blank),
                ),
                Flexible(
                  child: StatTextBox(
                    onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(
                          state.stats!.copyWith(proficiencyBonus: proficiencyBonus.text),
                        ),
                    onEditingComplete: () => context.read<StatCubit>().setStatsData(
                          state.stats!.copyWith(proficiencyBonus: proficiencyBonus.text),
                        ),
                    enabled: state.statEdit!,
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    controller: proficiencyBonus,
                    hintText: '1',
                    subtitle: 'Bonus',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: Icon(
                    Icons.check,
                    color: themeColor,
                  ),
                ),
              ],
            ),
            horizontalLine,
            seperation,
            SelectableText(
              'Saving Throws',
              style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            CheckboxListTile(
              title: Text(_calcModifierWithProf(
                'Strength',
                state.stats!.strength,
                state.stats!.strSaveProf,
                state.stats!.proficiencyBonus,
              )),
              checkColor: themeColor,
              activeColor: white,
              tristate: true,
              value: state.stats!.strSaveProf,
              onChanged: state.statEdit!
                  ? (newBool) {
                      context.read<StatCubit>().setStatsData(
                            state.stats!.copyWith(
                              strSaveProf: !state.stats!.strSaveProf!,
                            ),
                          );
                    }
                  : null,
            ),
            CheckboxListTile(
              title: Text(_calcModifierWithProf(
                'Dexterity',
                state.stats!.dexterity,
                state.stats!.dexSaveProf,
                state.stats!.proficiencyBonus,
              )),
              checkColor: themeColor,
              activeColor: white,
              tristate: true,
              value: state.stats!.dexSaveProf,
              onChanged: state.statEdit!
                  ? (newBool) {
                      context.read<StatCubit>().setStatsData(
                            state.stats!.copyWith(
                              dexSaveProf: !state.stats!.dexSaveProf!,
                            ),
                          );
                    }
                  : null,
            ),
            CheckboxListTile(
              title: Text(_calcModifierWithProf(
                'Constitution',
                state.stats!.constitution,
                state.stats!.conSaveProf,
                state.stats!.proficiencyBonus,
              )),
              checkColor: themeColor,
              activeColor: white,
              tristate: true,
              value: state.stats!.conSaveProf,
              onChanged: state.statEdit!
                  ? (newBool) {
                      context.read<StatCubit>().setStatsData(
                            state.stats!.copyWith(
                              conSaveProf: !state.stats!.conSaveProf!,
                            ),
                          );
                    }
                  : null,
            ),
            CheckboxListTile(
              title: Text(_calcModifierWithProf(
                'Intelligence',
                state.stats!.intelligence,
                state.stats!.intSaveProf,
                state.stats!.proficiencyBonus,
              )),
              checkColor: themeColor,
              activeColor: white,
              tristate: true,
              value: state.stats!.intSaveProf,
              onChanged: state.statEdit!
                  ? (newBool) {
                      context.read<StatCubit>().setStatsData(
                            state.stats!.copyWith(
                              intSaveProf: !state.stats!.intSaveProf!,
                            ),
                          );
                    }
                  : null,
            ),
            CheckboxListTile(
              title: Text(_calcModifierWithProf(
                'Wisdom',
                state.stats!.wisdom,
                state.stats!.wisSaveProf,
                state.stats!.proficiencyBonus,
              )),
              checkColor: themeColor,
              activeColor: white,
              tristate: true,
              value: state.stats!.wisSaveProf,
              onChanged: state.statEdit!
                  ? (newBool) {
                      context.read<StatCubit>().setStatsData(
                            state.stats!.copyWith(
                              wisSaveProf: !state.stats!.wisSaveProf!,
                            ),
                          );
                    }
                  : null,
            ),
            CheckboxListTile(
              title: Text(_calcModifierWithProf(
                'Charisma',
                state.stats!.charisma,
                state.stats!.chaSaveProf,
                state.stats!.proficiencyBonus,
              )),
              checkColor: themeColor,
              activeColor: white,
              tristate: true,
              value: state.stats!.chaSaveProf,
              onChanged: state.statEdit!
                  ? (newBool) {
                      context.read<StatCubit>().setStatsData(
                            state.stats!.copyWith(
                              chaSaveProf: !state.stats!.chaSaveProf!,
                            ),
                          );
                    }
                  : null,
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

class _StatNotes extends StatelessWidget {
  const _StatNotes();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatCubit, StatState>(
      builder: (context, state) {
        TextEditingController statNotes = TextEditingController();
        statNotes.text = state.stats!.statNotes ?? '';
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
          title: Text(_calcModifierWithProf(
            'Acrobatics (DEX)',
            state.stats!.dexterity,
            state.stats!.acrobaticsProf,
            state.stats!.proficiencyBonus,
          )),
          checkColor: themeColor,
          activeColor: white,
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
          title: Text(_calcModifierWithProf(
            'Animal Handling (WIS)',
            state.stats!.wisdom,
            state.stats!.animalHandlingProf,
            state.stats!.proficiencyBonus,
          )),
          checkColor: themeColor,
          activeColor: white,
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
          title: Text(_calcModifierWithProf(
            'Arcana (INT)',
            state.stats!.intelligence,
            state.stats!.arcanaProf,
            state.stats!.proficiencyBonus,
          )),
          checkColor: themeColor,
          activeColor: white,
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
          title: Text(_calcModifierWithProf(
            'Athletics (STR)',
            state.stats!.strength,
            state.stats!.athleticsProf,
            state.stats!.proficiencyBonus,
          )),
          checkColor: themeColor,
          activeColor: white,
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
          title: Text(_calcModifierWithProf(
            'Deception (CHA)',
            state.stats!.charisma,
            state.stats!.deceptionProf,
            state.stats!.proficiencyBonus,
          )),
          checkColor: themeColor,
          activeColor: white,
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
          title: Text(_calcModifierWithProf(
            'History (INT)',
            state.stats!.intelligence,
            state.stats!.historyProf,
            state.stats!.proficiencyBonus,
          )),
          checkColor: themeColor,
          activeColor: white,
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
          title: Text(_calcModifierWithProf(
            'Insight (WIS)',
            state.stats!.wisdom,
            state.stats!.insightProf,
            state.stats!.proficiencyBonus,
          )),
          checkColor: themeColor,
          activeColor: white,
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
          title: Text(_calcModifierWithProf(
            'Intimidation (CHA)',
            state.stats!.charisma,
            state.stats!.intimidationProf,
            state.stats!.proficiencyBonus,
          )),
          checkColor: themeColor,
          activeColor: white,
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
          title: Text(_calcModifierWithProf(
            'Investigation (INT)',
            state.stats!.intelligence,
            state.stats!.investigationProf,
            state.stats!.proficiencyBonus,
          )),
          checkColor: themeColor,
          activeColor: white,
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
          title: Text(_calcModifierWithProf(
            'Medicine (WIS)',
            state.stats!.wisdom,
            state.stats!.medicineProf,
            state.stats!.proficiencyBonus,
          )),
          checkColor: themeColor,
          activeColor: white,
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
          title: Text(_calcModifierWithProf(
            'Nature (INT)',
            state.stats!.intelligence,
            state.stats!.natureProf,
            state.stats!.proficiencyBonus,
          )),
          checkColor: themeColor,
          activeColor: white,
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
          title: Text(_calcModifierWithProf(
            'Perception (WIS)',
            state.stats!.wisdom,
            state.stats!.perceptionProf,
            state.stats!.proficiencyBonus,
          )),
          checkColor: themeColor,
          activeColor: white,
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
          title: Text(_calcModifierWithProf(
            'Performance (CHA)',
            state.stats!.charisma,
            state.stats!.performanceProf,
            state.stats!.proficiencyBonus,
          )),
          checkColor: themeColor,
          activeColor: white,
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
          title: Text(_calcModifierWithProf(
            'Persuasion (CHA)',
            state.stats!.charisma,
            state.stats!.persuasionProf,
            state.stats!.proficiencyBonus,
          )),
          checkColor: themeColor,
          activeColor: white,
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
          title: Text(_calcModifierWithProf(
            'Religion (INT)',
            state.stats!.intelligence,
            state.stats!.religionProf,
            state.stats!.proficiencyBonus,
          )),
          checkColor: themeColor,
          activeColor: white,
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
          title: Text(_calcModifierWithProf(
            'Sleight of Hand (DEX)',
            state.stats!.dexterity,
            state.stats!.sleightOfHandProf,
            state.stats!.proficiencyBonus,
          )),
          checkColor: themeColor,
          activeColor: white,
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
          title: Text(_calcModifierWithProf(
            'Stealth (DEX)',
            state.stats!.dexterity,
            state.stats!.stealthProf,
            state.stats!.proficiencyBonus,
          )),
          checkColor: themeColor,
          activeColor: white,
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
          title: Text(_calcModifierWithProf(
            'Survival (WIS)',
            state.stats!.wisdom,
            state.stats!.survivalProf,
            state.stats!.proficiencyBonus,
          )),
          checkColor: themeColor,
          activeColor: white,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectableText(
                  'Inspiration',
                  style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                Checkbox(
                  checkColor: themeColor,
                  activeColor: white,
                  tristate: true,
                  value: state.stats!.inspiration,
                  onChanged: state.statEdit!
                      ? (inspirationYoN) => context.read<StatCubit>().setStatsData(
                            state.stats!.copyWith(inspiration: !state.stats!.inspiration!),
                          )
                      : null,
                ),
              ],
            ),
            horizontalLine,
            seperation,
            SelectableText(
              'Skills',
              style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
            ),
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
            seperation,
            horizontalLine,
            seperation,
          ],
        );
      },
    );
  }
}

String _calcModifierWithProf(String statAbbrev, String? statToMod, bool? prof, String? profBonus) {
  int statToModNullSafe = int.tryParse(statToMod ?? '10') ?? 10;
  int profBonusAsInt = int.tryParse(profBonus ?? '0') ?? 1;
  return '$statAbbrev : ${(((statToModNullSafe) - 10)) < 0 ? (((statToModNullSafe) - 11) ~/ 2 + (prof ?? false ? (profBonusAsInt) : 0)) : (((statToModNullSafe) - 10) ~/ 2) + (prof ?? false ? (profBonusAsInt) : 0)}';
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
                SelectableText(
                  !state.statEdit! ? 'Enable Edit' : 'Disable Edit',
                  style: dndFont.copyWith(color: state.statEdit! ? black : disableGrey),
                ),
              ],
            ),
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
        int? wisdomStat = int.tryParse(state.stats!.wisdom ?? '10') ?? 10;
        int? passivePerceptionWithBonus = state.stats!.perceptionProf ?? false ? int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 0 : 0;
        return Column(
          children: [
            seperation,
            SelectableText(
              'Core Stats',
              style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            SelectableText(
              'Passive Perception: ${wisdomStat + passivePerceptionWithBonus}',
              style: dndFont,
            ),
            seperation,
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
                    subtitle: _calcModifier('STR', state.stats!.strength),
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
                    subtitle: _calcModifier('DEX', state.stats!.dexterity),
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
                    subtitle: _calcModifier('CON', state.stats!.constitution),
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
                      subtitle: _calcModifier('INT', state.stats!.intelligence)),
                ),
                Flexible(
                  child: StatTextBox(
                      onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(wisdom: wis.text)),
                      onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(wisdom: wis.text)),
                      enabled: state.statEdit!,
                      padding: threex3GridPadding,
                      controller: wis,
                      hintText: 'WIS',
                      subtitle: _calcModifier('WIS', state.stats!.wisdom)),
                ),
                Flexible(
                  child: StatTextBox(
                      onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(charisma: cha.text)),
                      onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(charisma: cha.text)),
                      enabled: state.statEdit!,
                      padding: threex3GridPadding,
                      controller: cha,
                      hintText: 'CHA',
                      subtitle: _calcModifier('CHA', state.stats!.charisma)),
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

String _calcModifier(String statAbbrev, String? statToMod) {
  int statToModNullSafe = int.tryParse(statToMod ?? '10') ?? 10;
  return '$statAbbrev (${((statToModNullSafe - 10)) < 0 ? ((statToModNullSafe - 11) ~/ 2) : ((statToModNullSafe - 10) ~/ 2)})';
}

class _Hps extends StatelessWidget {
  const _Hps();

  @override
  Widget build(BuildContext context) {
    const EdgeInsets twox1RowPadding = EdgeInsets.symmetric(horizontal: 50);
    return BlocBuilder<StatCubit, StatState>(
      builder: (context, state) {
        TextEditingController currentHp = TextEditingController();
        currentHp.text = state.stats!.currentHp ?? '0';
        TextEditingController maxHp = TextEditingController();
        maxHp.text = state.stats!.maxHp ?? '0';
        TextEditingController tempHp = TextEditingController();
        tempHp.text = state.stats!.tempHp ?? '0';
        TextEditingController hitDice = TextEditingController();
        hitDice.text = state.stats!.hitDice ?? '3';
        TextEditingController hitDiceType = TextEditingController();
        hitDiceType.text = state.stats!.hitDiceType ?? 'D6';
        TextEditingController deathSaveSuccesses = TextEditingController();
        deathSaveSuccesses.text = state.stats!.deathSaveSuccesses ?? '3';
        TextEditingController deathSaveFailures = TextEditingController();
        deathSaveFailures.text = state.stats!.deathSaveFailures ?? 'D6';
        return Column(
          children: [
            SelectableText(
              'Hit Points',
              style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
            ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 150),
                    controller: tempHp,
                    hintText: 'Temp HP',
                    subtitle: 'Temp HP',
                  ),
                ),
              ],
            ),
            seperation,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: StatTextBox(
                    onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(hitDice: hitDice.text)),
                    onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(hitDice: hitDice.text)),
                    enabled: state.statEdit!,
                    padding: twox1RowPadding,
                    controller: hitDice,
                    hintText: 'Hit Dice',
                    subtitle: 'Hit Dice (${state.stats!.hitDiceType ?? 'D8'})',
                  ),
                ),
                Flexible(
                  child: StatTextBox(
                    inputType: TextInputType.text,
                    onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(hitDiceType: hitDiceType.text)),
                    onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(hitDiceType: hitDiceType.text)),
                    enabled: state.statEdit!,
                    padding: twox1RowPadding,
                    controller: hitDiceType,
                    hintText: 'D10',
                    subtitle: 'Hit Dice Type (D6, D8, D10)',
                  ),
                ),
              ],
            ),
            seperation,
            horizontalLine,
            seperation,
            SelectableText(
              'Death Saves',
              style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            SelectableText(
              'Min 0, Max 3',
              style: dndFont,
            ),
            seperation,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: StatTextBox(
                    onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(deathSaveSuccesses: deathSaveSuccesses.text)),
                    onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(deathSaveSuccesses: deathSaveSuccesses.text)),
                    enabled: state.statEdit!,
                    padding: twox1RowPadding,
                    controller: deathSaveSuccesses,
                    hintText: 'Successes, 1-3',
                    subtitle: 'Successes',
                  ),
                ),
                Flexible(
                  child: StatTextBox(
                    onEditingComplete: () => context.read<StatCubit>().setStatsData(state.stats!.copyWith(hitDiceType: hitDiceType.text)),
                    onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(state.stats!.copyWith(hitDiceType: hitDiceType.text)),
                    enabled: state.statEdit!,
                    padding: twox1RowPadding,
                    controller: deathSaveFailures,
                    hintText: 'Failures, 1-3',
                    subtitle: 'Failures',
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
        TextEditingController armorClass = TextEditingController();
        armorClass.text = state.stats!.armorClass ?? '0';
        TextEditingController playerLevel = TextEditingController();
        playerLevel.text = state.stats!.totalPlayerLevel ?? '0';
        TextEditingController classLevel = TextEditingController();
        classLevel.text = state.stats!.classLevel ?? '1';
        TextEditingController subClass1Lvl = TextEditingController();
        subClass1Lvl.text = state.stats!.subClass1Lvl ?? '1';
        TextEditingController subClass2Lvl = TextEditingController();
        subClass2Lvl.text = state.stats!.subClass2Lvl ?? '1';
        return Column(children: [
          SelectableText(
            'Stats',
            style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          seperation,
          seperation,
          Row(
            children: [
              Flexible(
                child: StatTextBox(
                  onTapOutside: (clickOut) => context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(armorClass: armorClass.text),
                      ),
                  onEditingComplete: () => context.read<StatCubit>().setStatsData(
                        state.stats!.copyWith(armorClass: armorClass.text),
                      ),
                  enabled: state.statEdit!,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  controller: armorClass,
                  hintText: 'Armor Class',
                  subtitle: 'Armor Class',
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 38.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _showRollDialog(context, _calcInitiative(state.stats!.dexterity));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeColor,
                      elevation: 4,
                      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Roll Initiative',
                      style: dndFont.copyWith(color: white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          seperation,
          horizontalLine,
          seperation,
          SelectableText(
            'Levels',
            style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          seperation,
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
          SelectableText(
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

void _showRollDialog(
  BuildContext context,
  String? roll,
) {
  String rollResult;
  try {
    if (roll == '') {
      roll = 'd20';
    }
    final d20 = D20();
    rollResult = d20.roll(roll!).toString();
  } catch (e) {
    rollResult = 'Invalid input';
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: themeColor,
        title: Column(
          children: [
            FaIcon(
              FontAwesomeIcons.diceD20,
              color: white,
              size: 30,
            ),
            seperation,
            Center(
              child: Text(
                '$roll: ',
                style: dndFont.copyWith(fontSize: 20, color: white),
              ),
            ),
          ],
        ),
        content: Text(
          textAlign: TextAlign.center,
          '= $rollResult',
          style: (TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: white,
          )),
        ),
      );
    },
  );
}

String _calcInitiative(String? statToMod) {
  int statToModNullSafe = int.tryParse(statToMod ?? '10') ?? 10;
  return '1d20+${((statToModNullSafe - 10)) < 0 ? ((statToModNullSafe - 11) ~/ 2) : ((statToModNullSafe - 10) ~/ 2)}';
}
