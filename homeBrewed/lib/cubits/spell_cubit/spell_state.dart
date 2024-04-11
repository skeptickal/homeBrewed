part of 'spell_cubit.dart';

@immutable
class SpellState extends Equatable {
  final List<Spell>? spells;
  final Spell? currentSelectedSpell;

  const SpellState({required this.spells, this.currentSelectedSpell});

  SpellState copyWith({spells, currentSelectedSpell}) {
    return SpellState(spells: spells ?? this.spells, currentSelectedSpell: currentSelectedSpell);
  }

  @override
  List<Object?> get props => [spells, currentSelectedSpell];
}

final class SpellInitial extends SpellState {
  SpellInitial()
      : super(
          spells: [],
          currentSelectedSpell: const Spell(
            charID: '1234',
            spellID: '5678',
            spellAtkOrDC: '1',
            description: '2',
            name: 'axe',
          ),
        );
}
