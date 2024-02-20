import 'package:dnd_character_manager/pages/character_select_screen.dart';
import 'package:dnd_character_manager/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/character_select',
      builder: (BuildContext context, GoRouterState state) {
        return const CharacterSelectScreen();
      },
    ),
  ],
);
