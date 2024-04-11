// ignore_for_file: file_names

part of 'dnd_action_cubit.dart';

@immutable
class DndActionState extends Equatable {
  final List<DndAction>? dndActions;

  const DndActionState({
    required this.dndActions,
  });

  DndActionState copyWith({dndActions, currentSelectedDndAction}) {
    return DndActionState(dndActions: dndActions ?? this.dndActions);
  }

  @override
  List<Object?> get props => [dndActions];
}

final class DndActionInitial extends DndActionState {
  DndActionInitial()
      : super(
          dndActions: [],
        );
}
