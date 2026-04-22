import 'dart:convert';
import 'dart:io';
import 'package:alamanah/model/api_response.dart';

import 'package:http/http.dart' as http;

import '../model/user.dart';

class ApiService {
  
  // static final baseUrl = Platform.isAndroid
  //     ? "http://10.0.2.2:3000"
  //     : "http://127.0.0.1:3000";
  //
  // // GET all users
  // // static Future<List<User>> getUsers() async {
  // //   final res = await http.get(Uri.parse("$baseUrl/users"));
  // //
  // //   if (res.statusCode == 200) {
  // //     List list = jsonDecode(res.body);
  // //     return list.map((e) => User.fromJson(e)).toList();
  // //   }
  // //   throw Exception("Failed to load users");
  // // }
  //
  // // CREATE user
  // static Future<bool> addUser(User user) async {
  //   final res = await http.post(
  //     Uri.parse("$baseUrl/users"),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode(user.toJson()),
  //   );
  //
  //   return res.statusCode == 200;
  // }
  //
  // // UPDATE user
  // static Future<ApiResponse> updateUser(String id, User user) async {
  //   try {
  //     print("id: $id");
  //     final res = await http.put(
  //       Uri.parse("$baseUrl/users/$id"),
  //       headers: {"Content-Type": "application/json"},
  //       // body: jsonEncode(user.toJsonId(includeId: false)),
  //     );
  //     if (res.statusCode == 200) {
  //       return ApiResponse(success: true, message: "User updated successfully");
  //     } else {
  //       print("FAILED: ${res.body}");
  //       return ApiResponse(
  //         success: false,
  //         message: "Failed to update user: ${res.body}",
  //       );
  //     }
  //   } catch (e) {
  //     return ApiResponse(success: false, message: "Error: $e");
  //   }
  // }
  //
  // // DELETE user
  // static Future<ApiResponse> deleteUser(String id) async {
  //   print("Delete $id");
  //   try {
  //     final res = await http.delete(Uri.parse("$baseUrl/users/$id"));
  //
  //     if (res.statusCode == 200) {
  //       return ApiResponse(success: true, message: "User updated successfully");
  //     } else {
  //       return ApiResponse(
  //         success: false,
  //         message: "Failed to update user: ${res.body}",
  //       );
  //     }
  //   } on Exception catch (e) {
  //     return ApiResponse(success: false, message: "Error: $e");
  //   }
  // }

  // SEARCH users by name or email
  // static Future<List<User>> searchUserss(String query) async {
  //   final uri = Uri.parse("$baseUrl/search?q=$query");
  //
  //   // final res = await http.get(uri);
  //   //
  //   // if (res.statusCode == 200) {
  //   //   List list = jsonDecode(res.body);
  //   //   return list.map((e) => User.fromJson(e)).toList();
  //   // } else {
  //   //   throw Exception("Search failed: ${res.body}");
  //   // }
  // }
}
