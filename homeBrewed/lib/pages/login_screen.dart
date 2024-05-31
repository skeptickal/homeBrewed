import 'package:homeBrewed/constants/screen_wrapper.dart';
import 'package:homeBrewed/constants/theme_data.dart';
import 'package:homeBrewed/cubits/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) => _listener(state, context),
      builder: (context, state) {
        return ScreenWrapper(
          title: 'Welcome to homeBrewed',
          child: _SignIn(
            state: state,
          ),
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
  final UserState state;
  const _SignIn({required this.state});
  FormGroup buildForm() => fb.group(<String, Object>{
        'email': FormControl<String>(value: ''),
        'password': FormControl<String>(value: ''),
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
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
                    dynamic result = await context.read<UserCubit>().signIn(
                          form.control('email').value,
                          form.control('password').value,
                        );
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
                    style: dndFont.copyWith(fontSize: 16, color: themeColor),
                  ),
                ),
                TextButton(
                    onPressed: () => context.push('/sign_up'),
                    child: Text(
                      'No Account yet? Sign Up',
                      style: dndFont.copyWith(fontSize: 16, color: themeColor),
                    ))
              ],
            );
          }),
    );
  }
}
