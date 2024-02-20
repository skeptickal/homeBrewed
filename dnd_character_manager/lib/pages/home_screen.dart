import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final bool userSignedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'D&D Character Manager',
          style: dndFont.copyWith(color: white),
        ),
        centerTitle: true,
        backgroundColor: blueGrey,
      ),
      body: userSignedIn ? _SignIn() : _SignUp(),
    );
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
              onPressed: () {},
              child: Text(
                'Sign In',
                style: dndFont.copyWith(fontSize: 16),
              ),
            ),
            TextButton(
                onPressed: () {},
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
              onPressed: () {},
              child: Text(
                'Sign In',
                style: dndFont.copyWith(fontSize: 16),
              ),
            ),
            TextButton(
                onPressed: () {},
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
