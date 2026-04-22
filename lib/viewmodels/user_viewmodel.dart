import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/user.dart';
import '../service/user_firebase_service.dart';

class UserViewModel extends ChangeNotifier {
  final _service = UserFirebaseService();

  List<User> users = [];
  bool isLoading = false;

  Future<void> loadUsers() async {
    isLoading = true;
    notifyListeners();

    users = await _service.getUsers();

    isLoading = false;
    notifyListeners();
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      await loadUsers();
      return;
    }

    final q = query.toLowerCase();

    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('searchKeywords', arrayContains: q)
        .get();

    users = result.docs.map((doc) {
      return User.fromJson(doc.data());
    }).toList();

    notifyListeners();
  }

  Future<void> deleteUser(String id) async {
    await _service.deleteUser(id);
    await loadUsers();
  }

  Future<void> updateUser(User user) async {
    await _service.updateUser(user);
    await loadUsers();
  }
}
