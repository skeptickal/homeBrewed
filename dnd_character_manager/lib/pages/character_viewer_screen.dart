import 'package:dnd_character_manager/constants/screen_wrapper.dart';
import 'package:dnd_character_manager/cubits/user_cubit/user_cubit.dart';
import 'package:dnd_character_manager/models/bio.dart';
import 'package:dnd_character_manager/pages/tabs/bio_tab.dart';
import 'package:dnd_character_manager/pages/tabs/notes_tab.dart';
import 'package:dnd_character_manager/pages/tabs/resources_tab.dart';
import 'package:dnd_character_manager/pages/tabs/stat_tab.dart';
import 'package:dnd_character_manager/pages/tabs/weapons_tab.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/theme_data.dart';

class CharacterViewerScreen extends StatelessWidget {
  final Bio bio;
  const CharacterViewerScreen({super.key, required this.bio});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return ScreenWrapper(
          title: 'Character',
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
                    Tab(text: 'Actions', icon: FaIcon(FontAwesomeIcons.exclamation)),
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
                      StatTab(charID: bio.charID!),
                      Center(child: Text('Actions ${bio.charID}')),
                      const Center(child: Text('Spells')),
                      WeaponsTab(charID: bio.charID!),
                      const ResourceTab(),
                      const Center(child: Text('Items')),
                      const Center(child: Text('Income')),
                      BioTab(bio: bio),
                      NotesTab(charID: bio.charID!),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
