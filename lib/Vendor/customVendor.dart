import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/customVendorInfo.dart';

import '../helper/fetchAllCustomVendors.dart';
import 'customVendorDetail.dart';

class CustomVendorScreen extends StatefulWidget {
  const CustomVendorScreen({Key? key}) : super(key: key);

  @override
  State createState() {
    return _CustomVendorScreenState();
  }
}

class _CustomVendorScreenState extends State<CustomVendorScreen> {
  late Future<List<CustomVendorInfo>> _futureCustomVendors;
  // If this changes then the custom vendor list has changed
  final ValueNotifier<int> _listChanged = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    // Get a list of all custom vendors
    _futureCustomVendors = fetchAllCustomVendors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Build a list out of the custom vendors taken from an API
      body: FutureBuilder(
          future: _futureCustomVendors,
          // Takes the snapshotted data
          builder: (context, AsyncSnapshot snapshot) {
            // If the data retrieval went wrong
            if (snapshot.hasError) {
              return Center(
                child:
                    Text('There was an error fetching the custom vendor data'),
              );
            } else if (snapshot.hasData) {
              // Successful data retrieval
              return ListView.builder(
                // ListView that is built as it is scrolled onto the screen
                padding: EdgeInsets.only(top: 10.0),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 7.0, horizontal: 10.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.white,
                    shadowColor: Colors.grey,
                    elevation: 5.0,
                    child: ListTile(
                      title: Text(snapshot.data[index].name,
                          textAlign: TextAlign.left,
                          style: Constants.listTitleStyle),
                      subtitle: Text(snapshot.data[index].vendorType,
                          textAlign: TextAlign.left,
                          style: Constants.listSubtitleStyle),
                      trailing: Icon(Icons.phone_rounded, size: 40),
                      onTap: () {
                        // Open up the custom vendor info route which
                        // should return an updated list of custom vendors
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
          }),
    );
  }
}
