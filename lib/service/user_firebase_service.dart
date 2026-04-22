import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';

class UserFirebaseService {
  final _users = FirebaseFirestore.instance.collection('users');

  Future<List<User>> getUsers() async {
    final snapshot = await _users.get();

    return snapshot.docs
        .map((doc) => User.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<void> updateUser(User user) async {
    await _users.doc(user.id).update(user.toJson());
  }

  Future<void> deleteUser(String id) async {
    await _users.doc(id).delete();
  }
}
