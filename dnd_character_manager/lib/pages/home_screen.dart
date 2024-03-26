
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
