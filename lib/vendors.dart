import 'dart:html';

import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';

class VendorsPage extends StatefulWidget {
  const VendorsPage({Key? key})
      : super(key: key); // Vendors page key identifier

  /// Creates a state
  ///
  /// Return the Vendors page State
  @override
  State<StatefulWidget> createState() {
    return _VendorsPageState();
  }
}

class _VendorsPageState extends State<VendorsPage>
    with TickerProviderStateMixin {
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
                        // TODO: Go to vendors page
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Constants.lightSecondary),
                        // padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 40.0, horizontal: 150.0)),
                      ),
                      child: Text('Venues',
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
                        // TODO: Go to vendors page
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Constants.lightSecondary),
                        // padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 40.0, horizontal: 150.0)),
                      ),
                      child: Text('Bridal Gowns',
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
                        // TODO: Go to vendors page
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Constants.lightSecondary),
                        // padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 40.0, horizontal: 150.0)),
                      ),
                      child: Text('Photographers',
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
                        // TODO: Go to vendors page
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Constants.lightSecondary),
                        // padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 40.0, horizontal: 150.0)),
                      ),
                      child: Text('Florists',
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
                        // TODO: Go to vendors page
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Constants.lightSecondary),
                        // padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 40.0, horizontal: 150.0)),
                      ),
                      child: Text('Gifts',
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

class VendorScreen extends StatelessWidget {
  // In the constructor, require a GuestInfo.
  const VendorScreen({Key? key, required this.vendorType}) : super(key: key);

  // Declare a field that holds the vendor type.
  final String vendorType;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
