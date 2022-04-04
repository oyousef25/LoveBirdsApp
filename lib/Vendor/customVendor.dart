import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:http/http.dart' as http;

import '../helper/customVendorInfo.dart';
import 'customVendorDetail.dart';

class CustomVendorScreen extends StatefulWidget {
  // In the constructor, require a custom vendors list.
  const CustomVendorScreen({Key? key, required this.customVendors})
      : super(key: key);

  // Declare a field that holds the custom vendors list.
  final List<CustomVendorInfo> customVendors;

  @override
  State createState() {
    return _CustomVendorScreenState(customVendors: customVendors);
  }
}

class _CustomVendorScreenState extends State<CustomVendorScreen> {
  // In the constructor, require a custom vendors list.
  _CustomVendorScreenState({required this.customVendors});

  // Declare a field that holds the custom vendors list.
  final List<CustomVendorInfo> customVendors;

  /// Gets custom vendor list from API
  getCustomVendors() async {
    // Request the custom vendor data, convert to JSon
    var request = await http.get(Uri.https('oyousef.scweb.ca', '/lovebirds/api/v1/custom-vendors'));
    var jsonData = jsonDecode(request.body);
    List<CustomVendorInfo> customVendorsList = [];

    // With the json data, convert it to a CustomVendorInfo and add it to our custom vendors list
    for(var vendor in jsonData) {
      CustomVendorInfo customVendor = CustomVendorInfo(vendor['vendor_name'], vendor['vendor_description'], vendor['phone_number'], 'Placeholder', vendor['job_title']);
      customVendorsList.add(customVendor);
    }

    // Return the list of custom vendors
    return customVendorsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getCustomVendors(),
        // Takes the snapshotted data
        builder: (context, AsyncSnapshot snapshot) {
          // If the data retrieval went wrong
          if(snapshot.hasError) {
            return Center(child: Text('There was an error fetching the custom vendor data'),);
          } else if (snapshot.hasData) { // Successful data retrieval
            return ListView.builder(
              // ListView that is built as it is scrolled onto the screen
              padding: EdgeInsets.only(top: 10.0),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.white,
                  shadowColor: Colors.grey,
                  elevation: 5.0,
                  child: ListTile(
                    title: Text(snapshot.data[index].name,
                        textAlign: TextAlign.left, style: Constants.listTitleStyle),
                    subtitle: Text(snapshot.data[index].location,
                        textAlign: TextAlign.left,
                        style: Constants.listSubtitleStyle),
                    trailing: Icon(Icons.phone_rounded, size: 40),
                    onTap: () {
                      // Open up the custom vendor info route
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CustomVendorDetailScreen(
                            customVendor: snapshot.data[index]),
                      ));
                    },
                  ),
                );
              },
            );
          } else {
            // Loading data animation
            return const Center(
                child: CircularProgressIndicator(),
            );
          }
        }
      )
    );
  }
}