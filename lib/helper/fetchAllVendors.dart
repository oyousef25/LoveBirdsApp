import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/vendorInfo.dart';

/// Gets custom vendor list from API
Future<List<VendorInfo>> fetchAllVendors(String category) async {
  String urlToParse = '';

  switch(category) {
    case Constants.venueCategory:
      urlToParse += 'https://api.foursquare.com/v3/places/search?query=Wedding%20Venue&fields=name%2location%2Ctel%2Cwebsite%2Chours%2Crating%2Cphotos&near=Windsor%2C%20ON';
      break;
    case Constants.photoCategory:
      urlToParse += 'https://api.foursquare.com/v3/places/search?query=Photography&fields=name%2location%2Cdescription%2Chours%2Cwebsite%2Crating%2Cphotos&near=Windsor%2C%20ON';
      break;
    case Constants.gownCategory:
      urlToParse += 'https://api.foursquare.com/v3/places/search?query=Bridal%20Venue&fields=name%2location%2Cdescription%2Chours%2Cwebsite%2Crating%2Cphotos&near=Windsor%2C%20ON';
      break;
    case Constants.floristCategory:
      urlToParse += 'https://api.foursquare.com/v3/places/search?query=Flower%20Store&fields=name%2location%2Cdescription%2Chours%2Cwebsite%2Crating%2Cphotos&near=Windsor%2C%20ON';
      break;
    case Constants.giftCategory:
      urlToParse += 'https://api.foursquare.com/v3/places/search?query=Wedding%20Gift%20Venue&fields=name%2location%2Cdescription%2Chours%2Cwebsite%2Crating%2Cphotos&near=Windsor%2C%20ON';
      break;
  }

  // Request the vendor data, convert to JSon
  var response = await http
      .get(Uri.parse(urlToParse),
      // Send authorization headers to the backend.
      headers: {
        // HttpHeaders.authorizationHeader: 'Basic fsq3WQRAQxEILyvFtksxS9fADKi+zFFVpKBEfk9fUqII4XA=',
        HttpHeaders.authorizationHeader: 'Authorization fsq3WQRAQxEILyvFtksxS9fADKi+zFFVpKBEfk9fUqII4XA=',
      });
  var jsonData = jsonDecode(response.body);
  List<VendorInfo> vendorsList = [];

  // With the json data, convert it to a VendorInfo and add it to our vendors list
  for (var vendor in jsonData) {
    print(vendor);
    VendorInfo currentVendor = VendorInfo(
        vendor['name'],
        vendor['rating'],
        vendor['description'],
        true,
        'deprecate hours',
        vendor['website'],
        'deprecate tel',
        vendor['location']['address'],
        vendor['photos']
    );
    vendorsList.add(currentVendor);
  }

  // Return the list of vendors
  return vendorsList;
}