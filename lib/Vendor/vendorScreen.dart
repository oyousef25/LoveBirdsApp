import 'package:flutter/material.dart';
import 'package:lovebirds_app/Vendor/vendorDetail.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/fetchAllVendors.dart';
import 'package:lovebirds_app/helper/vendorInfo.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VendorScreen extends StatefulWidget {
  // In the constructor, require a Vendor type and vendor list.
  const VendorScreen(
      {Key? key, required this.vendorType})
      : super(key: key);

  // Declare a field that holds the vendor type and vendor list.
  final String vendorType;

  @override
  State createState() {
    return _VendorScreenState();
  }
}

class _VendorScreenState extends State<VendorScreen> {
  late Future<List<VendorInfo>> _futureVendors;

  @override
  void initState() {
    super.initState();
    // Get a list of all vendors
    _futureVendors = fetchAllVendors(widget.vendorType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.lightPrimary,
        centerTitle: true,
        title: Text(widget.vendorType, style: Constants.appBarStyle),
      ),
      body: FutureBuilder(
          future: _futureVendors,
          // Takes the snapshotted data
          builder: (context, AsyncSnapshot snapshot) {
            // If the data retrieval went wrong
            if (snapshot.hasError) {
              return Center(
                child:
                    Text('There was an error fetching the vendor data'),
              );
            } else if (snapshot.hasData) {
              // Successful data retrieval
              return ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  // ListView that is built as it is scrolled onto the screen
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      // Makes content clickable
                      onTap: () {
                        // Go to Vendor Details page
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VendorDetailScreen(
                            vendorInfo: snapshot.data[index],
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
                                        '${snapshot.data[index].photos}',
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
                                      Text('${snapshot.data[index].rating}',
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
                                  snapshot.data[index].saved
                                      ? Icons.favorite
                                      : Icons.favorite_border_rounded,
                                  color: Constants.lightPrimary,
                                ),

                                const Padding(
                                    padding: EdgeInsets.only(left: 12)),
                              ],
                            ),
                          )),
                    );
                  });
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
