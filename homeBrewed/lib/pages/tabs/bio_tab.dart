import 'package:homeBrewed/cubits/bio_cubit/cubit/bio_cubit.dart';
import 'package:homeBrewed/models/bio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../client/spacing.dart';
import '../../constants/text_fields.dart';
import '../../constants/theme_data.dart';

class BioTab extends StatelessWidget {
  final Bio bio;
  const BioTab({super.key, required this.bio});

  @override
  Widget build(BuildContext context) {
    context.read<BioCubit>().readBioData(bio.charID!);
    return const SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          _EditBlock(),
          _CoreInfo(),
          _Traits(),
          _EditBlock(),
        ],
      ),
    );
  }
}

class _CoreInfo extends StatelessWidget {
  const _CoreInfo();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BioCubit, BioState>(
      builder: (context, state) {
        TextEditingController name = TextEditingController();
        TextEditingController race = TextEditingController();
        TextEditingController dndClass = TextEditingController();
        TextEditingController dndSubClass1 = TextEditingController();
        TextEditingController dndSubClass2 = TextEditingController();
        name.text = state.bio!.name ?? '';
        race.text = state.bio!.race ?? '';
        dndClass.text = state.bio!.dndClass ?? '';
        dndSubClass1.text = state.bio!.subclass1 ?? '';
        dndSubClass2.text = state.bio!.subclass2 ?? '';
        return Column(
          children: [
            BigTextBox(
              onTapOutside: (clickOut) => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(name: name.text),
                  ),
              onEditingComplete: () => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(name: name.text),
                  ),
              enabled: state.bioEdit!,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              controller: name,
              hintText: 'name',
              subtitle: 'Name',
            ),
            BigTextBox(
              onTapOutside: (clickOut) => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(race: race.text),
                  ),
              onEditingComplete: () => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(race: race.text),
                  ),
              enabled: state.bioEdit!,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              controller: race,
              hintText: 'race',
              subtitle: 'Race',
            ),
            BigTextBox(
              onTapOutside: (clickOut) => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(dndClass: dndClass.text),
                  ),
              onEditingComplete: () => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(dndClass: dndClass.text),
                  ),
              enabled: state.bioEdit!,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              controller: dndClass,
              hintText: 'class',
              subtitle: 'Class',
            ),
            BigTextBox(
              onTapOutside: (clickOut) => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(subclass1: dndSubClass1.text),
                  ),
              onEditingComplete: () => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(subclass1: dndSubClass1.text),
                  ),
              enabled: state.bioEdit!,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              controller: dndSubClass1,
              hintText: 'Optional',
              subtitle: 'Subclass (1)',
            ),
            BigTextBox(
              onTapOutside: (clickOut) => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(subclass2: dndSubClass2.text),
                  ),
              onEditingComplete: () => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(subclass2: dndSubClass2.text),
                  ),
              enabled: state.bioEdit!,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              controller: dndSubClass2,
              hintText: 'Optional',
              subtitle: 'Subclass (2)',
            ),
          ],
        );
      },
    );
  }
}

class _Traits extends StatelessWidget {
  const _Traits();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BioCubit, BioState>(
      builder: (context, state) {
        TextEditingController background = TextEditingController();
        TextEditingController personality = TextEditingController();
        TextEditingController dndAlignment = TextEditingController();
        TextEditingController bonds = TextEditingController();
        TextEditingController flaws = TextEditingController();
        TextEditingController languages = TextEditingController();
        background.text = state.bio!.background ?? '';
        personality.text = state.bio!.personality ?? '';
        bonds.text = state.bio!.bonds ?? '';
        flaws.text = state.bio!.flaws ?? '';
        dndAlignment.text = state.bio!.alignment ?? 'Select an Alignment';
        languages.text = state.bio!.languages ?? 'Common';
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
        return Column(
          children: [
            Center(
              child: SelectableText(
                'Select Your Character\'s Alignment',
                style: dndFont.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: DropdownButtonFormField<String>(
                key: const Key('alignment_dropdown'),
                value: state.bio!.alignment ?? 'Select an Alignment',
                items: dndAlignments.map((alignment) {
                  return DropdownMenuItem<String>(
                    value: alignment,
                    child: Text(alignment),
                  );
                }).toList(),
                onChanged: state.bioEdit!
                    ? (String? value) {
                        dndAlignment.text = value ?? 'Select an Alignment';
                        context.read<BioCubit>().setBioData(
                              state.bio!.copyWith(alignment: dndAlignment.text),
                            );
                      }
                    : null,
                decoration: dndFieldInputDecoration(enabled: state.bioEdit!, hintText: 'Select an Alignment'),
              ),
            ),
            BigTextBox(
              onTapOutside: (clickOut) => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(languages: languages.text),
                  ),
              onEditingComplete: () => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(languages: languages.text),
                  ),
              enabled: state.bioEdit!,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              controller: languages,
              hintText: 'languages',
              subtitle: 'Languages',
              minLines: 2,
            ),
            BigTextBox(
              onTapOutside: (clickOut) => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(personality: personality.text),
                  ),
              onEditingComplete: () => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(personality: personality.text),
                  ),
              enabled: state.bioEdit!,
              controller: personality,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              hintText: 'Personality',
              subtitle: 'Personality + Traits',
              minLines: 5,
            ),
            BigTextBox(
              onTapOutside: (clickOut) => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(bonds: bonds.text),
                  ),
              onEditingComplete: () => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(bonds: bonds.text),
                  ),
              enabled: state.bioEdit!,
              controller: bonds,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              hintText: 'e.g. Bound to ____ Group by Honor',
              subtitle: 'Bonds',
              minLines: 5,
            ),
            BigTextBox(
              onTapOutside: (clickOut) => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(flaws: flaws.text),
                  ),
              onEditingComplete: () => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(flaws: flaws.text),
                  ),
              enabled: state.bioEdit!,
              controller: flaws,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              hintText: 'e.g. Kleptomaniac',
              subtitle: 'Flaws',
              minLines: 5,
            ),
            BigTextBox(
              onTapOutside: (clickOut) => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(background: background.text),
                  ),
              onEditingComplete: () => context.read<BioCubit>().setBioData(
                    state.bio!.copyWith(background: background.text),
                  ),
              enabled: state.bioEdit!,
              controller: background,
              padding: const EdgeInsets.all(6),
              hintText: 'bio',
              subtitle: 'Bio/Background',
              minLines: 30,
            ),
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
    return BlocBuilder<BioCubit, BioState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<BioCubit>().bioEdit(!state.bioEdit!);
                  },
                  icon: const Icon(
                    Icons.edit,
                  ),
                ),
                SelectableText(
                  !state.bioEdit! ? 'Enable Edit' : 'Disable Edit',
                  style: dndFont.copyWith(color: state.bioEdit! ? black : disableGrey),
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
