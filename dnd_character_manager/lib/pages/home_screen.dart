import 'package:dnd_character_manager/client/spacing.dart';
import 'package:dnd_character_manager/constants/screen_wrapper.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:dnd_character_manager/cubits/bio_cubit/cubit/bio_cubit.dart';
import 'package:dnd_character_manager/cubits/character_cubit/user_cubit.dart';
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
        return BlocBuilder<BioCubit, BioState>(builder: (context, bioState) {
          context.read<BioCubit>().readBiosByUserID(userState.myUser!.userID);
          print('bios state ${bioState.bios}');
          List<ListTile> bios = bioState.bios.map(
            (bio) {
              return ListTile(
                onTap: () => context.push('/character_viewer', extra: bio),
                leading: const Icon(Icons.person),
                title: Text(
                  '${bio.name ?? ''} - ${bio.dndClass ?? ''}',
                  style: dndFont,
                ),
                trailing: Text(
                  bio.race ?? '',
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
                  Text(userState.myUser!.email),
                  horizontalLine,
                  ...bios,
                  IconButton(
                    onPressed: () => _showEditPanel(context),
                    icon: const Icon(Icons.add),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () => context.read<UserCubit>().signOut(),
                      child: const Text('sign out'),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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
