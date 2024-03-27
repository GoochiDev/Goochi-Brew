class User {
  final String uid;

  User({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final String strength; // Corrected typo from 'strenght' to 'strength'

  UserData({
    required this.uid,
    required this.name,
    required this.sugars,
    required this.strength, required String strenght, // Corrected typo from 'strenght' to 'strength'
  });
}
