import 'package:bloc/bloc.dart';
import 'package:homeBrewed/client/firebase_auth_client.dart';
import 'package:homeBrewed/models/my_user.dart';
import 'package:homeBrewed/service/dnd_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final DndService dndService;
  final FirebaseAuthClient firebaseAuthClient;

  UserCubit({DndService? dndService, FirebaseAuthClient? firebaseAuthClient})
      : dndService = dndService ?? DndService(),
        firebaseAuthClient = firebaseAuthClient ?? FirebaseAuthClient(),
        super(const UserInitial());

  //edit booleans -> add setData functionality eventually to all these

// Firebase Auth related cubit functions
  Future<void> initialize() async {
    firebaseAuthClient.user.listen((MyUser? myUser) => _onUserChange(myUser));
  }

  Future<void> _onUserChange(MyUser? myUser) async {
    emit(state.copyWith(signedIn: myUser != null, myUser: myUser));
  }

  Future<String> signIn(String email, String password) async {
    emit(state.copyWith(textObscured: true));
    return firebaseAuthClient.signIn(email, password);
  }

  Future<String> signUp(String email, String password) async {
    MyUser myUser = MyUser(email: email);
    emit(state.copyWith(textObscured: true));
    return firebaseAuthClient.signUp(myUser: myUser, password: password);
  }

  Future<void> signOut() async {
    firebaseAuthClient.signOut();
    emit(state.copyWith(textObscured: true));
  }

  void revealOrHideText() => emit(state.copyWith(textObscured: !state.textObscured!));

  Future<void> setUserData(MyUser myUser) async => firebaseAuthClient.setUserData(myUser);

  Future<void> deleteUser() async => firebaseAuthClient.deleteUser();
}
