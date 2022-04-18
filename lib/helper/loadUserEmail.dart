// Get current user's email
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<String> loadUserEmail() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var user = jsonDecode(localStorage.getString('user') ?? "nothing");
  String email = '';

  if (user != null) {
    email = user['email'];
  }

  return email;
}