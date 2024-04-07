import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd_character_manager/client/firebase_client.dart';
import 'package:dnd_character_manager/models/bio.dart';
import 'package:dnd_character_manager/models/notes.dart';
import 'package:dnd_character_manager/models/resource.dart';
import 'package:dnd_character_manager/models/stats.dart';
import 'package:dnd_character_manager/models/weapon.dart';

class DndService {
  final FirebaseClient client;

  DndService({FirebaseClient? client}) : client = client ?? FirebaseClient();

  //read current dnd characters by userID
  Future<List<Bio>> readBiosByUserID({required String? userID}) async {
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

  //read notes data from specific character
  Future<Notes> readNotesData({required String charID}) async {
    DocumentSnapshot documentSnapshot = await client.getDocumentData(collectionName: 'notes', documentName: charID);
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return Notes.fromJson(data);
  }

  //edit notes data for specific character
  Future<void> setNotesData({required Notes notes}) async {
    client.setData(collectionName: 'notes', documentName: notes.charID, body: notes.toJson());
  }

  // //read weapon data from specific character
  Future<Weapon> readWeaponData({required String weaponID}) async {
    DocumentSnapshot documentSnapshot = await client.getDocumentData(collectionName: 'weapons', documentName: weaponID);
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    print('Jeff service: $data');
    return Weapon.fromJson(data);
  }

  //edit weapon data for specific character
  Future<void> setWeaponsData({required Weapon weapon}) async {
    client.setData(collectionName: 'weapons', documentName: weapon.weaponID, body: weapon.toJson());
  }

  //read weapons data by charID
  Future<List<Weapon>> readWeaponsByCharID({required String? charID}) async {
    QuerySnapshot<Map<String, dynamic>> data = await client.getData(collectionName: 'weapons');
    List<Weapon> weapons = data.docs
        .map((doc) => Weapon.fromJson(doc.data()))
        .where(
          (weapon) => weapon.charID == charID,
        )
        .toList();
    print('Jackson service: $weapons');
    return weapons;
  }

  //delete weapon by weaponID
  Future<void> deleteWeaponByWeaponID({required String? weaponID}) async {
    client.deleteDocumentByName(documentName: weaponID!, collectionName: 'weapons');
  }

  // //read resource data from specific character
  // Future<Resource> readResourcesData({required String charID}) async {
  //   DocumentSnapshot documentSnapshot = await client.getDocumentData(collectionName: 'resources', documentName: charID);
  //   Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
  //   return Resource.fromJson(data);
  // }

  //edit resource data for specific character
  Future<void> setResourcesData({required Resource resource}) async {
    client.setData(collectionName: 'resources', documentName: resource.resourceID, body: resource.toJson());
  }

  //read resources data by charID
  Future<List<Resource>> readResourcesByCharID({required String? charID}) async {
    QuerySnapshot<Map<String, dynamic>> data = await client.getData(collectionName: 'resources');
    List<Resource> resources = data.docs
        .map((doc) => Resource.fromJson(doc.data()))
        .where(
          (resource) => resource.charID == charID,
        )
        .toList();
    print('Jackson service: $resources');
    return resources;
  }

  //delete resource by resourceID
  Future<void> deleteResourceByResourceID({required String? resourceID}) async {
    client.deleteDocumentByName(documentName: resourceID!, collectionName: 'resources');
  }

  //delete docs
  Future<void> deleteFullCharacter({required String charID}) async {
    client.deleteDocumentByName(documentName: charID, collectionName: 'bio');
    client.deleteDocumentByName(documentName: charID, collectionName: 'stats');
    client.deleteDocumentByName(documentName: charID, collectionName: 'notes');
    client.deleteDocumentByFieldValue(fieldName: 'charID', fieldValue: charID, collectionName: 'weapons');
    client.deleteDocumentByFieldValue(fieldName: 'charID', fieldValue: charID, collectionName: 'resources');
  }
}
