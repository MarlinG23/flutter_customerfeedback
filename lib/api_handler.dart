import 'dart:convert';

import 'package:flutter_customerfeedback_api/model.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  final String baseUri = "https://localhost:7297/api/users";

  Future<List<User>> getUserData() async {
    List<User> data = [];

    final uri = Uri.parse(baseUri);
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        //Succful statuses
        final List<dynamic> jsonData = json.decode(response.body);
        data = jsonData
            .map((json) => User.fromJson(json))
            .toList(); //conversion from list to json string
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
    late http.Response response;

    try {
      response = await http.post(
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
}
