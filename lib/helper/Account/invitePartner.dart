import 'dart:convert';
import 'package:http/http.dart' as http;

/// Invite the partner, returns if successful or not
Future<bool> invitePartner(String userEmail, String partnerEmail) async {
  final response = await http.post(
    Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/partner/$userEmail'),
    headers: <String, String>{ // Metadata
      'Content-Type': 'application/json; charset=UTF-8',
    }, // Encode the partner email
    body: jsonEncode(<String, dynamic>{
      'email': partnerEmail,
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 201 CREATED response, (or 200 OK response)
    // then
    return true;
  } else {
    // If the server did not return a 201 CREATED response, (or 200 OK response)
    // then return false
    return false;
  }
}