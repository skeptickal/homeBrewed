import 'package:homeBrewed/constants/spacing.dart';
import 'package:homeBrewed/constants/screen_wrapper.dart';
import 'package:homeBrewed/constants/theme_data.dart';
import 'package:homeBrewed/cubits/bio_cubit/cubit/bio_cubit.dart';
import 'package:homeBrewed/cubits/user_cubit/user_cubit.dart';
import 'package:homeBrewed/pages/add_popups/add_dnd_character_screen.dart';
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
          title: 'homeBrewed',
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                seperation,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SelectableText(
                        userState.myUser!.email,
                        style: TextStyle(color: black),
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.read<UserCubit>().signOut(),
                      child: Text(
                        'sign out',
                        style: dndFont.copyWith(
                          color: black,
                        ),
                      ),
                    ),
                  ],
                ),
                seperation,
                _CharacterList(userState: userState),
                const _AddCharacter(),
                seperation,
                horizontalLine,
                seperation,
                OutlinedButton(
                    style: ButtonStyle(
                      side: WidgetStateProperty.all(BorderSide(color: themeColor)), // Define border color
                    ),
                    onPressed: () => _onPressedDeleteUser(context, userState),
                    child: const Text(
                      'Delete Account?',
                      style: TextStyle(color: Colors.red),
                    ))
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
          color: backgroundColor,
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
        style: TextStyle(color: white, fontSize: 28),
      ),
      backgroundColor: themeColor,
      surfaceTintColor: themeColor,
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

void _onPressedDeleteUser(BuildContext context, UserState state) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Are you sure you want to delete the account for:\n${state.myUser!.email}?',
        style: TextStyle(color: white, fontSize: 28),
      ),
      backgroundColor: themeColor,
      surfaceTintColor: themeColor,
      actions: [
        TextButton(
          child: Text(
            'Delete Permanently',
            style: TextStyle(color: white),
          ),
          onPressed: () => context.read<UserCubit>().deleteUser(),
        ),
        TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Back',
              style: TextStyle(color: white),
            ))
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
                  border: Border.all(color: themeColor),
                ),
                child: ListTile(
                  onTap: () => context.push('/character_viewer', extra: bio),
                  leading: Icon(
                    Icons.person,
                    color: themeColor,
                  ),
                  title: Text(
                    bio.name ?? '',
                    style: dndFont.copyWith(fontSize: 26, fontWeight: FontWeight.bold, color: black),
                  ),
                  subtitle: Text(
                    '${bio.race ?? ''} | ${bio.dndClass ?? ''}',
                    style: dndFont.copyWith(fontSize: 26, fontStyle: FontStyle.italic, color: black),
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
            SelectableText(
              'Your Characters',
              style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 28, color: black),
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
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: themeColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          iconSize: 25,
          color: white,
          icon: const Icon(Icons.add),
          onPressed: () => _showEditPanel(context),
        ),
      ),
    );
  }
}
