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

  Future<void> createDocument({required String collectionName, required String documentName, required dynamic body}) async {
    try {
      // Get a reference to the document
      DocumentReference documentRef = FirebaseFirestore.instance.collection(collectionName).doc(documentName);

      // Set an empty object as the document data
      await documentRef.set(body);

      print('Blank document created successfully');
    } catch (e) {
      print('Error creating blank document: $e');
    }
  }

  Future<dynamic> getData({required String collectionName}) async {
    CollectionReference collection = firestore.collection(collectionName);
    return collection.get();
  }

  Future<dynamic> getDocumentData({required String collectionName, required String documentName}) async {
    DocumentReference document = firestore.doc('$collectionName/$documentName');

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
