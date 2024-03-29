import 'package:flutter/material.dart';
import 'package:lovebirds_app/Vendor/vendorCategories.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/vendorInfo.dart';

import 'Vendor/customVendor.dart';
import 'Vendor/modifyVendor.dart';
import 'Vendor/savedVendor.dart';
import 'helper/Account/accountInfo.dart';
import 'helper/Account/fetchAccount.dart';

class VendorsPage extends StatefulWidget {
  const VendorsPage(
      {Key? key})
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
  int currentTab = 0; // Keep track of current tab

  late Future<AccountInfo> _futureAccount;

  // Initialize the tab bar
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_tabIndexChanged);

    // Get the current user's account info
    _futureAccount = fetchAccount();
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
    return FutureBuilder(
        future: _futureAccount,
        // Takes the snapshotted data
        builder: (context, AsyncSnapshot snapshotAccount) {
          // If the data retrieval went wrong
          if (snapshotAccount.hasError) {
            return Center(
              child: Text(
                  'There was an error fetching your account details'),
            );
          } else if (snapshotAccount.hasData) {
            return Scaffold(
              body: Stack(
                children: <Widget>[
                  TabBarView(
                    // Tab bar contents
                    controller: _tabController,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 90.0),
                        child: VendorCategoriesScreen(accountInfo: snapshotAccount.data,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 90.0),
                        child: SavedVendorScreen(accountInfo: snapshotAccount.data,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 90.0),
                        child: CustomVendorScreen(accountInfo: snapshotAccount.data,),
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
                          child: Text('Vendors', style: Constants.tabLabelStyle, textAlign: TextAlign.center,),
                        ),
                        Tab(
                          child: Text('Saved', style: Constants.tabLabelStyle, textAlign: TextAlign.center,),
                        ),
                        Tab(
                          child: Text('My Vendors', style: Constants.tabLabelStyle, textAlign: TextAlign.center,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Show the FAB only on the My Vendors tab
              floatingActionButton: currentTab == 2
                  ? FloatingActionButton(
                onPressed: () {
                  // Go to add guest page
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ModifyVendorScreen(
                      customVendor: null,
                      accountInfo: snapshotAccount.data,
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
          return const CircularProgressIndicator();
        }
    );
  }
}
