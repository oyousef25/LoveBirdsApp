import 'dart:convert';
import 'package:http/http.dart' as http;
import '../guestInfo.dart';

/// Gets guest list from API
Future<List<GuestInfo>> fetchConfirmedGuests() async {
  // Request the guest data, convert to JSon
  var response = await http
      .get(Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/guests'));
  var jsonData = jsonDecode(response.body);
  List<GuestInfo> customGuestsList = [];

  // With the json data, convert it to a GuestInfo and add it to our guest list
  for (var guest in jsonData['confirmed_guests']) {
    GuestInfo customGuest = GuestInfo(
      id: guest['id'],
      firstName: guest['first_name'],
      lastName: guest['last_name'],
      relationship: guest['guest_relationship'],
      email: guest['email_address'],
      phoneNum: guest['phone_number'],
      status: guest['status_id'],
    );
    customGuestsList.add(customGuest);
  }

  // Return the list of guests
  return customGuestsList;
}