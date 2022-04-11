import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helper/customVendorInfo.dart';

/// Gets custom vendor list from API
Future<List<CustomVendorInfo>> fetchAllCustomVendors() async {
  // Request the custom vendor data, convert to JSon
  var response = await http
      .get(Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/custom-vendors'));
  var jsonData = jsonDecode(response.body);
  List<CustomVendorInfo> customVendorsList = [];

  // With the json data, convert it to a CustomVendorInfo and add it to our custom vendors list
  for (var vendor in jsonData) {
    CustomVendorInfo customVendor = CustomVendorInfo(
        id: vendor['id'],
        name: vendor['vendor_name'],
        description: vendor['vendor_description'],
        phoneNum: vendor['phone_number'],
        vendorType: vendor['job_title']);
    customVendorsList.add(customVendor);
  }

  // Return the list of custom vendors
  return customVendorsList;
}