import 'package:dnd_character_manager/models/my_user/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class MyUserRepository {
  Stream<User?> get user;

  Future<dynamic> signIn(String email, String password);

  Future<void> setUserData(MyUser user);

  Future<dynamic> signUp({required MyUser myUser, required String password});
}
