import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';

class UserFirebaseService {
  final _users = FirebaseFirestore.instance.collection('users');

  // -----------------------------
  // CREATE / REGISTER USER
  // (Firestore auto-ID supported)
  // -----------------------------
  Future<bool> registerUser(User user) async {
    try {
      final docRef = _users.doc(); // 🔥 auto-generated ID

      final newUser = user.copyWith(id: docRef.id);

      await docRef.set({
        'name': newUser.name,
        'lastName': newUser.lastName,
        'age': newUser.age,
        'gender': newUser.gender,
        'mobile': newUser.mobile,
        'email': newUser.email,
        'imageUrl': newUser.imageUrl,

        // 🔥 ALWAYS regenerate keywords on update
        'searchKeywords': User.generateSearchKeywords(
          user.name,
          user.lastName,
          user.mobile,
        ),

        'createdAt': FieldValue.serverTimestamp(),
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  // -----------------------------
  // GET ALL USERS (DESC ORDER)
  // -----------------------------
  Future<List<User>> getUsers() async {
    final snapshot = await _users.orderBy('createdAt', descending: true).get();

    return snapshot.docs
        .map((doc) => User.fromJson(doc.data(), doc.id))
        .toList();
  }

  // -----------------------------
  // UPDATE USER
  // -----------------------------
  Future<void> updateUser(User user) async {
    await _users.doc(user.id).update({
      'name': user.name,
      'lastName': user.lastName,
      'age': user.age,
      'gender': user.gender,
      'mobile': user.mobile,
      'email': user.email,
      'imageUrl': user.imageUrl,

      // 🔥 ALWAYS regenerate keywords on update
      'searchKeywords': User.generateSearchKeywords(
        user.name,
        user.lastName,
        user.mobile,
      ),
    });
  }

  // -----------------------------
  // DELETE USER
  // -----------------------------
  Future<void> deleteUser(String id) async {
    await _users.doc(id).delete();
  }

  // -----------------------------
  // SEARCH USERS
  // -----------------------------
  Future<List<User>> searchUsers(String query) async {
    final q = query.trim().toLowerCase();

    // ✅ if empty → return all users
    if (q.isEmpty) {
      return getUsers();
    }

    final result = await _users.where('searchKeywords', arrayContains: q).get();

    return result.docs.map((doc) => User.fromJson(doc.data(), doc.id)).toList();
  }
}
