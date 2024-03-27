import 'dart:async';
import 'package:brew_crew/models/user.dart'as LocalUser;
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user object based on FirebaseUser
  LocalUser.User? _userFromFirebaseUser(User user) {
    return LocalUser.User(uid: user.uid);

  }

   // Auth change user stream
  Stream<LocalUser.User?> get user 
    => _auth.authStateChanges()
    .map((User? user) => _userFromFirebaseUser(user!));

    
  
  
  // Sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
  try{
   UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
   User? user = result.user;
   return _userFromFirebaseUser(user!);
  } catch(e){
    print(e.toString());
      return null;
  }
}

  // Register with email and password

Future registerWithEmailAndPassword(String email, String password) async {
  try{
   UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
   User? user = result.user;

   //create a new document for the user with the uid
   await DatabaseService(uid: user!.uid).updateUserData('0','new crew member', 100);

   return _userFromFirebaseUser(user);
  } catch(e){
    print(e.toString());
      return null;
  }
}

  // Sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
     print(e.toString());
     return null;
    }
  }
}
