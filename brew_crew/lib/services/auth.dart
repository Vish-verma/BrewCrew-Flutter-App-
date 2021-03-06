import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

//Create User Object based on firebase user
User _userFromFirebaseUser (FirebaseUser user){
  return user != null ? User(uid: user.uid):null;
}
//auth change user stream
Stream<User> get user{
  return _auth.onAuthStateChanged
  .map(_userFromFirebaseUser);
}


  //sign in anon
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user= result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null; 
    }
  }

  //sign in with email & pass
  Future signInWithEmailAndPassword(String email,String pass) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email:email,password:pass);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
        print(e.toString());
      return null;
    }
  }

  //register with email & pass
  Future registerWithEmailAndPassword(String email,String pass) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email:email,password:pass);
      FirebaseUser user = result.user;

    //Create New document for the user
    await DatabaseService(uid:user.uid).updateUserData('0','new crew member',100);

      return _userFromFirebaseUser(user);
    } catch (e) {
        print(e.toString());
      return null;
    }
  }
  //Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}