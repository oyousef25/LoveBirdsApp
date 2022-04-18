import 'dart:convert';
import 'package:http/http.dart' as http;

/// Gets users ID from API
Future<int> loadUserID(String userEmail) async {
  // Request the account data, convert to JSon
  var response = await http
      .get(Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/account/$userEmail'));
  var jsonData = jsonDecode(response.body);

  int userID = jsonData['user']['id'];

  // Return the user's ID
  return userID;
}