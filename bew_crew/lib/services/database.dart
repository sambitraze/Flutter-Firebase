import 'package:bew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bew_crew/models/brew.dart';

class DatabaseService {
  //Collection refernce
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      Firestore.instance.collection('BrewCrew');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugars'] ?? '0',
        strength: doc.data[''] ?? 100,
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  Stream<List<Brew>> get brews { 
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
