import 'package:dnd_character_manager/models/my_user/my_user_repo.dart';
import 'package:flutter/material.dart';

class CharacterSelectScreen extends StatelessWidget {
  final MyUserRepository myUserRepository;
  const CharacterSelectScreen(this.myUserRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DND Character Selection'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Character',
            ),
          ],
        ),
      ),
    );
  }
}
