import 'dart:html';

import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/vendorInfo.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VendorsPage extends StatefulWidget {
  const VendorsPage({Key? key, required this.vendorList})
      : super(key: key); // Vendors page key identifier

  // Require guest data to be passed into this Widget
  final List<VendorInfo> vendorList;

  /// Creates a state
  ///
  /// Return the Vendors page State
  @override
  State<StatefulWidget> createState() {
    return _VendorsPageState(vendorList: vendorList);
  }
}

class _VendorsPageState extends State<VendorsPage>
    with TickerProviderStateMixin {
  _VendorsPageState({required this.vendorList});
  final List<VendorInfo> vendorList;

  // Lazy load the tab bar
  late TabController _tabController;

  // Initialize the tab bar
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  /// This Widget builds out the Vendors page
  ///
  /// Given the build [context], return the Vendors page Widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TabBarView(
            // Tab bar contents
            controller: _tabController,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.symmetric(vertical: 55.0)),
                  Container(
                    width: 400.0,
                    height: 90.0,
                    child: ElevatedButton(
                      onPressed: () {
                        // Go to vendors page
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VendorScreen(
                            vendorType: 'Venues',
                            vendors: vendorList,
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
                        'Venues',
                        textAlign: TextAlign.center,
                        style: Constants.cardHeaderStyle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  Container(
                    width: 400.0,
                    height: 90.0,
                    child: ElevatedButton(
                      onPressed: () {
                        // Go to vendors page
                        // Go to vendors page
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VendorScreen(
                            vendorType: 'Bridal Gowns',
                            vendors: vendorList,
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
                        'Bridal Gowns',
                        textAlign: TextAlign.center,
                        style: Constants.cardHeaderStyle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  Container(
                    width: 400.0,
                    height: 90.0,
                    child: ElevatedButton(
                      onPressed: () {
                        // Go to vendors page
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VendorScreen(
                            vendorType: 'Photographers',
                            vendors: vendorList,
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
                        'Photographers',
                        textAlign: TextAlign.center,
                        style: Constants.cardHeaderStyle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  Container(
                    width: 400.0,
                    height: 90.0,
                    child: ElevatedButton(
                      onPressed: () {
                        // Go to vendors page
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VendorScreen(
                            vendorType: 'Florists',
                            vendors: vendorList,
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
                        'Florists',
                        textAlign: TextAlign.center,
                        style: Constants.cardHeaderStyle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  Container(
                    width: 400.0,
                    height: 90.0,
                    child: ElevatedButton(
                      onPressed: () {
                        // Go to vendors page
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VendorScreen(
                            vendorType: 'Gifts',
                            vendors: vendorList,
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
                        'Gifts',
                        textAlign: TextAlign.center,
                        style: Constants.cardHeaderStyle,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Text("It's rainy here"),
              ),
              Center(
                child: Text("It's sunny here"),
              ),
            ],
          ),
          DefaultTabController(
            // Tab controller
            length: 3,
            child: TabBar(
              controller: _tabController,
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              indicatorColor: Constants.lightPrimary,
              indicatorWeight: 4.0,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 10.0),
              tabs: [
                Tab(
                  child: Text('Vendors', style: Constants.tabLabelStyle),
                ),
                Tab(
                  child: Text('Saved', style: Constants.tabLabelStyle),
                ),
                Tab(
                  child: Text('My Vendors', style: Constants.tabLabelStyle),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VendorScreen extends StatefulWidget {
  // In the constructor, require a Vendor list and vendor type.
  const VendorScreen(
      {Key? key, required this.vendorType, required this.vendors})
      : super(key: key);

  // Declare a field that holds the vendor type.
  final String vendorType;
  final List<VendorInfo> vendors;

  @override
  State createState() {
    return _VendorScreenState(vendorType: vendorType, vendors: vendors);
  }
}

class _VendorScreenState extends State<VendorScreen> {
  // In the constructor, require a vendor type.
  _VendorScreenState({required this.vendorType, required this.vendors});

  // Declare a field that holds the vendor type.
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
        padding: EdgeInsets.only(top: 20.0),
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
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
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

class VendorDetailScreen extends StatefulWidget {
  // In the constructor, require a Vendor list and vendor type.
  const VendorDetailScreen({Key? key, required this.vendorInfo})
      : super(key: key);

  // Declare a field that holds the vendor info.
  final VendorInfo vendorInfo;

  @override
  State createState() {
    return _VendorDetailScreenState(vendorInfo: vendorInfo);
  }
}

class _VendorDetailScreenState extends State<VendorDetailScreen> {
  // In the constructor, require a vendor type.
  _VendorDetailScreenState({required this.vendorInfo});

  // Declare a field that holds the vendor list.
  final VendorInfo vendorInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.lightPrimary,
        centerTitle: true,
        title: Text('Explore Vendors', style: Constants.appBarStyle),
      ),
      body: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        margin: EdgeInsets.symmetric(vertical: 100.0, horizontal: 20.0),
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
                // clipBehavior: Clip.antiAlias,
                fit: BoxFit.cover,
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  imageUrl:
                      'https://s3-media0.fl.yelpcdn.com/bphoto/7_n-ekeqhRei7YJ-_Nzfrw/o.jpg',
                ),
              ),
              height: 250.0,
              width: double.infinity, // Stretch width as much as possible
            ),
            ListTile( // Vendor name, rating, saved or not saved
              title: Text(widget.vendorInfo.name,
                  textAlign: TextAlign.left,
                  style: Constants.bigListTitleStyle),
              subtitle: Text(widget.vendorInfo.rating,
                  textAlign: TextAlign.left,
                  style: Constants.bigListSubtitleStyle),
              trailing: Icon(
                widget.vendorInfo.saved
                    ? Icons.favorite
                    : Icons.favorite_border_rounded,
                color: Constants.lightPrimary,
                size: 40.0,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            ),
            ListTile( // Vendor location
              leading: Icon(Icons.pin_drop_rounded, color: Colors.black,),
              title: Text(widget.vendorInfo.location,
                  textAlign: TextAlign.left,
                  style: Constants.bigListSubtitleStyle),
              contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
              minLeadingWidth: 0.0,
            ),
            ListTile( // Vendor description
              leading: Icon(Icons.storefront_rounded, color: Colors.black,),
              title: Text(widget.vendorInfo.description,
                  textAlign: TextAlign.left,
                  style: Constants.bigListSubtitleStyle),
              contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
              minLeadingWidth: 0.0,
            ),
            ListTile( // Vendor hours of operations
              leading: Icon(Icons.access_time_rounded, color: Colors.black,),
              title: Text(widget.vendorInfo.hours,
                  textAlign: TextAlign.left,
                  style: Constants.bigListSubtitleStyle),
              contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
              minLeadingWidth: 0.0,
            ),
            ListTile( // Vendor website
              leading: Icon(Icons.link_rounded, color: Colors.black,),
              title: Text(widget.vendorInfo.website,
                  textAlign: TextAlign.left,
                  style: Constants.bigListSubtitleStyle),
              contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
              minLeadingWidth: 0.0,
            ),
            ListTile( // Vendor phone num
              leading: Icon(Icons.phone_rounded, color: Colors.black,),
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
                    if(widget.vendorInfo.saved) { // Case where vendor is already saved
                      // TODO: Remove a saved vendor
                    }
                    else { // Case where vendor is not saved yet
                      // TODO: Save a vendor
                    }
                  },
                  child: Text(
                      widget.vendorInfo.saved ? 'Remove from Saved' : 'Save Vendor', style: Constants.buttonRedStyle),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Constants.buttonRed),
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 25.0, horizontal: 120.0)),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
