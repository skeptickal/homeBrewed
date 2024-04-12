// ignore_for_file: file_names

import 'package:bloc/bloc.dart';
import 'package:homeBrewed/service/dnd_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/dnd_action.dart';

part 'dnd_action_state.dart';

class DndActionCubit extends Cubit<DndActionState> {
  final DndService dndService;

  DndActionCubit({DndService? dndService})
      : dndService = dndService ?? DndService(),
        super(
          DndActionInitial(),
        );

  Future<void> setDndActionsData(DndAction dndAction) async {
    await dndService.setDndActionsData(dndAction: dndAction);
  }

  Future<void> readDndActionsByCharID(String? charID) async {
    try {
      final List<DndAction> dndActions = await dndService.readDndActionsByCharID(charID: charID);
      emit(state.copyWith(dndActions: dndActions));
    } catch (e) {
      print('error reading dndActions from state');
    }
  }

  Future<void> deleteDndActionByDndActionID(String dndActionID) async {
    await dndService.deleteDndActionByDndActionID(dndActionID: dndActionID);
  }
}
