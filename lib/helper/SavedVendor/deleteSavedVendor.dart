import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lovebirds_app/helper/savedVendorInfo.dart';

/// Delete a custom vendor to an API
Future<SavedVendorInfo> deleteSavedVendor(int id) async {
  final response = await http.delete(
    Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/saved-vendors/$id'),
    headers: <String, String>{ // Metadata
      'Content-Type': 'application/json; charset=UTF-8',
    }, // Encode the saved vendor
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    return SavedVendorInfo.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete saved vendor.');
  }
}