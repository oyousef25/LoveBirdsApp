import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovebirds_app/Vendor/vendorDetail.dart';
import 'package:lovebirds_app/Vendor/vendorScreen.dart';

import '../helper/constants.dart';
import '../helper/vendorInfo.dart';

class VendorCategoriesScreen extends StatefulWidget {
  // In the constructor, require a saved vendors list.
  const VendorCategoriesScreen({Key? key, required this.vendorList})
      : super(key: key);

  // Declare a field that holds the vendor list.
  final List<VendorInfo> vendorList;

  @override
  State createState() {
    return _VendorCategoriesScreenState();
  }
}

class _VendorCategoriesScreenState extends State<VendorCategoriesScreen> {
  // List of all the vendor categories
  List<String> vendorCategories = [
    "Venues",
    "Bridal Gowns",
    "Photographers",
    "Florists",
    "Gifts"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.only(top: 10.0),
        // ListView that is built as it is scrolled onto the screen
        itemCount: vendorCategories.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
              Container(
                width: 400.0,
                height: 90.0,
                child: ElevatedButton(
                  onPressed: () {
                    // Go to vendors page
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VendorScreen(
                        vendorType: vendorCategories[index],
                        vendors: widget.vendorList,
                      ),
                    ));
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Constants.lightSecondary),
                    // padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 40.0, horizontal: 150.0)),
                  ),
                  child: Text(
                    vendorCategories[index],
                    textAlign: TextAlign.center,
                    style: Constants.cardHeaderStyle,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
              ),
            ],
          );
        },
      ),
    );
  }
}
