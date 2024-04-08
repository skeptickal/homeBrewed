import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubits/action_cubit/dndAction_cubit.dart';
import '../models/dnd_action.dart';

class EditDndActionScreen extends StatelessWidget {
  final DndAction dndAction;
  const EditDndActionScreen({super.key, required this.dndAction});

  @override
  Widget build(BuildContext context) {
    print('Jeff ${dndAction.dndActionID}');
    TextEditingController name = TextEditingController(text: dndAction.name);
    TextEditingController description = TextEditingController(text: dndAction.description);

    return BlocBuilder<DndActionCubit, DndActionState>(
      builder: (context, state) {
        return Form(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                BigTextBox(
                  onTapOutside: (clickOut) {
                    context.read<DndActionCubit>().setDndActionsData(dndAction.copyWith(
                          name: name.text,
                          description: description.text,
                        ));
                    context.read<DndActionCubit>().readDndActionsByCharID(dndAction.charID);
                  },
                  onEditingComplete: () {
                    context.read<DndActionCubit>().setDndActionsData(dndAction.copyWith(
                          name: name.text,
                          description: description.text,
                        ));
                    context.read<DndActionCubit>().readDndActionsByCharID(dndAction.charID);
                  },
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: name,
                  hintText: 'DndAction name',
                  subtitle: 'DndAction name',
                ),
                BigTextBox(
                  onTapOutside: (clickOut) {
                    context.read<DndActionCubit>().setDndActionsData(dndAction.copyWith(
                          name: name.text,
                          description: description.text,
                        ));
                    context.read<DndActionCubit>().readDndActionsByCharID(dndAction.charID);
                  },
                  onEditingComplete: () {
                    context.read<DndActionCubit>().setDndActionsData(dndAction.copyWith(
                          name: name.text,
                          description: description.text,
                        ));
                    context.read<DndActionCubit>().readDndActionsByCharID(dndAction.charID);
                  },
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: description,
                  hintText: 'Has a chance to burn target',
                  subtitle: 'Description (Optional)',
                  minLines: 5,
                ),
                TextButton(
                  onPressed: () {
                    context.read<DndActionCubit>().readDndActionsByCharID(dndAction.charID);
                    context.pop();
                  },
                  child: Text(
                    'Done Editing',
                    style: dndFont.copyWith(color: black),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
