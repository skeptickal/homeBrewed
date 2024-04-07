import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseClient {
  final FirebaseFirestore firestore;
  final _firebaseMessaging = FirebaseMessaging.instance;

  FirebaseClient({FirebaseFirestore? firestore}) : firestore = firestore ?? FirebaseFirestore.instance;

  Future<dynamic> setData({required String collectionName, dynamic body, String? documentName}) async {
    CollectionReference collection = firestore.collection(collectionName);

    try {
      await collection.doc(documentName).set(body);
      return 'Success';
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getData({required String collectionName}) async {
    CollectionReference collection = firestore.collection(collectionName);
    return collection.get();
  }

  Future<dynamic> getDocumentData({required String collectionName, required String documentName}) async {
    DocumentReference document = firestore.doc('/$collectionName/$documentName');

    try {
      DocumentSnapshot snapshot = await document.get();
      if (snapshot.exists) {
        return snapshot;
      } else {
        await setData(collectionName: collectionName, documentName: documentName);
      }
    } catch (e) {
      print('Error getting document $e');
      return null;
    }
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

  Future<void> deleteDocumentByName({required String documentName, required String collectionName}) async {
    await firestore.collection(collectionName).doc(documentName).delete();
  }

  Future<void> deleteDocumentByFieldValue({required String collectionName, required String fieldName, required String fieldValue}) async {
    final QuerySnapshot querySnapshot = await firestore.collection(collectionName).where(fieldName, isEqualTo: fieldValue).get();
    for (final docSnapshot in querySnapshot.docs) {
      await firestore.collection(collectionName).doc(docSnapshot.id).delete();
    }
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('token: $fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}
