import 'dart:convert';
import 'package:http/http.dart' as http;

/// Gets relationship list from API
Future<Map<int, String>> fetchAllRelationships() async {
  // Request the guest data, convert to JSon
  var response = await http
      .get(Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/guests'));
  var jsonData = jsonDecode(response.body);

  // Create the relationship map
  List<int> relationshipIds = [];
  List<String> relationshipTypes = [];
  for (var relationship in jsonData['relationships']) {
    relationshipIds.add(relationship['id']);
    relationshipTypes.add(relationship['relationship_value']);
  }
  var relationshipMap = Map<int, String>.fromIterables(relationshipIds, relationshipTypes);

  // Return the list of relationships
  return relationshipMap;
}