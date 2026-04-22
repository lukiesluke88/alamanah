import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';

class UserFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _users => _firestore.collection('users');

  Future<List<User>> getUsers() async {
    final snapshot = await _users.get();

    return snapshot.docs.map((doc) {
      return User.fromJson({
        '_id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      });
    }).toList();
  }

  Stream<List<User>> streamUsers() {
    return _users.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return User.fromJson({
          '_id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        });
      }).toList();
    });
  }

  Future<void> deleteUser(String id) async {
    await _users.doc(id).delete();
  }

  Future<void> updateUser(User user) async {
    await _users.doc(user.id).update(user.toJson());
  }

  // Future<void> addUser(User user) async {
  //   await _users.add(user.toJson());
  // }

  Future<void> addUser(User user) async {
    final data = user.toJson();

    final keywords = generateSearchKeywords(
      user.name,
      user.lastName ?? '',
    );

    data['searchKeywords'] = keywords;
    await _users.add(data);
  }

  Future<List<User>> searchUsers(String query) async {
    final snapshot = await _users
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: '$query\uf8ff')
        .get();

    return snapshot.docs.map((doc) {
      return User.fromJson({
        '_id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      });
    }).toList();
  }

  List<String> generateSearchKeywords(String name, String lastName) {
    final fullText = '$name $lastName'.toLowerCase();
    final words = fullText.split(' ');
    final keywords = <String>{};

    for (final word in words) {
      for (int i = 1; i <= word.length; i++) {
        keywords.add(word.substring(0, i));
      }
    }

    keywords.addAll(words);

    return keywords.toList();
  }
}
