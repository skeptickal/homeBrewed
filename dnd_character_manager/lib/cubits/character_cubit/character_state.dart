part of 'character_cubit.dart';

@immutable
class CharacterState extends Equatable {
  final bool? signedIn;
  final MyUser? myUser;
  final List<DndCharacter> dndCharacters;
  final bool? statEdit;
  // final bool? abilitiesEdit;
  final bool? bioEdit;
  // final bool? itemsEdit;
  // final bool? weaponsEdit;
  // final bool? spellsEdit;
  // final bool? incomeEdit;

  const CharacterState({this.signedIn, this.myUser, required this.dndCharacters, this.bioEdit, this.statEdit});

  CharacterState copyWith({signedIn, myUser, dndCharacters, bioEdit, statEdit}) {
    return CharacterState(
      signedIn: signedIn ?? this.signedIn,
      myUser: myUser ?? this.myUser,
      dndCharacters: dndCharacters ?? this.dndCharacters,
      bioEdit: bioEdit ?? this.bioEdit,
      statEdit: statEdit ?? this.statEdit,
    );
  }

  @override
  List<Object?> get props => [signedIn, myUser, dndCharacters, bioEdit, statEdit];
}

final class CharacterInitial extends CharacterState {
  CharacterInitial()
      : super(
          signedIn: false,
          myUser: null,
          dndCharacters: [
            const DndCharacter(
              userID: '1234',
              race: 'human',
              name: 'Jackson',
              dndClass: 'Dev',
            ),
          ],
          bioEdit: false,
          statEdit: false,
        );
}
