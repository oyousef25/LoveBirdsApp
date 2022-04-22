import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lovebirds_app/helper/savedVendorInfo.dart';

/// Fetch saved vendor info from API
Future<SavedVendorInfo> fetchSavedVendor(int id) async {
  final response = await http.get(
    Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/saved-vendors/$id'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return SavedVendorInfo.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load saved vendor info');
  }
}