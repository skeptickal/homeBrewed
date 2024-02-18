import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DndBlocProvider extends StatelessWidget {
  final Widget child;
  const DndBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: const [], child: child);
  }
}
