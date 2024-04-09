import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../cubits/action_cubit/dndAction_cubit.dart';
import '../../models/dnd_action.dart';

class EditDndActionScreen extends StatelessWidget {
  final DndAction dndAction;

  const EditDndActionScreen({Key? key, required this.dndAction}) : super(key: key);
  FormGroup buildForm() => fb.group(<String, Object>{
        'name': FormControl<String>(value: dndAction.name),
        'description': FormControl<String>(value: dndAction.description),
      });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DndActionCubit, DndActionState>(
      builder: (context, state) {
        return ReactiveFormBuilder(
          form: buildForm,
          builder: (context, formGroup, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ReactiveTextField<String>(
                    formControlName: 'name',
                    decoration: InputDecoration(labelText: 'Action', labelStyle: dndFont),
                  ),
                  ReactiveTextField<String>(
                    minLines: 1,
                    maxLines: 10,
                    formControlName: 'description',
                    decoration: InputDecoration(labelText: 'Description', labelStyle: dndFont),
                  ),
                  TextButton(
                    onPressed: () {
                      DndAction updatedDndAction = DndAction(
                        dndActionID: dndAction.dndActionID,
                        charID: dndAction.charID,
                        name: formGroup.control('name').value,
                        description: formGroup.control('description').value,
                      );

                      context.read<DndActionCubit>().setDndActionsData(updatedDndAction);
                      context.read<DndActionCubit>().readDndActionsByCharID(dndAction.charID);
                      context.pop();
                    },
                    child: Text(
                      'Save DndAction',
                      style: dndFont.copyWith(color: themeColor),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
