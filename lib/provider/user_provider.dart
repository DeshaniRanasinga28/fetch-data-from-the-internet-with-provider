import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../model/user_model.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> fetchUserData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://run.mocky.io/v3/4ff191af-358d-427c-bc71-5e6031817dec'));

      if (response.statusCode == 200) {
        _user = UserModel.fromJson(json.decode(response.body));
        notifyListeners();
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
