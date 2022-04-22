import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lovebirds_app/helper/savedVendorInfo.dart';

/// Gets custom vendor list from API
Future<List<SavedVendorInfo>> fetchAllSavedVendors(String email) async {
  // Request the custom vendor data, convert to JSon
  var response = await http
      .get(Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/saved-vendor/$email'));
  var jsonData = jsonDecode(response.body);
  List<SavedVendorInfo> savedVendorsList = [];

  // With the json data, convert it to a CustomVendorInfo and add it to our custom vendors list
  for (var vendor in jsonData) {
    SavedVendorInfo savedVendor = SavedVendorInfo(
        id: vendor['id'],
        name: vendor['vendor_title'],
        description: vendor['vendor_description'],
        rating: vendor['vendor_rating'],
        website: vendor['vendor_website'],
        location: vendor['vendor_location'],
        phoneNum: vendor['vendor_phone'],
        image: vendor['vendor_image']);
    savedVendorsList.add(savedVendor);
  }

  // Return the list of custom vendors
  return savedVendorsList;
}