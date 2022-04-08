import 'dart:convert';

import 'package:lovebirds_app/helper/customVendorInfo.dart';
import 'package:http/http.dart' as http;

/// Fetch custom vendor info from API
Future<CustomVendorInfo> fetchCustomVendorInfo() async {
  final response = await http.get(
    Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/custom-vendors/'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CustomVendorInfo.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load custom vendor info');
  }
}