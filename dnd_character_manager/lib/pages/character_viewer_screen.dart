import 'package:dnd_character_manager/constants/screen_wrapper.dart';
import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/cubits/character_cubit/character_cubit.dart';
import 'package:dnd_character_manager/models/character/dnd_character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/theme_data.dart';

class CharacterViewerScreen extends StatelessWidget {
  final DndCharacter dndCharacter;
  const CharacterViewerScreen({super.key, required this.dndCharacter});

  @override
  Widget build(BuildContext context) {
    TextEditingController bio = TextEditingController();

    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        bio.text = 'initialValue state.dndCharacter!.bio!';
        return ScreenWrapper(
            title: dndCharacter.name,
            child: DefaultTabController(
                length: 6,
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: blueGrey,
                      labelColor: blueGrey,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      tabs: const [
                        Tab(text: 'Stats', icon: FaIcon(FontAwesomeIcons.shieldHalved)),
                        Tab(text: 'Bio', icon: FaIcon(FontAwesomeIcons.scroll)),
                        Tab(text: 'Items', icon: FaIcon(FontAwesomeIcons.toolbox)),
                        Tab(text: 'Weapons', icon: ImageIcon(AssetImage('assets/sword.png'))),
                        Tab(text: 'Spells', icon: FaIcon(FontAwesomeIcons.wandMagicSparkles)),
                        Tab(text: 'Income', icon: Icon(Icons.attach_money)),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        Center(child: Text('Stats\n\n${dndCharacter.name}\n${dndCharacter.dndClass}\n${dndCharacter.race}')),
                        SingleChildScrollView(
                            child: BigTextBox(
                          enabled: false,
                          controller: bio,
                          padding: EdgeInsets.all(6),
                          hintText: 'bio',
                          subtitle: 'bio',
                          minLines: 50,
                        )),
                        Center(child: Text('Items')),
                        Center(child: Text('Weapons')),
                        Center(child: Text('Spells')),
                        Center(child: Text('Income')),
                      ]),
                    )
                  ],
                )));
      },
    );
  }
}
