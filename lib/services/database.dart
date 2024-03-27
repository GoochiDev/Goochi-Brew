import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  // Collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future<void> updateUserData(
      String sugars, String name, int strength) async {
    try {
      await brewCollection.doc(uid).set({
        'sugars': sugars,
        'name': name,
        'strength': strength,
      });
    } catch (e) {
      print('Error updating user data: $e');
      // You can choose to throw the error or handle it as needed
      rethrow;
    }
  }

  //brew list from snapshot
List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic> or null
    return Brew(
      name: data?['name'] ?? '',
      sugars: data?['sugars'] ?? '',
      strenght: data?['strength'] ?? 0, strength: null
    );
  }).toList();
}

//userData from snapshot
UserData userDataFromSnapshot(DocumentSnapshot snapshot) {
  Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  return UserData(
    uid: uid,
    name: data['name'],
    sugars: data['sugars'],
    strenght: '100', strength: '100', // Corrected typo from 'strenght' to 'strength'
  );
}



  // Get brews stream
  Stream<List<Brew>> get brewsStream {
    try {
      return brewCollection.snapshots()
      .map(_brewListFromSnapshot);
    } catch (e) {
      print('Error fetching brews: $e');
      // You can choose to throw the error or handle it as needed
      rethrow;
    }
  }

// get user doc stream
Stream<DocumentSnapshot> get userData {
  return brewCollection.doc(uid).snapshots();
  
}

}
