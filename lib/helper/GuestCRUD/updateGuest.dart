import 'dart:convert';
import 'package:lovebirds_app/helper/guestInfo.dart';
import 'package:http/http.dart' as http;

/// Updates a guest to an API
Future<GuestInfo> updateGuest(int id, int userID, String firstName, String lastName,
    int relationship, String email, String phoneNum, int status) async {
  final response = await http.put(
    Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/guests/$id'),
    headers: <String, String>{ // Metadata
      'Content-Type': 'application/json; charset=UTF-8',
    }, // Encode the guest
    body: jsonEncode(<String, dynamic>{
      'user_id': userID,
      'first_name': firstName,
      'last_name': lastName,
      'guest_relationship': relationship,
      'email_address': email,
      'phone_number': phoneNum,
      'status_id': status
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return GuestInfo.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update custom vendor.');
  }
}