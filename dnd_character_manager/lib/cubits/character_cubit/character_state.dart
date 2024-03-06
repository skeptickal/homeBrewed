part of 'character_cubit.dart';

@immutable
class CharacterState extends Equatable {
  final bool? signedIn;

  const CharacterState({this.signedIn});

  CharacterState copyWith({signedIn}) {
    return CharacterState(signedIn: signedIn ?? this.signedIn);
  }

  @override
  List<Object?> get props => [signedIn];
}

final class CharacterInitial extends CharacterState {
  const CharacterInitial() : super(signedIn: false);
}
