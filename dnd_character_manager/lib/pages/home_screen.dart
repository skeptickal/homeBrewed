import 'package:dnd_character_manager/constants/screen_wrapper.dart';
import 'package:dnd_character_manager/cubits/character_cubit/character_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharacterCubit, CharacterState>(
        listener: (context, state) => _listener(state, context),
        builder: (context, state) {
          context.read<CharacterCubit>().readCharactersByUserID(state.myUser!.userID);
          List<ListTile> dndCharacters = state.dndCharacters!.map(
            (dndCharacter) {
              return ListTile(
                key: const Key('dnd_character_tiles'),
                leading: Text(dndCharacter.dndClass),
                title: Text(dndCharacter.name),
                trailing: Text(dndCharacter.race),
               );
            },
          ).toList();
          return ScreenWrapper(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...dndCharacters,
                  Center(
                    child: TextButton(
                      onPressed: () => context.read<CharacterCubit>().signOut(),
                      child: const Text('sign out'),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _listener(CharacterState state, BuildContext context) {
    if (state.signedIn == false) {
      context.go('/');
    }
  }
}
