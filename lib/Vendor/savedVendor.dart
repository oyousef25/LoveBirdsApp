import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovebirds_app/Vendor/vendorDetail.dart';

import '../helper/constants.dart';
import '../helper/vendorInfo.dart';

class SavedVendorScreen extends StatefulWidget {
  // In the constructor, require a saved vendors list.
  const SavedVendorScreen({Key? key, required this.savedVendors})
      : super(key: key);

  // Declare a field that holds the saved vendor list.
  final List<VendorInfo> savedVendors;

  @override
  State createState() {
    return _SavedVendorScreenState(savedVendors: savedVendors);
  }
}

class _SavedVendorScreenState extends State<SavedVendorScreen> {
  // In the constructor, require a saved vendors list.
  _SavedVendorScreenState({required this.savedVendors});

  // Declare a field that holds the saved vendor list.
  final List<VendorInfo> savedVendors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.only(top: 10.0),
        // ListView that is built as it is scrolled onto the screen
        itemCount: widget.savedVendors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            // Makes content clickable
            onTap: () {
              // Go to Vendor Details page
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => VendorDetailScreen(
                  vendorInfo: savedVendors[index],
                ),
              ));
            },
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Card(
                  // This card contains a row of the labels and widgets that make up a vendor item
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.white,
                  shadowColor: Colors.grey,
                  elevation: 5.0,
                  child: Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 5)),

                      // Image of the vendor (can be cached)
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: CachedNetworkImage(
                          placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                          imageUrl:
                          'https://s3-media0.fl.yelpcdn.com/bphoto/7_n-ekeqhRei7YJ-_Nzfrw/o.jpg',
                          // width: 120.0,
                          height: 90.0,
                        ),
                      ),

                      const Padding(padding: EdgeInsets.only(left: 12)),

                      Expanded(
                        // Column containing vendor name, rating and description
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(padding: EdgeInsets.only(top: 12)),
                            Text(widget.savedVendors[index].name,
                                textAlign: TextAlign.left,
                                style: Constants.listTitleStyle),
                            const Padding(padding: EdgeInsets.only(bottom: 9)),
                            Text(widget.savedVendors[index].rating,
                                textAlign: TextAlign.left,
                                style: Constants.listSubtitleStyle),
                            const Padding(padding: EdgeInsets.only(bottom: 9)),
                            Text(widget.savedVendors[index].description,
                                textAlign: TextAlign.left,
                                style: Constants.listSubtitleStyle),
                            const Padding(padding: EdgeInsets.only(bottom: 12)),
                          ],
                        ),
                      ),

                      // Icon containing saved vendor indicator
                      Icon(
                        widget.savedVendors[index].saved
                            ? Icons.favorite
                            : Icons.favorite_border_rounded,
                        color: Constants.lightPrimary,
                      ),

                      const Padding(padding: EdgeInsets.only(left: 12)),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}