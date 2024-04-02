part of 'character_cubit.dart';

@immutable
class CharacterState extends Equatable {
  final bool? signedIn;
  final MyUser? myUser;
  final List<DndCharacter> dndCharacters;
  final bool? statEdit;
  // final bool? abilitiesEdit;
  // final bool? itemsEdit;
  // final bool? weaponsEdit;
  // final bool? spellsEdit;
  // final bool? incomeEdit;

  const CharacterState({this.signedIn, this.myUser, required this.dndCharacters, this.statEdit});

  CharacterState copyWith({signedIn, myUser, dndCharacters, statEdit}) {
    return CharacterState(
      signedIn: signedIn ?? this.signedIn,
      myUser: myUser ?? this.myUser,
      dndCharacters: dndCharacters ?? this.dndCharacters,
      statEdit: statEdit ?? this.statEdit,
    );
  }

  @override
  List<Object?> get props => [signedIn, myUser, dndCharacters, statEdit];
}

final class CharacterInitial extends CharacterState {
  CharacterInitial()
      : super(
          signedIn: false,
          myUser: null,
          dndCharacters: [
            const DndCharacter(
              charID: '4567',
              userID: '1234',
              race: 'human',
              name: 'Jackson',
              dndClass: 'Dev',
            ),
          ],
          statEdit: false,
        );
}
