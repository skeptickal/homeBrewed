import 'package:dnd_character_manager/constants/screen_wrapper.dart';
import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:dnd_character_manager/cubits/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) => _listener(state, context),
      builder: (context, state) {
        return const ScreenWrapper(
          title: 'Welcome',
          child: _SignIn(), //body: state.signedIn! ? const _SignIn() : const _SignUp(),
        );
      },
    );
  }

  void _listener(UserState state, BuildContext context) {
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
              validator: (value) {
                value!.isEmpty ? 'Enter an email' : null;
                return value;
              },
              obscureText: false,
              padding: const EdgeInsets.all(6),
              controller: email,
              hintText: 'email',
              subtitle: 'Sign In with Email',
            ),
            CustomTextBox(
              obscureText: true,
              padding: const EdgeInsets.all(6),
              controller: password,
              hintText: 'password',
              subtitle: 'Enter Password',
            ),
            TextButton(
              onPressed: () async {
                dynamic result = await context.read<UserCubit>().signIn(email.text, password.text);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result),
                    ),
                  );
                }
              },
              child: Text(
                'Sign In',
                style: dndFont.copyWith(fontSize: 16),
              ),
            ),
            TextButton(
                onPressed: () => context.push('/sign_up'),
                child: Text(
                  'No Account yet? Sign Up',
                  style: dndFont.copyWith(fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
