import 'package:bloc/bloc.dart';
import 'package:dnd_character_manager/service/dnd_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/spell.dart';

part 'spell_state.dart';

class SpellCubit extends Cubit<SpellState> {
  final DndService dndService;

  SpellCubit({DndService? dndService})
      : dndService = dndService ?? DndService(),
        super(
          SpellInitial(),
        );

  Future<void> setSpellsData(Spell spell) async {
    await dndService.setSpellsData(spell: spell);
  }

  Future<void> readSpellsByCharID(String? charID) async {
    try {
      final List<Spell> spells = await dndService.readSpellsByCharID(charID: charID);
      emit(state.copyWith(spells: spells));
    } catch (e) {
      print('error reading spells from state');
    }
  }

  Future<void> deleteSpellBySpellID(String spellID) async {
    await dndService.deleteSpellBySpellID(spellID: spellID);
  }
}
