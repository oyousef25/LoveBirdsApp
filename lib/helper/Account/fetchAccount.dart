import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lovebirds_app/helper/Account/accountInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Fetch the current user's account data
Future<AccountInfo> fetchAccount() async {
  // Get the user's email stored in the SharedPreferences
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var user = jsonDecode(localStorage.getString('user') ?? "nothing");
  String email = '';

  if (user != null) {
    email = user['email'];
  }

  // Request the account data, convert to JSon
  var response = await http
      .get(Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/account/$email'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return AccountInfo.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load account info');
  }
}