import 'package:dnd_character_manager/cubits/bio_cubit/cubit/bio_cubit.dart';
import 'package:dnd_character_manager/cubits/user_cubit/user_cubit.dart';
import 'package:dnd_character_manager/cubits/notes_cubit/cubit/notes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/stat_cubit/cubit/stat_cubit.dart';

class DndBlocProvider extends StatelessWidget {
  final Widget child;
  const DndBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => UserCubit()),
      BlocProvider(create: (context) => BioCubit()),
      BlocProvider(create: (context) => StatCubit()),
      BlocProvider(create: (context) => NotesCubit()),
    ], child: child);
  }
}
