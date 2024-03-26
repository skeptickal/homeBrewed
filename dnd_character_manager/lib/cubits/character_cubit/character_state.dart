part of 'character_cubit.dart';

@immutable
class CharacterState extends Equatable {
  final bool? signedIn;
  final MyUser? myUser;

  const CharacterState({this.signedIn, this.myUser});

  CharacterState copyWith({signedIn, myUser}) {
    return CharacterState(signedIn: signedIn ?? this.signedIn, myUser: myUser ?? this.myUser);
  }

  @override
  List<Object?> get props => [signedIn, myUser];
}

final class CharacterInitial extends CharacterState {
  const CharacterInitial() : super(signedIn: false, myUser: null);
}
