import 'dart:convert';
import 'package:lovebirds_app/helper/guestInfo.dart';
import 'package:http/http.dart' as http;

/// Posts a custom vendor to an API
Future<GuestInfo> createGuest(int userID, String firstName, String lastName,
    String relationship, String email, String phoneNum, int status) async {
  final response = await http.post(
    Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/guests'),
    headers: <String, String>{ // Metadata
      'Content-Type': 'application/json; charset=UTF-8',
    }, // Encode the custom vendor
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

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return GuestInfo.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create guest.');
  }
}