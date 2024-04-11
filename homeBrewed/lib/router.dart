import 'package:dnd_character_manager/models/bio.dart';
import 'package:dnd_character_manager/pages/character_viewer_screen.dart';
import 'package:dnd_character_manager/pages/edit_popups/edit_weapon_screen.dart';
import 'package:dnd_character_manager/pages/home_screen.dart';
import 'package:dnd_character_manager/pages/login_screen.dart';
import 'package:dnd_character_manager/pages/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'models/weapon.dart';

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
        Bio dndCharacter = state.extra as Bio;
        return CharacterViewerScreen(bio: dndCharacter);
      },
    ),
    GoRoute(
      path: '/edit_weapon',
      builder: (BuildContext context, GoRouterState state) {
        Weapon weapon = state.extra as Weapon;
        return EditWeaponScreen(weapon: weapon);
      },
    ),
  ],
);
