import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:dnd_character_manager/cubits/income_cubit/income_cubit.dart';
import 'package:dnd_character_manager/cubits/user_cubit/user_cubit.dart';
import 'package:dnd_character_manager/cubits/notes_cubit/cubit/notes_cubit.dart';
import 'package:dnd_character_manager/models/bio.dart';
import 'package:dnd_character_manager/models/income.dart';
import 'package:dnd_character_manager/models/notes.dart';
import 'package:dnd_character_manager/models/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../cubits/bio_cubit/cubit/bio_cubit.dart';
import '../cubits/stat_cubit/cubit/stat_cubit.dart';

class AddDndCharacterScreen extends StatelessWidget {
  const AddDndCharacterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController race = TextEditingController();
    TextEditingController dndClass = TextEditingController();

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        return BlocBuilder<BioCubit, BioState>(
          builder: (context, state) {
            return Form(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    CustomTextBox(
                      padding: const EdgeInsets.all(6),
                      controller: name,
                      hintText: 'Enter Your Character\'s name',
                      subtitle: 'Enter Your Character\'s name',
                      obscureText: false,
                    ),
                    CustomTextBox(
                      padding: const EdgeInsets.all(6),
                      controller: race,
                      hintText: 'Enter Your Character\'s race',
                      subtitle: 'Enter Your Character\'s race',
                      obscureText: false,
                    ),
                    CustomTextBox(
                      padding: const EdgeInsets.all(6),
                      controller: dndClass,
                      hintText: 'Enter Your Character\'s class',
                      subtitle: 'Enter Your Character\'s class',
                      obscureText: false,
                    ),
                    TextButton(
                      onPressed: () => _addCharacter(context, userState, name.text, race.text, dndClass.text),
                      child: Text(
                        'Add Character',
                        style: dndFont,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _addCharacter(BuildContext context, UserState userState, String name, String race, String dndClass) {
    //initialize bio data for new character
    const uuid = Uuid();
    Bio newDndCharacter = Bio(
      charID: uuid.v4(),
      userID: userState.myUser!.userID!,
      race: race,
      name: name,
      dndClass: dndClass,
      alignment: 'Select an Alignment',
    );
    context.read<BioCubit>().setBioData(newDndCharacter);

    //initialize stats for new character
    Stats newStats = Stats(charID: newDndCharacter.charID);
    context.read<StatCubit>().setStatsData(newStats);

    //initialize notes for new character
    Notes newNotes = Notes(charID: newDndCharacter.charID);
    context.read<NotesCubit>().setNotesData(newNotes);
    context.pop();

    //initialize income for new character
    Income newIncomes = Income(
      charID: newDndCharacter.charID,
      gold: '0',
      platinum: '0',
      copper: '0',
      electrum: '0',
      silver: '0',
    );
    context.read<IncomeCubit>().setIncomesData(newIncomes);
  }
}
