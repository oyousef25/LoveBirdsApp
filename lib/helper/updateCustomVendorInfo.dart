import 'dart:convert';

import 'customVendorInfo.dart';
import 'package:http/http.dart' as http;

/// Posts a custom vendor to an API
Future<CustomVendorInfo> updateCustomVendorInfo(int id, String name, String description, String phoneNum, String vendorType, int userID) async {
  final response = await http.put(
    Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/custom-vendors/$id'),
    headers: <String, String>{ // Metadata
      'Content-Type': 'application/json; charset=UTF-8',
    }, // Encode the custom vendor
    body: jsonEncode(<String, dynamic>{
      'vendor_name': name,
      'vendor_description': description,
      'phone_number': phoneNum,
      'job_title': vendorType,
      'user_id': userID,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CustomVendorInfo.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update custom vendor.');
  }
}