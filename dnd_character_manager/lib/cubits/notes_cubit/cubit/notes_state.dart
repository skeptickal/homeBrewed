part of 'notes_cubit.dart';

@immutable
class NotesState extends Equatable {
  final Notes? notes;
  final bool? notesEdit;
  final List<Notes> notesList;

  const NotesState({this.notes, this.notesEdit, required this.notesList});

  NotesState copyWith({notes, notesEdit, notesList}) {
    return NotesState(notes: notes ?? this.notes, notesEdit: notesEdit ?? this.notesEdit, notesList: notesList ?? this.notesList);
  }

  @override
  List<Object?> get props => [notes, notesEdit, notesList];
}

final class NotesInitial extends NotesState {
  NotesInitial()
      : super(
          notesList: [
            const Notes(charID: '1234567', notes: ''),
          ],
          notes: const Notes(charID: '1234567', notes: ''),
          notesEdit: false,
        );
}
