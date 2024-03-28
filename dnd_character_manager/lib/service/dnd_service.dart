import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd_character_manager/client/firebase_client.dart';
import 'package:dnd_character_manager/models/character/dnd_character.dart';

class DndService {
  final FirebaseClient client;

  DndService({FirebaseClient? client}) : client = client ?? FirebaseClient();

  //add a dnd character
  Future<void> addDndCharacter({required DndCharacter dndCharacter}) async {
    client.setData(collectionName: 'dndCharacters', body: dndCharacter.toJson());
  }

  //read current dnd characters by userID
  Future<List<DndCharacter>> readDndCharactersByUserID({required String? userID}) async {
    QuerySnapshot<Map<String, dynamic>> data = await client.getData(collectionName: 'dndCharacters');

    List<DndCharacter> dndCharacters = data.docs
        .map((doc) => DndCharacter.fromJson(doc.data()))
        .where((character) => character.userID == userID) // Filter based on userID
        .toList();
    print('service $dndCharacters');
    return dndCharacters;
  }
}
