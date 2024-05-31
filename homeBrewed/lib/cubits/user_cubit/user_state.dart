part of 'user_cubit.dart';

@immutable
class UserState extends Equatable {
  final bool? signedIn;
  final MyUser? myUser;
  final bool? textObscured;

  const UserState({this.signedIn, this.myUser, this.textObscured});

  UserState copyWith({signedIn, myUser, dndCharacters, statEdit, textObscured}) {
    return UserState(
      textObscured: textObscured ?? this.textObscured,
      signedIn: signedIn ?? this.signedIn,
      myUser: myUser ?? this.myUser,
    );
  }

  @override
  List<Object?> get props => [
        textObscured,
        signedIn,
        myUser,
      ];
}

final class UserInitial extends UserState {
  const UserInitial()
      : super(
          signedIn: false,
          myUser: null,
          textObscured: true,
        );
}
