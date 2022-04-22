import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lovebirds_app/helper/Account/accountInfo.dart';

/// Updates account info to an API
Future<bool> updateAccount(int userID, String? name, double? budget, String? weddingDate) async {
  final response = await http.put(
    Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/account/$userID'),
    headers: <String, String>{ // Metadata
      'Content-Type': 'application/json; charset=UTF-8',
    }, // Encode the account info
    body: jsonEncode(<String, dynamic>{
      'user_id': userID,
      'name': name,
      // 'email': email,
      'budget': budget,
      'wedding_date': weddingDate,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then return true.
    return true;
  } else {
    // If the server did not return a 200 OK response,
    // then return false
    return false;
  }
}