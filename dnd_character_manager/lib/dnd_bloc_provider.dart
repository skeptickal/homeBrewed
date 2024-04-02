import 'package:dnd_character_manager/cubits/bio_cubit/cubit/bio_cubit.dart';
import 'package:dnd_character_manager/cubits/character_cubit/character_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DndBlocProvider extends StatelessWidget {
  final Widget child;
  const DndBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => CharacterCubit()),
      BlocProvider(create: (context) => BioCubit()),
    ], child: child);
  }
}
