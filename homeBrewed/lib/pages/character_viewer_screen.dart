import 'package:homeBrewed/constants/screen_wrapper.dart';
import 'package:homeBrewed/models/bio.dart';
import 'package:homeBrewed/pages/tabs/actions_tab.dart';
import 'package:homeBrewed/pages/tabs/bio_tab.dart';
import 'package:homeBrewed/pages/tabs/incomes_tab.dart';
import 'package:homeBrewed/pages/tabs/items_tab.dart';
import 'package:homeBrewed/pages/tabs/notes_tab.dart';
import 'package:homeBrewed/pages/tabs/resources_tab.dart';
import 'package:homeBrewed/pages/tabs/spells_tab.dart';
import 'package:homeBrewed/pages/tabs/stat_tab.dart';
import 'package:homeBrewed/pages/tabs/weapons_tab.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/theme_data.dart';
import '../cubits/bio_cubit/cubit/bio_cubit.dart';

class CharacterViewerScreen extends StatelessWidget {
  final Bio bio;
  const CharacterViewerScreen({super.key, required this.bio});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BioCubit, BioState>(
      builder: (context, state) {
        context.read<BioCubit>().readBioData(bio.charID!);
        return ScreenWrapper(
          title: state.bio?.name?.isNotEmpty ?? false ? state.bio!.name! : 'Character',
          child: DefaultTabController(
            length: 9,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: themeColor,
                  labelColor: themeColor,
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
                      DndActionsTab(charID: bio.charID!),
                      SpellsTab(charID: bio.charID!),
                      WeaponsTab(charID: bio.charID!),
                      ResourcesTab(charID: bio.charID!),
                      ItemsTab(charID: bio.charID!),
                      IncomesTab(charID: bio.charID!),
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
