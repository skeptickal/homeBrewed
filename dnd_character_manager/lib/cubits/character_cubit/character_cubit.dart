import 'package:bloc/bloc.dart';
import 'package:dnd_character_manager/service/dnd_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final DndService dndService;

  CharacterCubit({DndService? dndService})
      : dndService = dndService ?? DndService(),
        super(const CharacterInitial());

  Future<void> signIn(bool signedIn) async {
    emit(state.copyWith(signedIn: signedIn));
  }
}
