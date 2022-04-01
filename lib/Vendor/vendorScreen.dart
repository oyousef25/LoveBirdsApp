import 'package:flutter/material.dart';
import 'package:lovebirds_app/Vendor/vendorDetail.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/vendorInfo.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VendorScreen extends StatefulWidget {
  // In the constructor, require a Vendor type and vendor list.
  const VendorScreen(
      {Key? key, required this.vendorType, required this.vendors})
      : super(key: key);

  // Declare a field that holds the vendor type and vendor list.
  final String vendorType;
  final List<VendorInfo> vendors;

  @override
  State createState() {
    return _VendorScreenState(vendorType: vendorType, vendors: vendors);
  }
}

class _VendorScreenState extends State<VendorScreen> {
  // In the constructor, require a vendor type and vendors list.
  _VendorScreenState({required this.vendorType, required this.vendors});

  // Declare a field that holds the vendor type and vendors list.
  final String vendorType;
  final List<VendorInfo> vendors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.lightPrimary,
        centerTitle: true,
        title: Text(vendorType, style: Constants.appBarStyle),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 10.0),
        // ListView that is built as it is scrolled onto the screen
        itemCount: widget.vendors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            // Makes content clickable
            onTap: () {
              // Go to Vendor Details page
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => VendorDetailScreen(
                  vendorInfo: vendors[index],
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
                            Text(widget.vendors[index].name,
                                textAlign: TextAlign.left,
                                style: Constants.listTitleStyle),
                            const Padding(padding: EdgeInsets.only(bottom: 9)),
                            Text(widget.vendors[index].rating,
                                textAlign: TextAlign.left,
                                style: Constants.listSubtitleStyle),
                            const Padding(padding: EdgeInsets.only(bottom: 9)),
                            Text(widget.vendors[index].description,
                                textAlign: TextAlign.left,
                                style: Constants.listSubtitleStyle),
                            const Padding(padding: EdgeInsets.only(bottom: 12)),
                          ],
                        ),
                      ),

                      // Icon containing saved vendor indicator
                      Icon(
                        widget.vendors[index].saved
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
