import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../constants/spacing.dart';
import '../../constants/theme_data.dart';
import '../../cubits/action_cubit/dnd_action_cubit.dart';
import '../../models/dnd_action.dart';
import '../add_popups/add_dnd_action_screen.dart';
import '../edit_popups/edit_dnd_action_screen.dart';

class DndActionsTab extends StatelessWidget {
  final String charID;
  const DndActionsTab({super.key, required this.charID});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          _DndActionsList(charID: charID),
          seperation,
          _AddDndAction(charID: charID),
        ],
      ),
    );
  }
}

class _DndActionsList extends StatelessWidget {
  final String? charID;
  const _DndActionsList({required this.charID});

  @override
  Widget build(BuildContext context) {
    context.read<DndActionCubit>().readDndActionsByCharID(charID);
    return BlocBuilder<DndActionCubit, DndActionState>(
      builder: (context, state) {
        List<Padding> dndActions = state.dndActions!.map(
          (dndAction) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: themeColor), borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  onTap: () => _onPressedTile(context: context, description: dndAction.description ?? '', name: dndAction.name ?? ''),
                  leading: IconButton(
                    onPressed: () {
                      _showPostEditPanel(context, dndAction);
                    },
                    icon: const FaIcon(FontAwesomeIcons.exclamation),
                  ),
                  title: Text(
                    dndAction.name ?? '',
                    style: dndFont.copyWith(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_forever_outlined,
                      color: black,
                    ),
                    onPressed: () => _onPressedDeleteIcon(
                      context: context,
                      dndActionID: dndAction.dndActionID!,
                      name: dndAction.name!,
                      charID: charID!,
                    ),
                  ),
                ),
              ),
            );
          },
        ).toList();
        return Column(children: [
          seperation,
          SelectableText(
            'Actions',
            style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          seperation,
          ...dndActions
        ]);
      },
    );
  }
}

void _onPressedDeleteIcon({required BuildContext context, required String dndActionID, required String name, required String charID}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Are you sure you want to delete $name?',
        style: TextStyle(color: white, fontSize: 28),
      ),
      backgroundColor: themeColor,
      surfaceTintColor: themeColor,
      actions: [
        TextButton(
          child: Text(
            'Delete Permanently',
            style: TextStyle(color: white),
          ),
          onPressed: () {
            context.read<DndActionCubit>().deleteDndActionByDndActionID(dndActionID).then((result) {
              context.read<DndActionCubit>().readDndActionsByCharID(charID);
              context.pop();
            });
          },
        ),
      ],
    ),
  );
}

void _onPressedTile({required BuildContext context, required String name, required String description}) {
  showDialog(
    context: context,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Column(
            children: [
              SelectableText(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, color: white, fontWeight: FontWeight.bold),
              ),
              seperation,
              SelectableText(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, color: white, fontStyle: FontStyle.italic),
              )
            ],
          ),
          backgroundColor: themeColor,
          surfaceTintColor: themeColor,
          actions: [
            TextButton(
              child: Text(
                'Back',
                style: TextStyle(color: white),
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    ),
  );
}

class _AddDndAction extends StatelessWidget {
  final String charID;
  const _AddDndAction({required this.charID});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: themeColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          iconSize: 25,
          color: white,
          icon: const Icon(Icons.add),
          onPressed: () => _showEditPanel(context, charID),
        ),
      ),
    );
  }
}

void _showEditPanel(BuildContext context, String charID) {
  const uuid = Uuid();
  DndAction dndAction = DndAction(charID: charID, dndActionID: uuid.v4());
  context.read<DndActionCubit>().setDndActionsData(dndAction);
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              title: AddDndActionScreen(dndAction: dndAction),
              backgroundColor: backgroundColor,
              surfaceTintColor: backgroundColor,
            ),
          ),
        );
      });
}

void _showPostEditPanel(BuildContext context, DndAction dndAction) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: backgroundColor,
          surfaceTintColor: backgroundColor,
          title: EditDndActionScreen(dndAction: dndAction),
        ),
      ),
    ),
  );
}
