import 'package:homeBrewed/constants/spacing.dart';
import 'package:homeBrewed/constants/screen_wrapper.dart';
import 'package:homeBrewed/constants/theme_data.dart';
import 'package:homeBrewed/cubits/bio_cubit/cubit/bio_cubit.dart';
import 'package:homeBrewed/cubits/user_cubit/user_cubit.dart';
import 'package:homeBrewed/pages/add_popups/add_dnd_character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:homeBrewed/pages/character_viewer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) => _listener(state, context),
      builder: (context, userState) {
        return ScreenWrapper(
          title: 'homeBrewed',
          child: CustomTab(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  seperation,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SelectableText(
                        userState.myUser!.email,
                        style: TextStyle(color: black),
                      ),
                      SizedBox(width: 150),
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
                  SizedBox(height: 50),
                  _CharacterList(userState: userState),
                  SizedBox(height: 50),
                  const _AddCharacter(),
                  SizedBox(height: 450),
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
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: themeColor,
          title: Container(
            color: backgroundColor,
            key: const Key('edit_container'),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: const AddDndCharacterScreen(),
          ),
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
      backgroundColor: themeColor,
      surfaceTintColor: themeColor,
      actions: [
        TextButton(
          child: Text(
            'No, keep my character',
            style: TextStyle(color: white),
          ),
          onPressed: () => context.pop(),
        ),
        TextButton(
          child: Text(
            'Delete Permanently',
            style: TextStyle(color: white),
          ),
          onPressed: () {
            context.read<BioCubit>().deleteCharacterByCharID(charID).then((result) {
              if (context.mounted) {
                context.read<BioCubit>().readBiosByUserID(userID);
                context.pop();
              }
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
        List<Widget> bios = bioState.bios.map(
          (bio) {
            return SizedBox(
              width: 400,
              child: Padding(
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
                      style: dndFont.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: black),
                    ),
                    subtitle: Text(
                      '${bio.race ?? ''} | ${bio.dndClass ?? ''}',
                      style: dndFont.copyWith(fontSize: 16, fontStyle: FontStyle.italic, color: black),
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
        height: 55,
        width: 55,
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
          iconSize: 30,
          color: white,
          icon: const Icon(Icons.add),
          onPressed: () => _showEditPanel(context),
        ),
      ),
    );
  }
}
