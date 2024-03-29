import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lovebirds_app/Task/Task.dart';
import 'package:lovebirds_app/Vendor/savedVendor.dart';
import 'package:lovebirds_app/planning.dart';

import 'Task/BudgetDetails.dart';
import 'Task/view_task.dart';
import 'Vendor/vendorScreen.dart';
import 'helper/Account/accountInfo.dart';
import 'helper/constants.dart';
import 'helper/Account/fetchAccount.dart';
import 'helper/vendorInfo.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key); // Home page key identifier

  /// Creates a state
  ///
  /// Return the Home page State
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late Future<AccountInfo> _futureAccount;
  late Future<List<Task>> _futureTasks;
  late Future<BudgetDetails> _futureBudget;

  // Reload the tasks with new data
  refreshPage(String userEmail) {
    _futureTasks = Task.fetchAllUserTasks(userEmail);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    // Get the current user's account info
    _futureAccount = fetchAccount();
  }

  /// This Widget builds out the Home page
  ///
  /// Given the build [context], return the Home page Widget.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureAccount,
        // Takes the snapshotted data
        builder: (context, AsyncSnapshot snapshotAccount) {
          // If the data retrieval went wrong
          if (snapshotAccount.hasError) {
            return Center(
              child: Text('There was an error fetching your account details'),
            );
          } else if (snapshotAccount.hasData) {
            DateFormat weddingDateFormatter = DateFormat.yMMMMd();
            DateTime? weddingDateTime =
                DateTime.tryParse(snapshotAccount.data.weddingDate);
            Duration timeTilWedding = Duration.zero;
            String prettyWeddingDate = '';
            String prettyDaysRemaining = '';
            if (weddingDateTime != null) {
              // Format the wedding date and calculate the days remaining
              timeTilWedding = weddingDateTime.difference(DateTime.now());
              prettyWeddingDate = weddingDateFormatter.format(weddingDateTime);
            }
            if (timeTilWedding == Duration.zero) {
              prettyDaysRemaining = 'Set wedding date in Account page';
            } else {
              prettyDaysRemaining = '${timeTilWedding.inDays} days remaining';
            }

            // Fetch the budget details
            _futureBudget =
                BudgetDetails.fetchBudget(snapshotAccount.data.email);

            return Scaffold(
              body: NestedScrollView(
                // Setting floatHeaderSlivers to true is required in order to float
                // the outer slivers over the inner scrollable.
                floatHeaderSlivers: true,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
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
                            width: double
                                .infinity, // Stretch width as much as possible
                          ),
                          ListTile(
                              minVerticalPadding: 40.0,
                              title: Padding(
                                  padding: EdgeInsets.only(bottom: 15.0),
                                  child: Text(
                                    prettyDaysRemaining,
                                    textAlign: TextAlign.center,
                                    style: Constants.homeHeaderStyle,
                                  )),
                              subtitle: Text(prettyWeddingDate,
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
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Column(
                                    children: [
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
                                            title: Text(
                                                "Budget (${NumberFormat.simpleCurrency().currencySymbol})",
                                                textAlign: TextAlign.center,
                                                style:
                                                    Constants.cardHeaderStyle),
                                          )),

                                      //Task Name
                                      Constants.sectionPadding,
                                      Text('${snapshotAccount.data.budget}',
                                          style: Constants.taskNumber),
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
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Column(
                                    children: [
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
                                                style:
                                                    Constants.cardHeaderStyle),
                                          )),

                                      //Task Name
                                      Constants.sectionPadding,
                                      Text(
                                          "${snapshotAccount.data.totalGuests}",
                                          style: Constants.taskNumber),
                                      Constants.formPadding2,
                                      Text("total",
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
                            height: 200,
                            child: FutureBuilder(
                                future: _futureBudget,
                                // Takes the snapshotted data
                                builder:
                                    (context, AsyncSnapshot snapshotBudget) {
                                  // If the data retrieval went wrong
                                  if (snapshotBudget.hasError) {
                                    return Center(
                                      child: Text(
                                          'There was an error fetching your budget details: ${snapshotBudget.error}'),
                                    );
                                  } else if (snapshotBudget.hasData) {
                                    // Fetch all of the user's tasks
                                    _futureTasks = Task.fetchAllUserTasks(
                                        snapshotAccount.data.email);

                                    return FutureBuilder(
                                        future: _futureTasks,
                                        builder: (context,
                                            AsyncSnapshot snapshotTasks) {
                                          if (snapshotTasks.hasError) {
                                            return Center(
                                              child: Text(
                                                  'There was an error fetching your tasks'),
                                            );
                                          } else if (snapshotTasks.hasData) {
                                            return RefreshIndicator(
                                              onRefresh: () async => {
                                                // Refresh the tasks list
                                                refreshPage(snapshotAccount.data.email),
                                              },
                                              child: ListView.builder(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                itemCount:
                                                    snapshotTasks.data.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  //an individual list item is a card
                                                  return GestureDetector(
                                                    //This helps to make the card clickable
                                                    onTap: () {
                                                      // Open up the view task route
                                                      Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (context) => ViewTask(
                                                              task:
                                                                  snapshotTasks
                                                                          .data[
                                                                      index],
                                                              budgetCategoryMap:
                                                                  snapshotBudget
                                                                      .data
                                                                      .budgetCategories,
                                                              accountInfo:
                                                                  snapshotAccount
                                                                      .data)));
                                                    },

                                                    child: Card(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 7.0,
                                                          horizontal:
                                                              10.0), // Hack for shrinking card padding
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                      color: Colors.white,
                                                      shadowColor: Colors.grey,
                                                      elevation: 5.0,

                                                      //this card contains a row of the labels and widgets that make up a task item
                                                      child: Row(
                                                        children: [
                                                          const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          12)),

                                                          Expanded(
                                                            //column containing task name and due date
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                12)),
                                                                Text(
                                                                    snapshotTasks
                                                                        .data[
                                                                            index]
                                                                        .task,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: Constants
                                                                        .listTitleStyle),
                                                                const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        bottom:
                                                                            2)),
                                                                Text(
                                                                    snapshotTasks
                                                                        .data[
                                                                            index]
                                                                        .dueDate,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: Constants
                                                                        .listSubtitleStyle),
                                                                const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        bottom:
                                                                            12)),
                                                              ],
                                                            ),
                                                          ),

                                                          //row containing task price and arrow indicator
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  snapshotTasks
                                                                      .data[
                                                                          index]
                                                                      .cost,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style: Constants
                                                                      .taskPrice),
                                                              const Icon(Icons
                                                                  .chevron_right_rounded),
                                                              const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              10)),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        });
                                  }
                                  return Center(
                                      child: CircularProgressIndicator());
                                }),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                ),
                                Container(
                                  width: Constants.exploreWidth,
                                  height: Constants.exploreHeight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Go to vendors page
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => VendorScreen(
                                          vendorType: Constants.venueCategory,
                                          accountInfo: snapshotAccount.data,
                                        ),
                                      ));
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                ),
                                Container(
                                  width: Constants.exploreWidth,
                                  height: Constants.exploreHeight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Go to vendors page
                                      // Go to vendors page
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => VendorScreen(
                                          vendorType: Constants.gownCategory,
                                          accountInfo: snapshotAccount.data,
                                        ),
                                      ));
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                ),
                                Container(
                                  width: Constants.exploreWidth,
                                  height: Constants.exploreHeight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Go to vendors page
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => VendorScreen(
                                          vendorType: Constants.photoCategory,
                                          accountInfo: snapshotAccount.data,
                                        ),
                                      ));
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                ),
                                Container(
                                  width: Constants.exploreWidth,
                                  height: Constants.exploreHeight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Go to vendors page
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => VendorScreen(
                                          vendorType: Constants.floristCategory,
                                          accountInfo: snapshotAccount.data,
                                        ),
                                      ));
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                ),
                                Container(
                                  width: Constants.exploreWidth,
                                  height: Constants.exploreHeight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Go to vendors page
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => VendorScreen(
                                          vendorType: Constants.giftCategory,
                                          accountInfo: snapshotAccount.data,
                                        ),
                                      ));
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
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
                            height: 250,
                            child: SavedVendorScreen(
                              accountInfo: snapshotAccount.data,
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
          return const CircularProgressIndicator();
        });
  }
}
