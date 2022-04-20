import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lovebirds_app/helper/Account/partnerInfo.dart';

/// Fetch the current user's partner data
Future<PartnerInfo> fetchPartner(String userEmail) async {
  // Request the partner data, convert to JSon
  var response = await http
      .get(Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/account/$userEmail'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return PartnerInfo.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load partner info');
  }
}