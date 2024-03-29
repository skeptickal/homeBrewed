import 'package:dnd_character_manager/client/spacing.dart';
import 'package:dnd_character_manager/constants/screen_wrapper.dart';
import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/cubits/character_cubit/character_cubit.dart';
import 'package:dnd_character_manager/models/character/dnd_character.dart';
import 'package:dnd_character_manager/pages/tabs/bio_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/theme_data.dart';

class CharacterViewerScreen extends StatelessWidget {
  final DndCharacter dndCharacter;
  const CharacterViewerScreen({super.key, required this.dndCharacter});

  @override
  Widget build(BuildContext context) {
    TextEditingController str = TextEditingController();
    str.text = '';
    TextEditingController dex = TextEditingController();
    dex.text = '';
    TextEditingController con = TextEditingController();
    con.text = '';
    TextEditingController int = TextEditingController();
    int.text = '';
    TextEditingController wis = TextEditingController();
    wis.text = '';
    TextEditingController cha = TextEditingController();
    cha.text = '';
    TextEditingController currentHP = TextEditingController();
    currentHP.text = '';
    TextEditingController maxHP = TextEditingController();
    maxHP.text = '';
    return ScreenWrapper(
      title: dndCharacter.name,
      child: DefaultTabController(
        length: 9,
        child: Column(
          children: [
            TabBar(
              indicatorColor: blueGrey,
              labelColor: blueGrey,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: const [
                Tab(text: 'Stats', icon: FaIcon(FontAwesomeIcons.shieldHalved)),
                Tab(text: 'Abilities', icon: FaIcon(FontAwesomeIcons.exclamation)),
                Tab(text: 'Spells', icon: FaIcon(FontAwesomeIcons.wandMagicSparkles)),
                Tab(text: 'Weapons', icon: ImageIcon(AssetImage('assets/sword.png'))),
                Tab(text: 'Resources', icon: Icon(Icons.handyman)),
                Tab(text: 'Items', icon: FaIcon(FontAwesomeIcons.toolbox)),
                Tab(text: 'Income', icon: Icon(Icons.attach_money)),
                Tab(text: 'Bio', icon: FaIcon(FontAwesomeIcons.scroll)),
                Tab(text: 'Notes', icon: FaIcon(FontAwesomeIcons.noteSticky)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  BlocBuilder<CharacterCubit, CharacterState>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () => context.read<CharacterCubit>().statEdit(!state.statEdit!),
                              icon: const Icon(
                                Icons.edit,
                              ),
                            ),
                            seperation,
                            seperation,
                            Row(
                              children: [
                                Flexible(
                                  child: StatTextBox(
                                    enabled: state.statEdit!,
                                    padding: EdgeInsets.symmetric(horizontal: 50),
                                    controller: str,
                                    hintText: 'Player Level',
                                    subtitle: 'Player Level',
                                  ),
                                ),
                                Flexible(
                                  child: StatTextBox(
                                    enabled: state.statEdit!,
                                    padding: EdgeInsets.symmetric(horizontal: 50),
                                    controller: dex,
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
                                    padding: EdgeInsets.symmetric(horizontal: 50),
                                    controller: con,
                                    hintText: 'Subclass (1) Level',
                                    subtitle: 'Subclass (1) Level',
                                  ),
                                ),
                                Flexible(
                                  child: StatTextBox(
                                    enabled: state.statEdit!,
                                    padding: EdgeInsets.symmetric(horizontal: 50),
                                    controller: con,
                                    hintText: 'Subclass (2) Level',
                                    subtitle: 'Subclass (2) Level',
                                  ),
                                ),
                              ],
                            ),
                            seperation,
                            Text(
                              'hint: Subclasses + Class Level Should = Player Level',
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
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    controller: currentHP,
                                    hintText: 'Current HP',
                                    subtitle: 'Current HP',
                                  ),
                                ),
                                Flexible(
                                  child: StatTextBox(
                                    enabled: state.statEdit!,
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    controller: maxHP,
                                    hintText: 'MAX HP',
                                    subtitle: 'MAX HP',
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
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    controller: str,
                                    hintText: 'STR',
                                    subtitle: 'STR',
                                  ),
                                ),
                                Flexible(
                                  child: StatTextBox(
                                    enabled: state.statEdit!,
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    controller: dex,
                                    hintText: 'DEX',
                                    subtitle: 'DEX',
                                  ),
                                ),
                                Flexible(
                                  child: StatTextBox(
                                    enabled: state.statEdit!,
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    controller: con,
                                    hintText: 'CON',
                                    subtitle: 'CON',
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
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    controller: int,
                                    hintText: 'INT',
                                    subtitle: 'INT',
                                  ),
                                ),
                                Flexible(
                                  child: StatTextBox(
                                    enabled: state.statEdit!,
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    controller: wis,
                                    hintText: 'WIS',
                                    subtitle: 'WIS',
                                  ),
                                ),
                                Flexible(
                                  child: StatTextBox(
                                    enabled: state.statEdit!,
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    controller: cha,
                                    hintText: 'CHA',
                                    subtitle: 'CHA',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Center(child: Text('Abilities')),
                  const Center(child: Text('Spells')),
                  const Center(child: Text('Weapons')),
                  const Center(child: Text('Resources')),
                  const Center(child: Text('Items')),
                  const Center(child: Text('Income')),
                  BioTab(dndCharacter: dndCharacter),
                  const Center(child: Text('Campaign Notes')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
