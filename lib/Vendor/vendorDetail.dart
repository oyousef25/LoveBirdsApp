import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/SavedVendor/createSavedVendor.dart';
import 'package:lovebirds_app/helper/savedVendorInfo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/constants.dart';
import '../helper/vendorInfo.dart';

class VendorDetailScreen extends StatefulWidget {
  // In the constructor, require a vendor info.
  const VendorDetailScreen({Key? key, required this.vendorInfo})
      : super(key: key);

  // Declare a field that holds the vendor info.
  final VendorInfo vendorInfo;

  @override
  State createState() {
    return _VendorDetailScreenState();
  }
}

class _VendorDetailScreenState extends State<VendorDetailScreen> {
  Future<SavedVendorInfo>? _futureSavedVendor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.lightPrimary,
          centerTitle: true,
          title: Text('Explore Vendors', style: Constants.appBarStyle),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            color: Colors.white,
            shadowColor: Colors.grey,
            elevation: 5.0,
            child: Column(
              children: [
                // Image of the vendor (can be cached)
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0)),
                  ),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      imageUrl: '${widget.vendorInfo.photos}',
                    ),
                  ),
                  height: 250.0,
                  width: double.infinity, // Stretch width as much as possible
                ),
                ListTile(
                  // Vendor name, rating, save indicator
                  title: Text(widget.vendorInfo.name,
                      textAlign: TextAlign.left,
                      style: Constants.bigListTitleStyle),
                  subtitle: Text('Rating: ${widget.vendorInfo.rating}',
                      textAlign: TextAlign.left,
                      style: Constants.bigListSubtitleStyle),
                  trailing: Icon(
                    Icons.favorite_border_rounded,
                    color: Constants.lightPrimary,
                    size: 40.0,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                ),
                ListTile(
                  // Vendor location
                  leading: Icon(
                    Icons.pin_drop_rounded,
                    color: Colors.black,
                  ),
                  title: Text(widget.vendorInfo.location,
                      textAlign: TextAlign.left,
                      style: Constants.bigListSubtitleStyle),
                  contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                  minLeadingWidth: 0.0,
                ),
                ListTile(
                  // Vendor description
                  leading: Icon(
                    Icons.storefront_rounded,
                    color: Colors.black,
                  ),
                  title: Text(widget.vendorInfo.description,
                      textAlign: TextAlign.left,
                      style: Constants.bigListSubtitleStyle),
                  contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                  minLeadingWidth: 0.0,
                ),
                ListTile(
                  // Vendor website
                  leading: Icon(
                    Icons.link_rounded,
                    color: Colors.black,
                  ),
                  title: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                        text: widget.vendorInfo.website,
                        style: Constants.bigListSubtitleStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Open website URL if valid
                            launch(widget.vendorInfo.website).onError((error, stackTrace) => false);
                          }),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                  minLeadingWidth: 0.0,
                ),
                ListTile(
                  // Vendor phone num
                  leading: Icon(
                    Icons.phone_rounded,
                    color: Colors.black,
                  ),
                  title: Text(widget.vendorInfo.phoneNum,
                      textAlign: TextAlign.left,
                      style: Constants.bigListSubtitleStyle),
                  contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                  minLeadingWidth: 0.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton(
                      onPressed: () {
                        String limitedDescription = '';
                        if (widget.vendorInfo.description.length >
                            Constants.maxDescriptionLength) {
                          // limitedDescription
                        }

                        // Save a vendor
                        _futureSavedVendor = createSavedVendorInfo(
                            widget.vendorInfo.name,
                            widget.vendorInfo.description,
                            '${widget.vendorInfo.rating}',
                            widget.vendorInfo.website,
                            widget.vendorInfo.location,
                            widget.vendorInfo.phoneNum,
                            widget.vendorInfo.photos,
                            widget.vendorInfo.userID);

                        // Go back
                        Navigator.pop(context);
                      },
                      child:
                          Text('Save Vendor', style: Constants.buttonRedStyle),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Constants.buttonRed),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 50.0)),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
