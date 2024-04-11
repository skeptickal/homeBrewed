import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd_character_manager/models/my_user.dart';
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

  Future<String> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return 'Successful Login';
    } catch (e) {
      print(e.toString());
      return 'Login Unsuccessful, Try Again';
    }
  }

  Future<String> signUp({required MyUser myUser, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password,
      );
      return 'Successful Registration';
    } catch (e) {
      print(e.toString());
      return 'Registration Unsuccessful, Try Again';
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
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
