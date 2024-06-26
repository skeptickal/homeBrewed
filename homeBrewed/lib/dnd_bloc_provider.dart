import 'package:homeBrewed/cubits/action_cubit/dnd_action_cubit.dart';
import 'package:homeBrewed/cubits/bio_cubit/cubit/bio_cubit.dart';
import 'package:homeBrewed/cubits/income_cubit/income_cubit.dart';
import 'package:homeBrewed/cubits/item_cubit/item_cubit.dart';
import 'package:homeBrewed/cubits/resource_cubit/resource_cubit.dart';
import 'package:homeBrewed/cubits/user_cubit/user_cubit.dart';
import 'package:homeBrewed/cubits/notes_cubit/cubit/notes_cubit.dart';
import 'package:homeBrewed/cubits/weapon_cubit/weapon_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/spell_cubit/spell_cubit.dart';
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
      BlocProvider(create: (context) => WeaponCubit()),
      BlocProvider(create: (context) => ResourceCubit()),
      BlocProvider(create: (context) => SpellCubit()),
      BlocProvider(create: (context) => DndActionCubit()),
      BlocProvider(create: (context) => ItemCubit()),
      BlocProvider(create: (context) => IncomeCubit()),
    ], child: child);
  }
}
