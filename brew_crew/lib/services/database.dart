import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService{

  final String uid;
  DatabaseService({this.uid});
  //COllection Reference 
  final CollectionReference brewCollection =Firestore.instance.collection('brews');

  Future updateUserData(String sugars,String name,int strength) async{
    return await brewCollection.document(uid).setData({
      "sugars":sugars,
      "name":name,
      "strength":strength,
    });
  }

  //brew List from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? '0'
      );
    }).toList();
  }

  // GET BREWS STREAMS
    Stream<List<Brew>> get brews{
      return brewCollection.snapshots()
        .map(_brewListFromSnapshot);
    }

  // GET USER doc STREAM
  Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
  
  //UserData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid:uid,
      name:snapshot.data['name'],
      sugars:snapshot.data['sugars'],
      strength:snapshot.data['strength'],
    );
  }

}