import 'package:dnd_character_manager/cubits/stat_cubit/cubit/stat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../client/spacing.dart';
import '../../constants/text_fields.dart';
import '../../constants/theme_data.dart';
import '../../models/stats.dart';

class StatTab extends StatelessWidget {
  final String charID;
  const StatTab({super.key, required this.charID});

  @override
  Widget build(BuildContext context) {
    context.read<StatCubit>().readStatsData(charID);
    return BlocBuilder<StatCubit, StatState>(
      builder: (context, state) {
        Widget acrobaticsProfCheck = Row(
          children: [
            Checkbox(
              checkColor: blueGrey,
              tristate: true,
              value: state.stats!.acrobaticsProf,
              onChanged: state.statEdit!
                  ? (newBool) {
                      context.read<StatCubit>().readStatsData(charID);
                      context.read<StatCubit>().setStatsData(
                            state.stats!.copyWith(
                              acrobaticsProf: !state.stats!.acrobaticsProf!,
                            ),
                          );
                      context.read<StatCubit>().readStatsData(charID);
                    }
                  : null,
            ),
            Text(
              '${((int.tryParse(state.stats!.dexterity ?? '10') ?? 10) - 10) ~/ 2 + (state.stats!.acrobaticsProf ?? false ? (int.tryParse(state.stats!.proficiencyBonus ?? '0') ?? 1) : 0)}',
            ),
          ],
        );

        const EdgeInsets threex3GridPadding = EdgeInsets.symmetric(horizontal: 30);
        const EdgeInsets twox1RowPadding = EdgeInsets.symmetric(horizontal: 40);
        TextEditingController playerLevel = TextEditingController();
        playerLevel.text = state.stats!.totalPlayerLevel ?? '1';
        TextEditingController classLevel = TextEditingController();
        classLevel.text = state.stats!.classLevel ?? '1';
        TextEditingController subClass1Level = TextEditingController();
        subClass1Level.text = state.stats!.subClass1Lvl ?? '1';
        TextEditingController subClass2Level = TextEditingController();
        subClass2Level.text = state.stats!.subClass2Lvl ?? '1';
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
        TextEditingController currentHP = TextEditingController();
        currentHP.text = state.stats!.currentHp ?? '0';
        TextEditingController maxHP = TextEditingController();
        maxHP.text = state.stats!.maxHp ?? '0';
        TextEditingController tempHP = TextEditingController();
        tempHP.text = state.stats!.tempHp ?? '0';
        return SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<StatCubit>().statEdit(!state.statEdit!);
                      Stats stats1 = Stats(
                        strength: str.text,
                        charID: charID,
                        charisma: cha.text,
                        dexterity: dex.text,
                        constitution: con.text,
                        intelligence: int1.text,
                        wisdom: wis.text,
                        currentHp: currentHP.text,
                        maxHp: maxHP.text,
                        tempHp: tempHP.text,
                        totalPlayerLevel: playerLevel.text,
                        classLevel: classLevel.text,
                        subClass1Lvl: subClass1Level.text,
                        subClass2Lvl: subClass2Level.text,
                        acrobaticsProf: state.stats!.acrobaticsProf!,
                      );
                      context.read<StatCubit>().setStatsData(stats1);
                      context.read<StatCubit>().readStatsData(charID);
                    },
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                  Text(
                    'Edit/Save',
                    style: dndFont,
                  ),
                ],
              ),
              seperation,
              seperation,
              Row(
                children: [
                  Flexible(
                    child: StatTextBox(
                      enabled: state.statEdit!,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      controller: playerLevel,
                      hintText: 'Player Level',
                      subtitle: 'Player Level',
                    ),
                  ),
                  Flexible(
                    child: StatTextBox(
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
                      enabled: state.statEdit!,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      controller: subClass1Level,
                      hintText: 'Subclass (1) Level',
                      subtitle: 'Subclass (1) Level',
                    ),
                  ),
                  Flexible(
                    child: StatTextBox(
                      enabled: state.statEdit!,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      controller: subClass2Level,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: StatTextBox(
                      enabled: state.statEdit!,
                      padding: twox1RowPadding,
                      controller: currentHP,
                      hintText: 'Current HP',
                      subtitle: 'Current HP',
                    ),
                  ),
                  Flexible(
                    child: StatTextBox(
                      enabled: state.statEdit!,
                      padding: twox1RowPadding,
                      controller: maxHP,
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
                      enabled: state.statEdit!,
                      padding: const EdgeInsets.symmetric(horizontal: 140),
                      controller: tempHP,
                      hintText: 'Temp HP',
                      subtitle: 'Temp HP',
                    ),
                  ),
                ],
              ),
              seperation,
              horizontalLine,
              seperation,
              Row(
                children: [
                  Flexible(
                    child: StatTextBox(
                      enabled: state.statEdit!,
                      padding: threex3GridPadding,
                      controller: str,
                      hintText: 'STR',
                      subtitle: 'STR (${((int.tryParse(state.stats!.strength ?? '10') ?? 10) - 10) ~/ 2})',
                    ),
                  ),
                  Flexible(
                    child: StatTextBox(
                      enabled: state.statEdit!,
                      padding: threex3GridPadding,
                      controller: dex,
                      hintText: 'DEX',
                      subtitle: 'DEX (${((int.tryParse(state.stats!.dexterity ?? '10') ?? 10) - 10) ~/ 2})',
                    ),
                  ),
                  Flexible(
                    child: StatTextBox(
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
                      enabled: state.statEdit!,
                      padding: threex3GridPadding,
                      controller: int1,
                      hintText: 'INT',
                      subtitle: 'INT (${((int.tryParse(state.stats!.intelligence ?? '10') ?? 10) - 10) ~/ 2})',
                    ),
                  ),
                  Flexible(
                    child: StatTextBox(
                      enabled: state.statEdit!,
                      padding: threex3GridPadding,
                      controller: wis,
                      hintText: 'WIS',
                      subtitle: 'WIS (${((int.tryParse(state.stats!.wisdom ?? '10') ?? 10) - 10) ~/ 2})',
                    ),
                  ),
                  Flexible(
                    child: StatTextBox(
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
              acrobaticsProfCheck,
            ],
          ),
        );
      },
    );
  }
}
