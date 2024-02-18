import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseClient {
  final FirebaseAuth _auth;
  final FirebaseFirestore firestore;
  final _firebaseMessaging = FirebaseMessaging.instance;

  FirebaseClient({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  Future<dynamic> setData({required String collectionName, dynamic body}) async {
    CollectionReference collection = firestore.collection(collectionName);

    try {
      await collection.doc().set(body);
      return 'Success';
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getData({required String collectionName}) async {
    CollectionReference collection = firestore.collection(collectionName);
    return collection.get();
  }

  Future<dynamic> getDoc({required String collectionName, required String docId}) async {
    CollectionReference collection = firestore.collection(collectionName);
    DocumentSnapshot<Object?> documentSnapshot = await collection.doc(docId).get();

    if (documentSnapshot.exists) {
      return documentSnapshot.data();
    } else {
      return null;
    }
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('token: $fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

//AUTH AND USER SIGN UP, IN, REGISTER USER DATA

  //auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges().map((firebaseUser) {
      return firebaseUser!;
    });
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user!;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //registration method
  Future<void> signUp({required String email, required String password}) async {
    try {
      _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('This password is too weak');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('An account already exists for that email');
      }
    } catch (e) {
      throw Exception(e.toString);
    }
  }

  
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}
