import 'package:bloc/bloc.dart';
import 'package:dnd_character_manager/client/firebase_auth_client.dart';
import 'package:dnd_character_manager/models/character/dnd_character.dart';
import 'package:dnd_character_manager/models/my_user/my_user.dart';
import 'package:dnd_character_manager/service/dnd_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final DndService dndService;
  final FirebaseAuthClient firebaseAuthClient;

  CharacterCubit({DndService? dndService, FirebaseAuthClient? firebaseAuthClient})
      : dndService = dndService ?? DndService(),
        firebaseAuthClient = firebaseAuthClient ?? FirebaseAuthClient(),
        super(CharacterInitial());

// Firebase Firestore related cubit functions
  Future<void> readCharactersByUserID(String? userID) async {
    try {
      final List<DndCharacter> dndCharacters = await dndService.readDndCharactersByUserID(userID: userID);
      emit(state.copyWith(dndCharacters: dndCharacters));
    } catch (e) {
      print('error reading characters from state');
    }
  }

// Firebase Auth related cubit functions
  Future<void> initialize() async {
    firebaseAuthClient.user.listen((MyUser? myUser) => _onUserChange(myUser));
  }

  Future<void> _onUserChange(MyUser? myUser) async {
    print(myUser);
    emit(state.copyWith(signedIn: myUser != null, myUser: myUser));
  }

  Future<void> signIn(String email, String password) async {
    firebaseAuthClient.signIn(email, password);
  }

  Future<void> signUp(String email, String password) async {
    MyUser myUser = MyUser(email: email);
    firebaseAuthClient.signUp(myUser: myUser, password: password);
  }

  Future<void> signOut() => firebaseAuthClient.signOut();

  Future<void> setUserData(MyUser myUser) async => firebaseAuthClient.setUserData(myUser);
}
