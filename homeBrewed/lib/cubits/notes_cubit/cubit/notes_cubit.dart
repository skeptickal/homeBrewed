import 'package:bloc/bloc.dart';
import 'package:homeBrewed/service/dnd_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../models/notes.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final DndService dndService;

  NotesCubit({DndService? dndService})
      : dndService = dndService ?? DndService(),
        super(NotesInitial());

  Future<void> notesEdit(bool notesEdit) async {
    emit(state.copyWith(notesEdit: notesEdit));
  }

  Future<void> readNotesData(String charID) async {
    final Notes notes = await dndService.readNotesData(charID: charID);
    emit(state.copyWith(notes: notes));
  }

  Future<void> setNotesData(Notes notes) async {
    emit(state.copyWith(notes: notes, notesList: [...state.notesList, notes]));
    await dndService.setNotesData(notes: notes);
  }
}
