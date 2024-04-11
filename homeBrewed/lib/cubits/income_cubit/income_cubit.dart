import 'package:bloc/bloc.dart';
import 'package:dnd_character_manager/models/income.dart';
import 'package:dnd_character_manager/service/dnd_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'income_state.dart';

class IncomeCubit extends Cubit<IncomeState> {
  final DndService dndService;

  IncomeCubit({DndService? dndService})
      : dndService = dndService ?? DndService(),
        super(
          IncomeInitial(),
        );

  Future<void> setIncomesData(Income income) async {
    await dndService.setIncomesData(income: income);
    emit(state.copyWith(income: income));
  }

  Future<void> readIncomeData(String charID) async {
    final Income income = await dndService.readIncomeData(charID: charID);
    emit(state.copyWith(income: income));
  }

  Future<void> readIncomesByCharID(String? charID) async {
    try {
      final List<Income> incomes = await dndService.readIncomesByCharID(charID: charID);
      emit(state.copyWith(incomes: incomes));
    } catch (e) {
      print('error reading incomes from state');
    }
  }
}
