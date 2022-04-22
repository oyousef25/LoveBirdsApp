import 'dart:convert';

import 'package:lovebirds_app/helper/savedVendorInfo.dart';
import 'package:http/http.dart' as http;

/// Posts a saved vendor to an API
Future<SavedVendorInfo> createSavedVendorInfo(String name, String description,
    String rating, String website, String location, String phoneNum,
    String image, int userID) async {
  final response = await http.post(
    Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/saved-vendors'),
    headers: <String, String>{ // Metadata
      'Content-Type': 'application/json; charset=UTF-8',
    }, // Encode the saved vendor
    body: jsonEncode(<String, dynamic>{
      'vendor_title': name,
      'vendor_description': description,
      'vendor_rating': rating,
      'vendor_website': website,
      'vendor_location': location,
      'vendor_phone': phoneNum,
      'vendor_image': image,
      'user_id': userID,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return SavedVendorInfo.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create saved vendor.');
  }
}