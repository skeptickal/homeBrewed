part of 'user_cubit.dart';

@immutable
class UserState extends Equatable {
  final bool? signedIn;
  final MyUser? myUser;
  // final bool? abilitiesEdit;
  // final bool? itemsEdit;
  // final bool? weaponsEdit;
  // final bool? spellsEdit;
  // final bool? incomeEdit;

  const UserState({this.signedIn, this.myUser});

  UserState copyWith({signedIn, myUser, dndCharacters, statEdit}) {
    return UserState(
      signedIn: signedIn ?? this.signedIn,
      myUser: myUser ?? this.myUser,
    );
  }

  @override
  List<Object?> get props => [
        signedIn,
        myUser,
      ];
}

final class UserInitial extends UserState {
  const UserInitial()
      : super(
          signedIn: false,
          myUser: null,
        );
}
