import 'package:homeBrewed/cubits/notes_cubit/cubit/notes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/spacing.dart';
import '../../constants/text_fields.dart';
import '../../constants/theme_data.dart';

class NotesTab extends StatelessWidget {
  final String charID;
  const NotesTab({super.key, required this.charID});

  @override
  Widget build(BuildContext context) {
    context.read<NotesCubit>().readNotesData(charID);
    return const SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          _EditBlock(),
          _NotesBox(),
          _EditBlock(),
        ],
      ),
    );
  }
}

class _EditBlock extends StatelessWidget {
  const _EditBlock();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<NotesCubit>().notesEdit(!state.notesEdit!);
                  },
                  icon: const Icon(
                    Icons.edit,
                  ),
                ),
                SelectableText(
                  !state.notesEdit! ? 'Enable Edit' : 'Disable Edit',
                  style: dndFont.copyWith(color: state.notesEdit! ? black : disableGrey),
                ),
              ],
            ),
            seperation,
          ],
        );
      },
    );
  }
}

class _NotesBox extends StatelessWidget {
  const _NotesBox();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        TextEditingController notesController = TextEditingController();
        notesController.text = state.notes!.notes ?? '';
        return BigTextBox(
          onEditingComplete: () => context.read<NotesCubit>().setNotesData(state.notes!.copyWith(notes: notesController.text)),
          onTapOutside: (clickOut) => context.read<NotesCubit>().setNotesData(state.notes!.copyWith(notes: notesController.text)),
          minLines: 50,
          enabled: state.notesEdit!,
          padding: const EdgeInsets.all(6),
          controller: notesController,
          hintText: 'e.g. Random Shopkeep\'s name is Gorgug',
          subtitle: 'Campaign Notes',
        );
      },
    );
  }
}
