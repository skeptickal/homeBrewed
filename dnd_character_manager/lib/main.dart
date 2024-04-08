import 'package:dnd_character_manager/client/firebase_client.dart';
import 'package:dnd_character_manager/cubits/user_cubit/user_cubit.dart';
import 'package:dnd_character_manager/dnd_bloc_provider.dart';
import 'package:dnd_character_manager/firebase_options.dart';
import 'package:dnd_character_manager/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseClient().initNotifications();
  runApp(
    DndBlocProvider(
      child: Builder(builder: (context) {
        context.read<UserCubit>().initialize();
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          ),
        );
      }),
    ),
  );
}
