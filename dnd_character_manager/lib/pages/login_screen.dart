import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:dnd_character_manager/cubits/character_cubit/character_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharacterCubit, CharacterState>(
      listener: (context, state) => _listener(state, context),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'D&D Character Manager',
              style: dndFont.copyWith(color: white),
            ),
            centerTitle: true,
            backgroundColor: blueGrey,
          ),
          body: state.signedIn! ? const _SignIn() : const _SignUp(),
        );
      },
    );
  }

  void _listener(CharacterState state, BuildContext context) {
    if (state.signedIn ?? false) {
      context.go('/character_select');
    }
  }
}

class _SignIn extends StatelessWidget {
  const _SignIn();

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Form(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextBox(
              padding: const EdgeInsets.all(6),
              controller: email,
              hintText: 'email',
              subtitle: 'Sign In with Email',
            ),
            CustomTextBox(
              padding: const EdgeInsets.all(6),
              controller: password,
              hintText: 'password',
              subtitle: 'Enter Password',
            ),
            TextButton(
              onPressed: () {
                context.read<CharacterCubit>().signIn(email.text, password.text);
              },
              child: Text(
                'Sign In',
                style: dndFont.copyWith(fontSize: 16),
              ),
            ),
            TextButton(
                onPressed: () => _onPressSignUp(context),
                child: Text(
                  'No Account yet? Sign Up',
                  style: dndFont.copyWith(fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }

  _onPressSignUp(BuildContext context) => context.read<CharacterCubit>().signOut();
}

class _SignUp extends StatelessWidget {
  const _SignUp();

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Form(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextBox(
              padding: const EdgeInsets.all(6),
              controller: email,
              hintText: 'email',
              subtitle: 'Sign Up with Email',
            ),
            CustomTextBox(
              padding: const EdgeInsets.all(6),
              controller: password,
              hintText: 'password',
              subtitle: 'Enter New Password',
            ),
            TextButton(
              onPressed: () {
                context.read<CharacterCubit>().signUp(email.text, password.text);
              },
              child: Text(
                'Sign Up',
                style: dndFont.copyWith(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
