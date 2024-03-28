import 'package:dnd_character_manager/client/spacing.dart';
import 'package:dnd_character_manager/constants/screen_wrapper.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:dnd_character_manager/cubits/character_cubit/character_cubit.dart';
import 'package:dnd_character_manager/pages/add_dnd_character_screen.dart';
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
          List<ListTile> dndCharacters = state.dndCharacters.map(
            (dndCharacter) {
              return ListTile(
                onTap: () => context.push('/character_viewer', extra: dndCharacter),
                leading: const Icon(Icons.person),
                title: Text(
                  '${dndCharacter.name} - ${dndCharacter.dndClass}',
                  style: dndFont,
                ),
                trailing: Text(
                  dndCharacter.race,
                  style: dndFont,
                ),
              );
            },
          ).toList();
          return ScreenWrapper(
            title: 'D&D Character Manager',
            child: SingleChildScrollView(
              child: Column(
                children: [
                  seperation,
                  Text(state.myUser!.email),
                  horizontalLine,
                  ...dndCharacters,
                  IconButton(
                    onPressed: () => _showEditPanel(context),
                    icon: const Icon(Icons.add),
                  ),
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

void _showEditPanel(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          key: const Key('edit_container'),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: const AddDndCharacterScreen(),
        );
      });
}
