import 'package:carousel_slider/carousel_slider.dart';
import 'package:dnd_character_manager/constants/screen_wrapper.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:dnd_character_manager/cubits/character_cubit/character_cubit.dart';
import 'package:dnd_character_manager/pages/add_dnd_character.dart';
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(state.myUser!.email),
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
                  Container(
                    width: MediaQuery.of(context).size.width * .9,
                    height: MediaQuery.of(context).size.height * .5,
                    decoration: BoxDecoration(border: Border.all(color: black)),
                    child: CarouselSlider(
                      items: const [
                        Center(
                            child: Text(
                          'CORE STATS\n\nSTR 20\nDEX 20\nCON 20\nINT 20\nWIS 20\nCHAR 20',
                          textAlign: TextAlign.center,
                        )),
                        SingleChildScrollView(
                          child: Center(
                            child: Text(
                              'BIO \n\n\n he was a smol boi, but he grew \n he is 30 yr old \n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\nhi this is a new line',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        height: MediaQuery.of(context).size.height * .5,
                        enableInfiniteScroll: false,
                      ),
                    ),
                  )
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
      context: context,
      builder: (context) {
        return Container(
          key: const Key('edit_container'),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          color: white,
          child: const AddDndCharacter(),
        );
      });
}
