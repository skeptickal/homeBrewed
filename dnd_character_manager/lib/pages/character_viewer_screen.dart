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
    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        TextEditingController bio = TextEditingController();
        TextEditingController personality = TextEditingController();
        TextEditingController dndAlignment = TextEditingController();
        TextEditingController name = TextEditingController();
        TextEditingController race = TextEditingController();
        TextEditingController dndClass = TextEditingController();
        TextEditingController bonds = TextEditingController();
        TextEditingController flaws = TextEditingController();
        bio.text = 'initialValue state.dndCharacter!.bio!';
        personality.text = 'initialValue state.dndCharacter!.personality';
        name.text = dndCharacter.name;
        race.text = dndCharacter.race;
        dndClass.text = dndCharacter.dndClass;
        bonds.text = 'initialValue state.dndCharacter!.bonds';
        flaws.text = 'initialValue state.dndCharacter!.flaws';
        BigTextBox nameBox = BigTextBox(
          enabled: state.bioEdit!,
          padding: const EdgeInsets.all(6),
          controller: name,
          hintText: 'name',
          subtitle: 'Name',
        );
        BigTextBox raceBox = BigTextBox(
          enabled: state.bioEdit!,
          padding: const EdgeInsets.all(6),
          controller: race,
          hintText: 'race',
          subtitle: 'Race',
        );
        BigTextBox dndClassBox = BigTextBox(
          enabled: state.bioEdit!,
          padding: const EdgeInsets.all(6),
          controller: dndClass,
          hintText: 'class',
          subtitle: 'Class',
        );
        BigTextBox bioBox = BigTextBox(
          enabled: state.bioEdit!,
          controller: bio,
          padding: const EdgeInsets.all(6),
          hintText: 'bio',
          subtitle: 'Bio/Background',
          minLines: 30,
        );
        BigTextBox personalityBox = BigTextBox(
          enabled: state.bioEdit!,
          controller: personality,
          padding: const EdgeInsets.all(6),
          hintText: 'Personality',
          subtitle: 'Personality + Traits',
          minLines: 5,
        );
        BigTextBox bondsBox = BigTextBox(
          enabled: state.bioEdit!,
          controller: personality,
          padding: const EdgeInsets.all(6),
          hintText: 'e.g. Bound to ____ Group by Honor',
          subtitle: 'Bonds',
          minLines: 5,
        );
        BigTextBox flawsBox = BigTextBox(
          enabled: state.bioEdit!,
          controller: flaws,
          padding: const EdgeInsets.all(6),
          hintText: 'e.g. Kleptomaniac',
          subtitle: 'Flaws',
          minLines: 5,
        );
        List<String> dndAlignments = [
          'Select an Alignment',
          'Lawful Good',
          'Lawful Neutral',
          'Lawful Evil',
          'Lawful Neutral',
          'Neutral',
          'Chaotic Neutral',
          'Chaotic Good',
          'Chaotic Neutral',
          'Chaotic Evil',
        ];
        Column dndAlignmentSelector = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(6),
              child: DropdownButtonFormField<String>(
                key: const Key('Alignment_dropdown'),
                value: 'Select an Alignment',
                items: dndAlignments.map((alignment) {
                  return DropdownMenuItem<String>(
                    value: alignment,
                    child: Text(alignment),
                  );
                }).toList(),
                onChanged: state.bioEdit!
                    ? (String? value) {
                        dndAlignment.text = value ?? '';
                      }
                    : null,
                decoration: textInputDecoration.copyWith(hintText: 'Select an Alignment'),
              ),
            ),
          ],
        );
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
                      child: TabBarView(children: [
                        Center(child: Text('Stats\n\n${dndCharacter.name}\n${dndCharacter.dndClass}\n${dndCharacter.race}')),
                        const Center(child: Text('Abilities')),
                        const Center(child: Text('Spells')),
                        const Center(child: Text('Weapons')),
                        const Center(child: Text('Resources')),
                        const Center(child: Text('Items')),
                        const Center(child: Text('Income')),
                        SingleChildScrollView(
                            child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () => context.read<CharacterCubit>().bioEdit(!state.bioEdit!),
                                  icon: const Icon(
                                    Icons.edit,
                                  ),
                                ),
                                Text(
                                  'Edit/Save',
                                  style: dndFont,
                                )
                              ],
                            ),
                            nameBox,
                            raceBox,
                            dndClassBox,
                            Center(
                              child: Text(
                                'Select Your Character\'s Alignment',
                                style: dndFont.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            dndAlignmentSelector,
                            personalityBox,
                            bondsBox,
                            flawsBox,
                            bioBox,
                          ],
                        )),
                        const Center(child: Text('Campaign Notes')),
                      ]),
                    )
                  ],
                )));
      },
    );
  }
}
