import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/cubits/character_cubit/character_cubit.dart';
import 'package:dnd_character_manager/models/character/dnd_character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddDndCharacterScreen extends StatelessWidget {
  const AddDndCharacterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController race = TextEditingController();
    TextEditingController dndClass = TextEditingController();
    return BlocBuilder<CharacterCubit, CharacterState>(
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
                  onPressed: () {
                    DndCharacter newDndCharacter = DndCharacter(
                      userID: state.myUser!.userID!,
                      race: race.text,
                      name: name.text,
                      dndClass: dndClass.text,
                    );
                    context.read<CharacterCubit>().addDndCharacter(newDndCharacter);
                    context.pop();
                  },
                  child: const Text('Add Character'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
