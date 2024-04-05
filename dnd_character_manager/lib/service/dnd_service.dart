import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd_character_manager/client/firebase_client.dart';
import 'package:dnd_character_manager/models/bio.dart';
import 'package:dnd_character_manager/models/notes.dart';
import 'package:dnd_character_manager/models/stats.dart';

class DndService {
  final FirebaseClient client;

  DndService({FirebaseClient? client}) : client = client ?? FirebaseClient();

  //read current dnd characters by userID
  Future<List<Bio>> readBiosUserID({required String? userID}) async {
    QuerySnapshot<Map<String, dynamic>> data = await client.getData(collectionName: 'bio');

    List<Bio> bios = data.docs
        .map((doc) => Bio.fromJson(doc.data()))
        .where((bio) => bio.userID == userID) // Filter based on userID
        .toList();
    return bios;
  }

  //read bio data from specific character
  Future<Bio> readBioData({required String charID}) async {
    DocumentSnapshot documentSnapshot = await client.getDocumentData(collectionName: 'bio', documentName: charID);
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return Bio.fromJson(data);
  }

  //edit bio data for specific character
  Future<void> setBioData({required Bio bio}) async {
    client.setData(collectionName: 'bio', documentName: bio.charID, body: bio.toJson());
  }

  //read stats data from specific character
  Future<Stats> readStatsData({required String charID}) async {
    DocumentSnapshot documentSnapshot = await client.getDocumentData(collectionName: 'stats', documentName: charID);
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return Stats.fromJson(data);
  }

  //edit stats data for specific character
  Future<void> setStatsData({required Stats stats}) async {
    client.setData(collectionName: 'stats', documentName: stats.charID, body: stats.toJson());
  }

  //read stats data from specific character
  Future<Notes> readNotesData({required String charID}) async {
    DocumentSnapshot documentSnapshot = await client.getDocumentData(collectionName: 'notes', documentName: charID);
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return Notes.fromJson(data);
  }

  //edit stats data for specific character
  Future<void> setNotesData({required Notes notes}) async {
    client.setData(collectionName: 'notes', documentName: notes.charID, body: notes.toJson());
  }

  Future<void> deleteDocumentByName({required String charID}) async {
    client.deleteDocumentByName(documentName: charID, collectionName: 'bio');
    client.deleteDocumentByName(documentName: charID, collectionName: 'stats');
    client.deleteDocumentByName(documentName: charID, collectionName: 'notes');
  }
}
