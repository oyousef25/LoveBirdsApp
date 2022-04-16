import 'dart:convert';
import 'package:http/http.dart' as http;

/// Gets relationship list from API
Future<List<String>> fetchAllRelationships() async {
  // Request the guest data, convert to JSon
  var response = await http
      .get(Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/guests'));
  var jsonData = jsonDecode(response.body);

  // Create the relationship list
  List<String> relationshipTypes = [];
  for (var relationship in jsonData['relationships']) {
    relationshipTypes.add(relationship['relationship_value']);
  }

  // Return the list of relationships
  return relationshipTypes;
}