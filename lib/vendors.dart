import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/vendorInfo.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'Vendor/customVendor.dart';
import 'Vendor/modifyVendor.dart';
import 'Vendor/savedVendor.dart';
import 'Vendor/vendorScreen.dart';
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
