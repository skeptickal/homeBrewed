import 'package:dnd_character_manager/cubits/notes_cubit/cubit/notes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../client/spacing.dart';
import '../../constants/text_fields.dart';
import '../../constants/theme_data.dart';

class NotesTab extends StatelessWidget {
  final String charID;
  const NotesTab({super.key, required this.charID});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
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
                Text(
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
        TextEditingController notes = TextEditingController();
        notes.text = state.notes!.notes ?? '';
        return BigTextBox(
          onEditingComplete: () => context.read<NotesCubit>().setNotesData(state.notes!.copyWith(notes: notes.text)),
          onTapOutside: (clickOut) => context.read<NotesCubit>().setNotesData(state.notes!.copyWith(notes: notes.text)),
          minLines: 50,
          enabled: state.notesEdit!,
          padding: const EdgeInsets.all(6),
          controller: notes,
          hintText: 'e.g. Random Shopkeep\'s name is Gorgug',
          subtitle: 'Campaign Notes',
        );
      },
    );
  }
}
