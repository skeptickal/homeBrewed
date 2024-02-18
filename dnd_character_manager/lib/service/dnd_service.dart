import 'package:dnd_character_manager/client/firebase_client.dart';
import 'package:dnd_character_manager/models/my_user.dart';

class DndService {
  final FirebaseClient client;

  DndService({FirebaseClient? client}) : client = client ?? FirebaseClient();

  Future<MyUser> signUp(MyUser myUser, String password) async {
    client.signUp(email: myUser.email, password: password);
    return MyUser(email: myUser.email, userID: myUser.userID);
  }

  Future<MyUser> signIn(MyUser myUser, String password) async {
    client.signInWithEmailAndPassword(myUser.email, password);
    return MyUser(email: myUser.email, userID: myUser.userID);
  }
}
