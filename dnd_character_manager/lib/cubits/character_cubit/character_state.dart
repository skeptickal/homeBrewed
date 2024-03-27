part of 'character_cubit.dart';

@immutable
class CharacterState extends Equatable {
  final bool? signedIn;
  final MyUser? myUser;
  final List<DndCharacter>? dndCharacters;

  const CharacterState({this.signedIn, this.myUser, this.dndCharacters});

  CharacterState copyWith({signedIn, myUser, dndCharacters}) {
    return CharacterState(
      signedIn: signedIn ?? this.signedIn,
      myUser: myUser ?? this.myUser,
      dndCharacters: dndCharacters ?? this.dndCharacters,
    );
  }

  @override
  List<Object?> get props => [signedIn, myUser, dndCharacters];
}

final class CharacterInitial extends CharacterState {
  CharacterInitial()
      : super(signedIn: false, myUser: null, dndCharacters: [
          const DndCharacter(
            userID: 'example',
            race: 'human',
            name: 'Jackson',
            dndClass: 'Dev',
          )
        ]);
}
