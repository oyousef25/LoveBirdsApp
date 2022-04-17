import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovebirds_app/Vendor/savedVendorDetail.dart';
import 'package:lovebirds_app/helper/savedVendorInfo.dart';

import '../helper/SavedVendor/fetchAllSavedVendors.dart';
import '../helper/constants.dart';

class SavedVendorScreen extends StatefulWidget {
  // In the constructor, require a saved vendors list.
  const SavedVendorScreen({Key? key}) : super(key: key);

  @override
  State createState() {
    return _SavedVendorScreenState();
  }
}

class _SavedVendorScreenState extends State<SavedVendorScreen> {
  late Future<List<SavedVendorInfo>> _futureSavedVendors;

  // Reload the saved vendors page with new data
  refreshPage() {
    _futureSavedVendors = fetchAllSavedVendors();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // Get a list of all saved vendors
    _futureSavedVendors = fetchAllSavedVendors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _futureSavedVendors,
          // Takes the snapshotted data
          builder: (context, AsyncSnapshot snapshot) {
            // If the data retrieval went wrong
            if (snapshot.hasError) {
              return Center(
                child:
                    Text('There was an error fetching the saved vendor data'),
              );
            } else if (snapshot.hasData) {
              return RefreshIndicator(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  // ListView that is built as it is scrolled onto the screen
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      // Makes content clickable
                      onTap: () {
                        // Go to Vendor Details page
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SavedVendorDetailScreen(
                            savedVendorInfo: snapshot.data[index],
                          ),
                        ));
                      },
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: Card(
                            // This card contains a row of the labels and widgets that make up a vendor item
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Colors.white,
                            shadowColor: Colors.grey,
                            elevation: 5.0,
                            child: Row(
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(left: 5)),

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
                                        snapshot.data[index].image,
                                    // width: 120.0,
                                    height: 90.0,
                                  ),
                                ),

                                const Padding(
                                    padding: EdgeInsets.only(left: 12)),

                                Expanded(
                                  // Column containing vendor name, rating and description
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.only(top: 12)),
                                      Text(snapshot.data[index].name,
                                          textAlign: TextAlign.left,
                                          style: Constants.listTitleStyle),
                                      const Padding(
                                          padding: EdgeInsets.only(bottom: 9)),
                                      Text('Rating: ${snapshot.data[index].rating}',
                                          textAlign: TextAlign.left,
                                          style: Constants.listSubtitleStyle),
                                      const Padding(
                                          padding: EdgeInsets.only(bottom: 9)),
                                      Text(snapshot.data[index].description,
                                          textAlign: TextAlign.left,
                                          style: Constants.listSubtitleStyle),
                                      const Padding(
                                          padding: EdgeInsets.only(bottom: 12)),
                                    ],
                                  ),
                                ),

                                // Icon containing saved vendor indicator
                                Icon(
                                  Icons.favorite,
                                  color: Constants.lightPrimary,
                                ),

                                const Padding(
                                    padding: EdgeInsets.only(left: 12)),
                              ],
                            ),
                          )),
                    );
                  },
                ),
                onRefresh: () async => {
                  // Refresh the saved vendors list
                  refreshPage(),
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
