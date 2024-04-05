import 'package:dnd_character_manager/client/spacing.dart';
import 'package:dnd_character_manager/constants/screen_wrapper.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:dnd_character_manager/cubits/bio_cubit/cubit/bio_cubit.dart';
import 'package:dnd_character_manager/cubits/user_cubit/user_cubit.dart';
import 'package:dnd_character_manager/pages/add_dnd_character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) => _listener(state, context),
      builder: (context, userState) {
        return ScreenWrapper(
          title: 'D&D Character Manager',
          child: SingleChildScrollView(
            child: Column(
              children: [
                seperation,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(userState.myUser!.email),
                    ),
                    TextButton(
                      onPressed: () => context.read<UserCubit>().signOut(),
                      child: Text(
                        'sign out',
                        style: dndFont.copyWith(
                          color: blueGrey,
                        ),
                      ),
                    ),
                  ],
                ),
                seperation,
                _CharacterList(userState: userState),
                const _AddCharacter(),
              ],
            ),
          ),
        );
      },
    );
  }

  void _listener(UserState state, BuildContext context) {
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

void _onPressedDeleteIcon(BuildContext context, String userID, String charID, String name) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Are you sure you want to delete $name?',
        style: TextStyle(color: white, fontSize: 18),
      ),
      backgroundColor: blueGrey,
      surfaceTintColor: blueGrey,
      actions: [
        TextButton(
          child: Text(
            'Delete Permanently',
            style: TextStyle(color: white),
          ),
          onPressed: () {
            context.read<BioCubit>().deleteCharacterByCharID(charID).then((result) {
              context.read<BioCubit>().readBiosByUserID(userID);
              context.pop();
            });
          },
        ),
      ],
    ),
  );
}

class _CharacterList extends StatelessWidget {
  final UserState userState;
  const _CharacterList({required this.userState});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BioCubit, BioState>(
      builder: (context, bioState) {
        context.read<BioCubit>().readBiosByUserID(userState.myUser!.userID);
        List<Padding> bios = bioState.bios.map(
          (bio) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: blueGrey), // Border properties
                ),
                child: ListTile(
                  onTap: () => context.push('/character_viewer', extra: bio),
                  leading: Icon(
                    Icons.person,
                    color: blueGrey,
                  ),
                  title: Text(
                    bio.name ?? '',
                    style: dndFont.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${bio.race ?? ''} | ${bio.dndClass ?? ''}',
                    style: dndFont.copyWith(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_forever_outlined,
                      color: black,
                    ),
                    onPressed: () => _onPressedDeleteIcon(context, userState.myUser!.userID!, bio.charID!, bio.name!),
                  ),
                ),
              ),
            );
          },
        ).toList();
        return Column(
          children: [
            Text(
              'Your Characters',
              style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            ...bios,
          ],
        );
      },
    );
  }
}

class _AddCharacter extends StatelessWidget {
  const _AddCharacter();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showEditPanel(context),
      icon: const Icon(
        Icons.add,
        size: 30,
      ),
    );
  }
}
