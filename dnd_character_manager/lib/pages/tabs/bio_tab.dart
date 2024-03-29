import 'package:dnd_character_manager/cubits/character_cubit/character_cubit.dart';
import 'package:dnd_character_manager/models/character/dnd_character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/text_fields.dart';
import '../../constants/theme_data.dart';

class BioTab extends StatelessWidget {
  final DndCharacter dndCharacter;
  const BioTab({super.key, required this.dndCharacter});

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
        TextEditingController dndSubClass1 = TextEditingController();
        TextEditingController dndSubClass2 = TextEditingController();
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
        BigTextBox dndSubClass1Box = BigTextBox(
          enabled: state.bioEdit!,
          padding: const EdgeInsets.all(6),
          controller: dndSubClass1,
          hintText: 'Optional',
          subtitle: 'Subclass (1)',
        );
        BigTextBox dndSubClass2Box = BigTextBox(
          enabled: state.bioEdit!,
          padding: const EdgeInsets.all(6),
          controller: dndSubClass2,
          hintText: 'Optional',
          subtitle: 'Subclass (2)',
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
          'Lawful Evil',
          'Lawful Neutral',
          'Neutral',
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
                key: const Key('alignment_dropdown'),
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
        return SingleChildScrollView(
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
              dndSubClass1Box,
              dndSubClass2Box,
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
          ),
        );
      },
    );
  }
}
