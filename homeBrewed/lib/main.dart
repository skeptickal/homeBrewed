//import 'package:homeBrewed/client/firebase_client.dart';
import 'package:homeBrewed/cubits/user_cubit/user_cubit.dart';
import 'package:homeBrewed/dnd_bloc_provider.dart';
import 'package:homeBrewed/firebase_options.dart';
import 'package:homeBrewed/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //await FirebaseClient().initNotifications();
  runApp(
    DndBlocProvider(
      child: Builder(builder: (context) {
        context.read<UserCubit>().initialize();
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1),
          ),
          child: MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
          ),
        );
      }),
    ),
  );
}
// version 2
//figure out horizontal mode? Or force into vert?