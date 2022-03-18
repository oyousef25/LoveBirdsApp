import 'dart:html';

import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/vendorInfo.dart';

class VendorsPage extends StatefulWidget {
  const VendorsPage({Key? key, required this.vendorList}) : super(key: key); // Vendors page key identifier

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
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => VendorScreen(vendorType: 'Venues', vendors: vendorList,),
                            )
                        );
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
                        // Go to vendors page
                        // Go to vendors page
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => VendorScreen(vendorType: 'Bridal Gowns', vendors: vendorList,),
                            )
                        );
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
                        // Go to vendors page
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => VendorScreen(vendorType: 'Photographers', vendors: vendorList,),
                            )
                        );
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
                        // Go to vendors page
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => VendorScreen(vendorType: 'Florists', vendors: vendorList,),
                            )
                        );
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
                        // Go to vendors page
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => VendorScreen(vendorType: 'Gifts', vendors: vendorList,),
                            )
                        );
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

class VendorScreen extends StatefulWidget {
  // In the constructor, require a GuestInfo.
  const VendorScreen({Key? key, required this.vendorType, required this.vendors}) : super(key: key);

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
        title: Text(vendorType,
            style: Constants.appBarStyle
        ),
      ),
      body: ListView.builder( // ListView that is built as it is scrolled onto the screen
        itemCount: widget.vendors.length,
        itemBuilder: (context, index) {
          return Material(
            // margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
            color: Colors.white,
            shadowColor: Colors.grey,
            elevation: 3.0,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.photo, size: 80.0),
              minVerticalPadding: 50.0,
              title: Text(widget.vendors[index].name,
                  textAlign: TextAlign.left,
                  style: Constants.listTitleStyle
              ),
              subtitle: Text(widget.vendors[index].description,
                  textAlign: TextAlign.left,
                  style: Constants.listSubtitleStyle
              ),
              trailing: Icon(Icons.favorite_border_rounded),
              onTap: () { // Open up the Vendor info route
                // Navigator.of(context).push(
                //     MaterialPageRoute(
                //       builder: (context) => GuestDetailsScreen(guestInfo: widget.guestList[index]),
                //     )
                // );
              },
            ),
          );
        },
      ),
    );
  }
}
