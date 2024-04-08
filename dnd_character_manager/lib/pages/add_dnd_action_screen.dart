import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubits/action_cubit/dndAction_cubit.dart';

import '../models/dnd_action.dart';

class AddDndActionScreen extends StatelessWidget {
  final DndAction dndAction;
  const AddDndActionScreen({super.key, required this.dndAction});

  @override
  Widget build(BuildContext context) {
    print('Jeff ${dndAction.dndActionID}');
    TextEditingController name = TextEditingController(text: dndAction.name);

    TextEditingController description = TextEditingController(text: dndAction.description);

    return BlocBuilder<DndActionCubit, DndActionState>(
      builder: (context, state) {
        return Form(
          child: SingleChildScrollView(
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
                  hintText: 'e.g. Divine Sense',
                  subtitle: 'Action name',
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
                  hintText: 'The presence of strong evil\n registers'
                      'on your senses like a\n noxious odor, and powerful\n good '
                      'rings like heavenly music in your ears. As an action, '
                      'you can open your awareness to detect such forces. Until '
                      'the end of your next turn, you know the location of any '
                      'celestial, fiend, or undead within 60 feet of you that is '
                      'not behind total cover. You know the type (celestial, '
                      'fiend, or undead) of any being whose presence you sense, '
                      'but not its identity (the vampire Count Strahd von Zarovich,'
                      ' for instance). Within the same radius, you also detect '
                      ' the presence of any place or object that has been '
                      ' consecrated or desecrated, as with the Hallow spell.'
                      'You can use this feature a number of times equal to 1'
                      '+ your Charisma modifier. When you finish a long rest, '
                      'you regain all expended uses.,',
                  subtitle: 'Description (Optional)',
                  minLines: 5,
                ),
                TextButton(
                  onPressed: () {
                    context.read<DndActionCubit>().readDndActionsByCharID(dndAction.charID);
                    context.pop();
                  },
                  child: Text(
                    'Add Action',
                    style: dndFont,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<DndActionCubit>().deleteDndActionByDndActionID(dndAction.dndActionID!);
                    context.pop();
                  },
                  child: Text(
                    'Cancel',
                    style: dndFont,
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
