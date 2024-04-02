part of 'user_cubit.dart';

@immutable
class UserState extends Equatable {
  final bool? signedIn;
  final MyUser? myUser;
  final bool? statEdit;
  // final bool? abilitiesEdit;
  // final bool? itemsEdit;
  // final bool? weaponsEdit;
  // final bool? spellsEdit;
  // final bool? incomeEdit;

  const UserState({this.signedIn, this.myUser, this.statEdit});

  UserState copyWith({signedIn, myUser, dndCharacters, statEdit}) {
    return UserState(
      signedIn: signedIn ?? this.signedIn,
      myUser: myUser ?? this.myUser,
      statEdit: statEdit ?? this.statEdit,
    );
  }

  @override
  List<Object?> get props => [signedIn, myUser, statEdit];
}

final class UserInitial extends UserState {
  const UserInitial()
      : super(
          signedIn: false,
          myUser: null,
          statEdit: false,
        );
}
