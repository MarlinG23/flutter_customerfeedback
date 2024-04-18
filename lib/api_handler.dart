import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_customerfeedback_api/model.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  // api call link to view data on web
  final String baseUri = "https://localhost:7297/api/users";

  Future<List<User>> getUserData() async {
    List<User> data = [];

    final uri = Uri.parse(baseUri);
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        data = jsonData.map((json) => User.fromJson(json)).toList();
      }
    } catch (e) {
      return data;
    }
    return data;
  }

  Future<http.Response> updateUser(
      {required int userId, required User user}) async {
    final uri = Uri.parse("$baseUri/$userId");
    late http.Response response;

    try {
      response = await http.put(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: json.encode(user),
      );
    } catch (e) {
      return response;
    }

    return response;
  }

  Future<http.Response> addUser({required User user}) async {
    final uri = Uri.parse(baseUri);
    http.Response response;

    try {
      response = await http.post(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: json.encode(user),
      );
    } catch (e) {
      response = http.Response('Error occurred: $e', 500);
    }

    return response;
  }

  // delete function with callback
  Future<void> deleteUser({
    required int userId,
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) async {
    final uri = Uri.parse("$baseUri/$userId");

    try {
      final response = await http.delete(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        onSuccess(); // Call onSuccess callback on successful deletion
      } else {
        onError(); // Call onError callback if deletion fails
      }
    } catch (e) {
      onError(); // Call onError callback if an exception occurs
    }
  }

  Future<User> getUserById({required int userId}) async {
    final uri = Uri.parse("$baseUri/$userId");
    User? user;
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        user = User.fromJson(jsonData);
      }
    } catch (e) {
      return user!;
    }
    return user!;
  }
}
