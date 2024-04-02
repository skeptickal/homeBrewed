import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd_character_manager/client/firebase_client.dart';
import 'package:dnd_character_manager/models/bio.dart';
import 'package:dnd_character_manager/models/character/dnd_character.dart';

class DndService {
  final FirebaseClient client;

  DndService({FirebaseClient? client}) : client = client ?? FirebaseClient();

  //add a dnd character
  Future<void> addDndCharacter({required DndCharacter dndCharacter}) async {
    client.setData(collectionName: 'dndCharacters', body: dndCharacter.toJson());
    client.createDocument(
      collectionName: 'bio',
      documentName: dndCharacter.charID,
      body: {'alignment': 'Select an Alignment'},
    );
  }

  //read current dnd characters by userID
  Future<List<DndCharacter>> readDndCharactersByUserID({required String? userID}) async {
    QuerySnapshot<Map<String, dynamic>> data = await client.getData(collectionName: 'dndCharacters');

    List<DndCharacter> dndCharacters = data.docs
        .map((doc) => DndCharacter.fromJson(doc.data()))
        .where((character) => character.userID == userID) // Filter based on userID
        .toList();
    return dndCharacters;
  }

  Future<Bio> readBioData({required String charID}) async {
    DocumentSnapshot documentSnapshot = await client.getDocumentData(collectionName: 'bio', documentName: charID);
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return Bio.fromJson(data);
  }

  Future<void> setBioData({required Bio bio}) async {
    client.setData(collectionName: 'bio', documentName: bio.charID, body: bio.toJson());
  }
}
