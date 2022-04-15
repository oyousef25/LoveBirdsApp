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
      urlToParse += 'https://api.foursquare.com/v3/places/search?query=Club&fields=name%2Clocation%2Ctel%2Cwebsite%2Crating%2Cphotos&near=Windsor%2C%20ON';
      break;
    case Constants.photoCategory:
      urlToParse += 'https://api.foursquare.com/v3/places/search?query=Photo&fields=name%2Clocation%2Cdescription%2Cwebsite%2Crating%2Cphotos&near=Windsor%2C%20ON';
      break;
    case Constants.gownCategory:
      urlToParse += 'https://api.foursquare.com/v3/places/search?query=Boutique&fields=name%2Clocation%2Cdescription%2Cwebsite%2Crating%2Cphotos&near=Windsor%2C%20ON';
      break;
    case Constants.floristCategory:
      urlToParse += 'https://api.foursquare.com/v3/places/search?query=Florist&fields=name%2Clocation%2Cdescription%2Cwebsite%2Crating%2Cphotos&near=Windsor%2C%20ON';
      break;
    case Constants.giftCategory:
      urlToParse += 'https://api.foursquare.com/v3/places/search?query=Wedding%20Gift&fields=name%2Clocation%2Cdescription%2Cwebsite%2Crating%2Cphotos&near=Windsor%2C%20ON';
      break;
  }

  // Request the vendor data, convert to JSon
  var response = await http
      .get(Uri.parse(urlToParse),
      // Required headers to access backend.
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'fsq3WQRAQxEILyvFtksxS9fADKi+zFFVpKBEfk9fUqII4XA=',
      });
  var jsonData = jsonDecode(response.body);
  List<VendorInfo> vendorsList = [];

  // With the json data, convert it to a VendorInfo and add it to our vendors list
  for (var vendor in jsonData['results']) {
    // Build out the first photo link if it exists
    List allPhotos = vendor['photos'];
    String firstPhoto = 'https://cdn.pixabay.com/photo/2020/02/20/17/57/flower-4865379_960_720.png'; // Set a default image in case there are no photos
    if(allPhotos.isNotEmpty) {
      print('notempty');
      firstPhoto = allPhotos[0]['prefix']! + 'original' + allPhotos[0]['suffix']!;
    }

    VendorInfo currentVendor = VendorInfo(
        vendor['name'] ?? 'Name N/A',
        vendor['rating'] ?? 0.0,
        vendor['description'] ?? 'Description N/A',
        true,
        'deprecate hours',
        vendor['website'] ?? 'Website N/A',
        vendor['tel'] ?? 'Contact # N/A',
        vendor['location']['address'] ?? 'Location N/A',
        firstPhoto
    );
    vendorsList.add(currentVendor);
  }

  // Return the list of vendors
  return vendorsList;
}