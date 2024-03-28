import 'package:dnd_character_manager/models/character/dnd_character.dart';
import 'package:dnd_character_manager/pages/character_viewer_screen.dart';
import 'package:dnd_character_manager/pages/home_screen.dart';
import 'package:dnd_character_manager/pages/login_screen.dart';
import 'package:dnd_character_manager/pages/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

late DndCharacter dndCharacter;

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/character_select',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/sign_up',
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpScreen();
      },
    ),
    GoRoute(
      path: '/character_viewer',
      builder: (BuildContext context, GoRouterState state) {
        DndCharacter dndCharacter = state.extra as DndCharacter;
        return CharacterViewerScreen(dndCharacter: dndCharacter);
      },
    ),
  ],
);
