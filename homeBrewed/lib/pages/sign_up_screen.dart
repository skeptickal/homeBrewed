import 'package:homeBrewed/constants/screen_wrapper.dart';
import 'package:homeBrewed/constants/text_fields.dart';
import 'package:homeBrewed/constants/theme_data.dart';
import 'package:homeBrewed/cubits/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) => _listener(state, context),
      builder: (context, state) {
        return ScreenWrapper(
          title: 'Register A New Account',
          child: _SignUp(state: state), //body: state.signedIn! ? const _SignIn() : const _SignUp(),
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

class _SignUp extends StatelessWidget {
  final UserState state;
  const _SignUp({required this.state});

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
              obscureText: false,
              padding: const EdgeInsets.all(6),
              controller: email,
              hintText: 'email',
              subtitle: 'Sign Up with Email',
            ),
            Stack(
              children: [
                CustomTextBox(
                  obscureText: state.textObscured!,
                  padding: const EdgeInsets.all(6),
                  controller: password,
                  hintText: 'password',
                  subtitle: 'Enter Password',
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    onPressed: () {
                      context.read<UserCubit>().revealOrHideText();
                    },
                    icon: const Icon(Icons.remove_red_eye),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () async {
                dynamic result = await context.read<UserCubit>().signUp(email.text, password.text);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: SelectableText(result),
                    ),
                  );
                }
              },
              child: Text(
                'Sign Up',
                style: dndFont.copyWith(fontSize: 16, color: themeColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
