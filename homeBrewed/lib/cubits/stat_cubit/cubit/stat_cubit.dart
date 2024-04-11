import 'package:bloc/bloc.dart';
import 'package:dnd_character_manager/service/dnd_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../models/stats.dart';

part 'stat_state.dart';

class StatCubit extends Cubit<StatState> {
  final DndService dndService;

  StatCubit({DndService? dndService})
      : dndService = dndService ?? DndService(),
        super(StatInitial());

  Future<void> statEdit(bool statEdit) async {
    emit(state.copyWith(statEdit: statEdit));
  }

  Future<void> readStatsData(String charID) async {
    final Stats stats = await dndService.readStatsData(charID: charID);
    emit(state.copyWith(stats: stats));
  }

  Future<void> setStatsData(Stats stats) async {
    emit(state.copyWith(stats: stats, statsList: [...state.statsList, stats]));
    await dndService.setStatsData(stats: stats);
  }

  // Future<void> readBiosByUserID(String? userID) async {
  //   try {
  //     final List<Bio> bios = await dndService.readBiosUserID(userID: userID);
  //     emit(state.copyWith(bios: bios));
  //     print('bios state on cubit: $bios');
  //   } catch (e) {
  //     print('error reading characters from state');
  //   }
  // }
}
