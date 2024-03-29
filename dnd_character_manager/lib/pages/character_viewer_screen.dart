import 'package:dnd_character_manager/constants/screen_wrapper.dart';
import 'package:dnd_character_manager/models/character/dnd_character.dart';
import 'package:dnd_character_manager/pages/tabs/bio_tab.dart';
import 'package:dnd_character_manager/pages/tabs/stat_tab.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/theme_data.dart';

class CharacterViewerScreen extends StatelessWidget {
  final DndCharacter dndCharacter;
  const CharacterViewerScreen({super.key, required this.dndCharacter});

  @override
  Widget build(BuildContext context) {
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
                  StatTab(dndCharacter: dndCharacter),
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
