part of 'character_cubit.dart';

@immutable
class CharacterState extends Equatable {
  final bool? signedIn;
  final MyUser? myUser;
  final List<DndCharacter> dndCharacters;
  // final bool? statsEdit;
  // final bool? abilitiesEdit;
  final bool? bioEdit;
  // final bool? itemsEdit;
  // final bool? weaponsEdit;
  // final bool? spellsEdit;
  // final bool? incomeEdit;

  const CharacterState({this.signedIn, this.myUser, required this.dndCharacters, this.bioEdit});

  CharacterState copyWith({signedIn, myUser, dndCharacters, bioEdit}) {
    return CharacterState(
      signedIn: signedIn ?? this.signedIn,
      myUser: myUser ?? this.myUser,
      dndCharacters: dndCharacters ?? this.dndCharacters,
      bioEdit: bioEdit ?? this.bioEdit,
    );
  }

  @override
  List<Object?> get props => [signedIn, myUser, dndCharacters, bioEdit];
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
            bioEdit: false);
}
