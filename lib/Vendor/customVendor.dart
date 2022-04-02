import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        // ListView that is built as it is scrolled onto the screen
        padding: EdgeInsets.only(top: 10.0),
        itemCount: widget.customVendors.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.white,
            shadowColor: Colors.grey,
            elevation: 5.0,
            child: ListTile(
              title: Text(widget.customVendors[index].name,
                  textAlign: TextAlign.left, style: Constants.listTitleStyle),
              subtitle: Text(widget.customVendors[index].location,
                  textAlign: TextAlign.left,
                  style: Constants.listSubtitleStyle),
              trailing: Icon(Icons.phone_rounded, size: 40),
              onTap: () {
                // Open up the custom vendor info route
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CustomVendorDetailScreen(
                      customVendor: widget.customVendors[index]),
                ));
              },
            ),
          );
        },
      ),
    );
  }
}