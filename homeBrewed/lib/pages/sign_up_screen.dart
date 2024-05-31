import 'package:homeBrewed/constants/screen_wrapper.dart';
import 'package:homeBrewed/constants/theme_data.dart';
import 'package:homeBrewed/cubits/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
  FormGroup buildForm() => fb.group(<String, Object>{
        'email': FormControl<String>(value: ''),
        'password': FormControl<String>(value: ''),
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: ReactiveFormBuilder(
          form: buildForm,
          builder: (context, form, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ReactiveTextField<String>(
                  formControlName: 'email',
                  decoration: InputDecoration(labelText: 'Email', labelStyle: dndFont),
                ),
                Stack(
                  children: [
                    ReactiveTextField<String>(
                      obscureText: state.textObscured!,
                      formControlName: 'password',
                      decoration: InputDecoration(labelText: 'Password', labelStyle: dndFont),
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
                    dynamic result = await context.read<UserCubit>().signUp(
                          form.control('email').value,
                          form.control('password').value,
                        );
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
            );
          }),
    );
  }
}
