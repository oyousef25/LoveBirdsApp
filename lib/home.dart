import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lovebirds_app/Vendor/savedVendor.dart';

import 'Task/view_task.dart';
import 'Vendor/vendorScreen.dart';
import 'helper/constants.dart';
import 'helper/vendorInfo.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.vendorList})
      : super(key: key); // Home page key identifier

  // Get task information
  final List<String> dueDates = <String>[
    "January 13th, 2022",
    "February 5th, 2022",
    "February 9th, 2022",
    "February 12th, 2022"
  ];
  final List<String> taskNames = <String>[
    "Buy a wedding dress",
    "Buy a tuxedo",
    "Buy flowers",
    "Buy drinks"
  ];
  final List<String> taskPrices = <String>[
    "\$500.00",
    "\$500.00",
    "\$150.00",
    "\$200.00"
  ];

  // Require vendor data to be passed into this Widget
  final List<VendorInfo> vendorList;

  /// Creates a state
  ///
  /// Return the Home page State
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  /// This Widget builds out the Home page
  ///
  /// Given the build [context], return the Home page Widget.
  @override
  Widget build(BuildContext context) {
    final List<VendorInfo> recentlySavedVendors = [];
    // Get a list of the 3 most recently saved vendors
    int savedVendorSize = widget.vendorList.length;
    switch (savedVendorSize) {
      case 1:
        recentlySavedVendors.add(widget.vendorList[0]);
        break;
      case 2:
        recentlySavedVendors.add(widget.vendorList[0]);
        recentlySavedVendors.add(widget.vendorList[1]);
        break;
      default:
        recentlySavedVendors.add(widget.vendorList[savedVendorSize - 1]);
        recentlySavedVendors.add(widget.vendorList[savedVendorSize - 2]);
        recentlySavedVendors.add(widget.vendorList[savedVendorSize - 3]);
    }

    return Scaffold(
      body: NestedScrollView(
        // Setting floatHeaderSlivers to true is required in order to float
        // the outer slivers over the inner scrollable.
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              expandedHeight: 150.0,
              collapsedHeight: 150.0,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: Stack(
                // Image of the vendor (can be cached)
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        const BoxDecoration(), // Need this to preserve container shape
                    child: FittedBox(
                      // clipBehavior: Clip.antiAlias,
                      fit: BoxFit.cover,
                      child: CachedNetworkImage(
                        // Custom tint
                        color: Color.fromRGBO(123, 96, 0, 0.3),
                        colorBlendMode: BlendMode.darken,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        imageUrl:
                            'https://pbs.twimg.com/media/CXzwtfFWMAAdtLa?format=jpg&name=4096x4096',
                      ),
                    ),
                    height: 150.0,
                    width: double.infinity, // Stretch width as much as possible
                  ),
                  ListTile(
                      minVerticalPadding: 40.0,
                      title: Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: Text(
                            '10 days remaining',
                            textAlign: TextAlign.center,
                            style: Constants.homeHeaderStyle,
                          )),
                      subtitle: Text('April 1st, 2022',
                          textAlign: TextAlign.center,
                          style: Constants.homeSubheaderStyle)),
                ],
              ),
            ),
          ];
        },
        body: ListView(
          scrollDirection: Axis.vertical,
          // physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 1300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Budget and guest overview
                  Container(
                    margin: const EdgeInsets.only(
                        top: 15, left: 20, right: 20, bottom: 0),
                    child: const Text(
                      "Overview",
                      style: Constants.title,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Card(
                          shadowColor: Colors.grey,
                          elevation: 5.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            children: const [
                              Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.zero,
                                          bottomRight: Radius.zero)),
                                  margin: EdgeInsets.zero,
                                  color: Constants.lightSecondary,
                                  child: ListTile(
                                    title: Text("Budget",
                                        textAlign: TextAlign.center,
                                        style: Constants.cardHeaderStyle),
                                  )),

                              //Task Name
                              Constants.sectionPadding,
                              Text("\$10,000.00", style: Constants.taskNumber),
                              Constants.formPadding2,
                              Text("remaining",
                                  style: Constants.cardContentStyle2),
                              Constants.sectionPadding,
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          shadowColor: Colors.grey,
                          elevation: 5.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            children: const [
                              Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.zero,
                                          bottomRight: Radius.zero)),
                                  margin: EdgeInsets.zero,
                                  color: Constants.lightSecondary,
                                  child: ListTile(
                                    title: Text("Guests",
                                        textAlign: TextAlign.center,
                                        style: Constants.cardHeaderStyle),
                                  )),

                              //Task Name
                              Constants.sectionPadding,
                              Text("250", style: Constants.taskNumber),
                              Constants.formPadding2,
                              Text("confirmed",
                                  style: Constants.cardContentStyle2),
                              Constants.sectionPadding,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Task overview
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 10),
                    child: const Text(
                      "Next on your to-do list",
                      style: Constants.title,
                    ),
                  ),
                  // The list of tasks (contained in a listview builder)
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      itemCount: widget.taskNames.length,
                      itemBuilder: (BuildContext context, int index) {
                        //an individual list item is a card
                        return GestureDetector(
                          //This helps to make the card clickable
                          onTap: () {
                            // Open up the view task route
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ViewTask()));
                          },

                          child: Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 7.0,
                                horizontal:
                                    10.0), // Hack for shrinking card padding
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Colors.white,
                            shadowColor: Colors.grey,
                            elevation: 5.0,

                            //this card contains a row of the labels and widgets that make up a task item
                            child: Row(
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(left: 12)),

                                Expanded(
                                  //column containing task name and due date
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.only(top: 12)),
                                      Text(widget.taskNames[index],
                                          textAlign: TextAlign.left,
                                          style: Constants.listTitleStyle),
                                      const Padding(
                                          padding: EdgeInsets.only(bottom: 2)),
                                      Text(widget.dueDates[index],
                                          textAlign: TextAlign.left,
                                          style: Constants.listSubtitleStyle),
                                      const Padding(
                                          padding: EdgeInsets.only(bottom: 12)),
                                    ],
                                  ),
                                ),

                                //row containing task price and arrow indicator
                                Row(
                                  children: [
                                    Text(widget.taskPrices[index],
                                        textAlign: TextAlign.right,
                                        style: Constants.taskPrice),
                                    const Icon(Icons.chevron_right_rounded),
                                    const Padding(
                                        padding: EdgeInsets.only(right: 10)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Vendor overview
                  Container(
                    margin: const EdgeInsets.only(
                        top: 15, left: 20, right: 20, bottom: 10),
                    child: const Text(
                      "Explore Vendors",
                      style: Constants.title,
                    ),
                  ),
                  // List of vendor categories
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        Container(
                          width: Constants.exploreWidth,
                          height: Constants.exploreHeight,
                          child: ElevatedButton(
                            onPressed: () {
                              // Go to vendors page
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => VendorScreen(
                                  vendorType: 'Venues',
                                  vendors: widget.vendorList,
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
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                        ),
                        Container(
                          width: Constants.exploreWidth,
                          height: Constants.exploreHeight,
                          child: ElevatedButton(
                            onPressed: () {
                              // Go to vendors page
                              // Go to vendors page
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => VendorScreen(
                                  vendorType: 'Bridal Gowns',
                                  vendors: widget.vendorList,
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
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                        ),
                        Container(
                          width: Constants.exploreWidth,
                          height: Constants.exploreHeight,
                          child: ElevatedButton(
                            onPressed: () {
                              // Go to vendors page
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => VendorScreen(
                                  vendorType: 'Photographers',
                                  vendors: widget.vendorList,
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
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                        ),
                        Container(
                          width: Constants.exploreWidth,
                          height: Constants.exploreHeight,
                          child: ElevatedButton(
                            onPressed: () {
                              // Go to vendors page
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => VendorScreen(
                                  vendorType: 'Florists',
                                  vendors: widget.vendorList,
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
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                        ),
                        Container(
                          width: Constants.exploreWidth,
                          height: Constants.exploreHeight,
                          child: ElevatedButton(
                            onPressed: () {
                              // Go to vendors page
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => VendorScreen(
                                  vendorType: 'Gifts',
                                  vendors: widget.vendorList,
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
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 15, left: 20, right: 20, bottom: 10),
                    child: const Text(
                      "Recently saved vendors",
                      style: Constants.title,
                    ),
                  ),
                  // List of recently saved vendors
                  SizedBox(
                    height: 350,
                    child: SavedVendorScreen(
                      savedVendors: recentlySavedVendors,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
