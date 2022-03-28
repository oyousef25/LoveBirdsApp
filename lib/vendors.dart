import 'dart:html';

import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/vendorInfo.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'helper/customVendorInfo.dart';

class VendorsPage extends StatefulWidget {
  const VendorsPage(
      {Key? key, required this.vendorList, required this.customVendorList})
      : super(key: key); // Vendors page key identifier

  // Require vendor data to be passed into this Widget
  final List<VendorInfo> vendorList;
  final List<CustomVendorInfo> customVendorList;

  /// Creates a state
  ///
  /// Return the Vendors page State
  @override
  State<StatefulWidget> createState() {
    return _VendorsPageState(
        vendorList: vendorList, customVendorList: customVendorList);
  }
}

class _VendorsPageState extends State<VendorsPage>
    with TickerProviderStateMixin {
  // Need a vendor list and custom vendor list
  _VendorsPageState({required this.vendorList, required this.customVendorList});
  final List<VendorInfo> vendorList;
  final List<CustomVendorInfo> customVendorList;

  // Lazy load the tab bar
  late TabController _tabController;
  int currentTab = 0; // Keep track of current tab

  // Initialize the tab bar
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_tabIndexChanged);
  }

  /// Observe when the current tab index changes
  _tabIndexChanged() {
    setState(() => {
          currentTab = _tabController.index,
        });
  }

  /// This Widget builds out the Vendors page
  ///
  /// Given the build [context], return the Vendors page Widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 800.0,
              child: TabBarView(
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
                  Padding(
                    padding: EdgeInsets.only(top: 90.0),
                    child: SavedVendorScreen(
                      savedVendors: vendorList,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 90.0),
                    child: CustomVendorScreen(
                      customVendors: customVendorList,
                    ),
                  ),
                ],
              ),
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
      ),

      // Show the FAB only on the My Vendors tab
      floatingActionButton: currentTab == 2
          ? FloatingActionButton(
              onPressed: () {
                // Go to add guest page
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ModifyVendorScreen(
                    customVendor: null,
                  ),
                ));
              },
              backgroundColor: Constants.lightSecondary,
              child: Icon(
                Icons.add,
                size: 50.0,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}

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

class VendorDetailScreen extends StatefulWidget {
  // In the constructor, require a vendor info.
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
  // In the constructor, require a vendor info.
  _VendorDetailScreenState({required this.vendorInfo});

  // Declare a field that holds the vendor info.
  final VendorInfo vendorInfo;

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
                ListTile(
                  // Vendor name, rating, saved or not saved
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
                  // Vendor hours of operations
                  leading: Icon(
                    Icons.access_time_rounded,
                    color: Colors.black,
                  ),
                  title: Text(widget.vendorInfo.hours,
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
                  title: Text(widget.vendorInfo.website,
                      textAlign: TextAlign.left,
                      style: Constants.bigListSubtitleStyle),
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
                        if (widget.vendorInfo.saved) {
                          // Case where vendor is already saved
                          // TODO: Remove a saved vendor
                        } else {
                          // Case where vendor is not saved yet
                          // TODO: Save a vendor
                        }
                      },
                      child: Text(
                          widget.vendorInfo.saved
                              ? 'Remove from Saved'
                              : 'Save Vendor',
                          style: Constants.buttonRedStyle),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Constants.buttonRed),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 120.0)),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}

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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Go to add guest page
      //     Navigator.of(context).push(MaterialPageRoute(
      //       builder: (context) => ModifyVendorScreen(
      //         customVendor: null,
      //       ),
      //     ));
      //   },
      //   backgroundColor: Constants.lightSecondary,
      //   child: Icon(
      //     Icons.add,
      //     size: 50.0,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}

class CustomVendorDetailScreen extends StatefulWidget {
  // In the constructor, require a custom vendor.
  const CustomVendorDetailScreen({Key? key, required this.customVendor})
      : super(key: key);

  // Declare a field that holds the custom vendor info.
  final CustomVendorInfo customVendor;

  @override
  State createState() {
    return _CustomVendorDetailScreenState(customVendor: customVendor);
  }
}

class _CustomVendorDetailScreenState extends State<CustomVendorDetailScreen> {
  // In the constructor, require a custom vendor.
  _CustomVendorDetailScreenState({required this.customVendor});

  // Declare a field that holds the custom vendors info.
  final CustomVendorInfo customVendor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Vendors'),
        centerTitle: true,
        backgroundColor: Constants.lightPrimary,
        titleTextStyle: Constants.appBarStyle,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.only(bottom: 0)),
          Card(
            shadowColor: Colors.grey,
            elevation: 5.0,
            margin:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  trailing: IconButton(
                    onPressed: () {
                      // Jump to edit screen
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ModifyVendorScreen(customVendor: customVendor),
                      ));
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ),

                // Custom vendor name
                const Text("Vendor", style: Constants.taskHeading),
                Constants.formPadding,
                Text(customVendor.name, style: Constants.cardContentStyle),
                Constants.taskPadding,

                // Custom vendor location
                const Text("Location", style: Constants.taskHeading),
                Constants.formPadding,
                Text(customVendor.location, style: Constants.cardContentStyle),
                Constants.taskPadding,

                // Custom vendor phone number
                const Text("Phone Number", style: Constants.taskHeading),
                Constants.formPadding,
                Text(customVendor.phoneNum, style: Constants.cardContentStyle),
                Constants.taskPadding,

                // Description of custom vendor
                const Text("Description", style: Constants.taskHeading),
                Constants.formPadding,
                Container(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Text(
                    customVendor.description,
                    style: Constants.cardContentStyle,
                    textAlign: TextAlign.center,
                  ),
                ),

                Constants.taskPadding,

                // Type of vendor
                const Text("Vendor Type", style: Constants.taskHeading),
                Constants.formPadding,
                Text(customVendor.vendorType,
                    style: Constants.cardContentStyle),
                Constants.taskPadding,

                // Remove custom vendor button
                ElevatedButton(
                    onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            titlePadding: EdgeInsets.zero,
                            title: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.zero,
                                        bottomRight: Radius.zero)),
                                margin: EdgeInsets.zero,
                                color: Constants.lightSecondary,
                                child: ListTile(
                                  title: Text('Deletion Confirmation',
                                      textAlign: TextAlign.center,
                                      style: Constants.cardHeaderStyle),
                                )),
                            contentPadding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 0.0,
                                left: 25.0,
                                right: 25.0),
                            content: Text(
                                'Are you sure you want to remove the vendor ' +
                                    customVendor.name +
                                    '?',
                                style: Constants.dialogContentStyle),
                            actionsAlignment: MainAxisAlignment.center,
                            buttonPadding:
                                EdgeInsets.symmetric(horizontal: 25.0),
                            actions: <Widget>[
                              ElevatedButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel',
                                      style: Constants.buttonRedStyle),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Constants.buttonRed),
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.symmetric(
                                                vertical: 25.0,
                                                horizontal: 40.0)),
                                  )),
                              ElevatedButton(
                                onPressed: () => {
                                  // TODO: Delete custom vendor functionality
                                  Navigator.pop(context),
                                  Navigator.pop(context)
                                },
                                child: const Text('Confirm',
                                    style: Constants.buttonRedStyle),
                                style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Constants.buttonGreen),
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.symmetric(
                                              vertical: 25.0,
                                              horizontal: 35.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                    child: Text('Delete', style: Constants.buttonRedStyle),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Constants.buttonRed),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 150.0)),
                    )),

                Constants.taskPadding,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ModifyVendorScreen extends StatefulWidget {
  const ModifyVendorScreen({Key? key, required this.customVendor})
      : super(key: key);

  // Will be null if adding a guest
  // Otherwise it will contain the guest info to edit.
  final CustomVendorInfo? customVendor;

  @override
  State<StatefulWidget> createState() {
    return _ModifyVendorState();
  }
}

class _ModifyVendorState extends State<ModifyVendorScreen> {
  /// Form key for validation of custom vendor form
  final GlobalKey<FormState> _vendorFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Populate the custom vendor info text, if any
    CustomVendorInfo? customVendor = widget.customVendor;
    CustomVendorInfo customVendorTextValue =
        CustomVendorInfo('', '', '', '', ''); // Default
    if (customVendor != null) {
      // Make sure custom vendor info exists
      customVendorTextValue = customVendor;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.lightPrimary,
        centerTitle: true,
        title: Text(
            widget.customVendor == null ? 'Create Vendor' : 'Edit Vendor',
            style: Constants.appBarStyle),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            // New guest form
            key: _vendorFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),

                // Form heading
                const Text(
                  "Vendor",
                  textAlign: TextAlign.left,
                  style: Constants.sectionHeading,
                ),

                Constants.formPadding,

                /// Custom vendor name
                Material(
                  shadowColor: Colors.grey,
                  elevation: 3.0,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: TextFormField(
                    initialValue: customVendorTextValue.name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Enter a name (ie. Caboto Club)",
                      hintStyle: Constants.formHintStyle,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Name cannot be empty';
                      }
                      // TODO: Vendor name validation code
                      return null;
                    },
                  ),
                ),

                Constants.sectionPadding,

                // Form heading
                const Text(
                  "Location",
                  textAlign: TextAlign.left,
                  style: Constants.sectionHeading,
                ),

                Constants.formPadding,

                /// Custom vendor location
                Material(
                  shadowColor: Colors.grey,
                  elevation: 3.0,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: TextFormField(
                    initialValue: customVendorTextValue.location,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Enter a location (ie. Windsor, ON)',
                      hintStyle: Constants.formHintStyle,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Location cannot be empty';
                      }
                      // TODO: Location validation code
                      return null;
                    },
                  ),
                ),

                Constants.sectionPadding,

                // Form heading
                const Text(
                  "Phone Number",
                  textAlign: TextAlign.left,
                  style: Constants.sectionHeading,
                ),

                Constants.formPadding,

                /// Custom vendor phone number
                Material(
                  shadowColor: Colors.grey,
                  elevation: 3.0,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: TextFormField(
                    initialValue: customVendorTextValue.phoneNum,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: '(123)456-7890',
                      hintStyle: Constants.formHintStyle,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number cannot be empty';
                      }
                      // TODO: Phone number validation code
                      return null;
                    },
                  ),
                ),

                Constants.sectionPadding,

                // Form heading
                const Text(
                  "E-mail",
                  textAlign: TextAlign.left,
                  style: Constants.sectionHeading,
                ),

                Constants.formPadding,

                /// Custom vendor description
                Material(
                  shadowColor: Colors.grey,
                  elevation: 3.0,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: TextFormField(
                    minLines: 2,
                    maxLines: 4,
                    maxLength: 255,
                    initialValue: customVendorTextValue.description,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Enter a brief description of the vendor',
                      hintStyle: Constants.formHintStyle,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Description cannot be empty';
                      }
                      // TODO: Vendor description validation code
                      return null;
                    },
                  ),
                ),

                Constants.sectionPadding,

                // Form heading
                const Text(
                  "Phone Number",
                  textAlign: TextAlign.left,
                  style: Constants.sectionHeading,
                ),

                Constants.formPadding,

                /// Custom vendor type
                Material(
                  shadowColor: Colors.grey,
                  elevation: 3.0,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: TextFormField(
                    initialValue: customVendorTextValue.vendorType,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Enter the type of vendor (e.g. Hair Salon)',
                      hintStyle: Constants.formHintStyle,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Vendor type cannot be empty';
                      }
                      // TODO: Vendor type validation code
                      return null;
                    },
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: ElevatedButton(
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_vendorFormKey.currentState!.validate()) {
                            // Process data.
                            if (widget.customVendor == null) {
                              // Case where adding a custom vendor
                              // TODO: Add a custom vendor
                            } else {
                              // Case where editing a custom vendor
                              // TODO: Edit a custom vendor
                            }
                          }
                        },
                        child: Text(
                            widget.customVendor == null ? 'Create' : 'Save',
                            style: Constants.buttonRedStyle),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Constants.buttonRed),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 150.0)),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
