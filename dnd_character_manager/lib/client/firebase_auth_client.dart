import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd_character_manager/models/my_user/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthClient {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  FirebaseAuthClient({FirebaseAuth? firebaseAuth}) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) {
        return null;
      } else {
        return MyUser(userID: firebaseUser.uid, email: firebaseUser.email ?? "");
      }
    });
  }

  Future signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future signUp({required MyUser myUser, required String password}) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password,
      );
      myUser = myUser.copyWith(userID: user.user!.uid);
      return myUser;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> setUserData(MyUser myUser) async {
    try {
      await usersCollection.doc(myUser.userID).set(myUser.toJson());
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
