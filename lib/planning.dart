import 'package:flutter/material.dart';
import 'package:lovebirds_app/Budget/BudgetCategory.dart';
import 'package:lovebirds_app/Task/BudgetDetails.dart';
import 'package:lovebirds_app/Task/create_task.dart';
import 'package:lovebirds_app/helper/constants.dart';

import 'Budget/budget_categories.dart';
import 'Task/view_task.dart';
import 'Task/Task.dart';
import 'helper/Account/accountInfo.dart';
import 'helper/Account/fetchAccount.dart';

class PlanningPage extends StatefulWidget {
  PlanningPage({Key? key}) : super(key: key); // Planning page key identifier

  /// Creates a state
  ///
  /// Return the Planning page State
  @override
  State<StatefulWidget> createState() {
    return _PlanningPageState();
  }
}

class _PlanningPageState extends State<PlanningPage> {
  int? _selectedIndex = 0; // Index of selected chip
  final List<String> _chips = ['Me', 'Partner', 'All']; // List of chip options
  late Future<AccountInfo> _futureAccount;
  late Future<BudgetDetails> _futureBudget;
  late Future<List<Task>> _futureTasks;
  late Future<List<BudgetCategory>> _futureCategories;

  Map<String, double> dataMap = {
    "Food": 5,
    "Venue": 3,
    "Photos": 2,
    "Hummus": 7,
    "Bride": 1,
    "Other": 2,
  };

  @override
  void initState() {
    super.initState();

    // Get the current user's account info
    _futureAccount = fetchAccount();
  }

  /// This Widget builds out the Planning page
  ///
  /// Given the build [context], return the Planning page Widget.
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
            // Fetch the budget details after account is confirmed
            _futureBudget = BudgetDetails.fetchBudget(snapshotAccount.data.email);

            return FutureBuilder(
                future: _futureBudget,
                // Takes the snapshotted data
                builder: (context, AsyncSnapshot snapshotBudget) {
                  // If the data retrieval went wrong
                  if (snapshotBudget.hasError) {
                    return Center(
                      child: Text(
                          'There was an error fetching your budget details: ${snapshotBudget.error}'),
                    );
                  } else if (snapshotBudget.hasData) {
                    // Fetch the tasks after account and budget is confirmed
                    _futureTasks =
                        Task.fetchAllTasks(snapshotAccount.data.email);

                    // Calculate budget progress, taking care of divide by zero case
                    double budgetProgressValue = 0;
                    if(snapshotBudget.data.budgetTotal > 0) {
                      budgetProgressValue = snapshotBudget.data.totalSpent / snapshotBudget.data.budgetTotal;
                    }

                    return FutureBuilder(
                        future: _futureTasks,
                        builder: (context, AsyncSnapshot snapshotTasks) {
                          if (snapshotTasks.hasError) {
                            return Center(
                              child: Text(
                                  'There was an error fetching your tasks'),
                            );
                          } else if (snapshotTasks.hasData) {
                            return Scaffold(
                              body: Align(
                                //top center aligned
                                alignment: const Alignment(1.0, -1.0),

                                //column which contains budget overview, progress bar and tasks list
                                child: Column(
                                  children: [
                                    //container for the budget overview
                                    Row(
                                      children: [
                                        //Budget Total Overview
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              // TODO: Add a budget category when FAB is pressed
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const BudgetPage()),
                                              );
                                            },
                                            child: Card(
                                              margin: const EdgeInsets
                                                      .symmetric(
                                                  vertical: 15.0,
                                                  horizontal:
                                                      25.0), // Hack for shrinking card padding
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              color: Constants.lightSecondary,
                                              child: Column(
                                                children: [
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 20)),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Text("Budget Total",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              Constants.title),
                                                    ],
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 5)),
                                                  Text(
                                                    '\$${snapshotBudget.data.budgetTotal}',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        Constants.budgetExpense,
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 20)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        //Total Spent Overview
                                        Expanded(
                                          child: Card(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal:
                                                    25.0), // Hack for shrinking card padding
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            color: Constants.lightSecondary,
                                            child: Column(
                                              children: [
                                                const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 20)),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Text("Total Spent",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Constants.title),
                                                  ],
                                                ),
                                                const Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 5)),
                                                Text(
                                                  "\$${snapshotBudget.data.totalSpent}",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      Constants.budgetExpense,
                                                ),
                                                const Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 20)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const Text(
                                      "Great! You are under budget!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0),
                                    ),

                                    //progress bar container (in a fixed width using sized box)
                                    SizedBox(
                                      width: 450,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),

                                        //Column for progress bar and labels
                                        child: Column(
                                          children: [
                                            //progress bar
                                            LinearProgressIndicator(
                                              value: budgetProgressValue,
                                              minHeight: 9,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Constants.darkPrimary),
                                              backgroundColor:
                                                  Constants.lightPrimary,
                                            ),

                                            //row containing budget remaining labels
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "TOTAL REMAINING",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15.0,
                                                        color: Constants
                                                            .mediumPrimary),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Text("\$${snapshotBudget.data.budgetTotal - snapshotBudget.data.totalSpent}",
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18.0,
                                                            color:
                                                                Colors.black)))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),

                                    Wrap(
                                        spacing: 30.0,
                                        // Creates a list of 3 chips that will highlight the selected ones
                                        children: List<Widget>.generate(
                                          3,
                                          (int index) {
                                            return ChoiceChip(
                                              label: Text(_chips[index]),
                                              labelStyle: _selectedIndex ==
                                                      index
                                                  ? Constants.chipSelectedStyle
                                                  : Constants
                                                      .chipUnselectedStyle,
                                              selected: _selectedIndex ==
                                                  index, // If selected index IS the index then it is selected
                                              backgroundColor: Colors.white,
                                              shadowColor: Colors.grey,
                                              elevation: 2.0,
                                              selectedColor:
                                                  Constants.darkSecondary,
                                              onSelected: (bool selected) {
                                                // Toggles selected chip only if the user presses on an unselected chip
                                                if (_selectedIndex != index) {
                                                  setState(() {
                                                    _selectedIndex =
                                                        selected ? index : null;
                                                  });
                                                }
                                              },
                                            );
                                          },
                                        ).toList()),

                                    //the list of tasks (contained in a listview builder)
                                    Expanded(
                                      child: ListView.builder(
                                        padding: const EdgeInsets.all(15),
                                        itemCount: snapshotTasks.data.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          //an individual list item is a card
                                          return GestureDetector(
                                            //This helps to make the card clickable
                                            onTap: () {
                                              // Open up the View Task route
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewTask(
                                                              task:
                                                                  snapshotTasks
                                                                          .data[
                                                                      index])));
                                            },

                                            child: Card(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 7.0,
                                                      horizontal: 10.0),
                                              // Hack for shrinking card padding
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              color: Colors.white,
                                              shadowColor: Colors.grey,
                                              elevation: 5.0,

                                              //this card contains a row of the labels and widgets that make up a task item
                                              child: Row(
                                                children: [
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 12)),

                                                  Expanded(
                                                    //column containing task name and due date
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 12)),
                                                        Text(
                                                            snapshotTasks
                                                                .data[index]
                                                                .task,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: Constants
                                                                .listTitleStyle),
                                                        const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 2)),
                                                        Text(
                                                            snapshotTasks
                                                                .data[index]
                                                                .dueDate,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: Constants
                                                                .listSubtitleStyle),
                                                        const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        12)),
                                                      ],
                                                    ),
                                                  ),

                                                  //row containing task price and arrow indicator
                                                  Row(
                                                    children: [
                                                      Text(
                                                          "\$" +
                                                              snapshotTasks
                                                                  .data[index]
                                                                  .cost,
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: Constants
                                                              .taskPrice),
                                                      const Icon(Icons
                                                          .chevron_right_rounded),
                                                      const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 10)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              floatingActionButton: FloatingActionButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateTask(
                                              dataMap: dataMap,
                                              task: null,
                                            )),
                                  );
                                },
                                backgroundColor: Constants.lightSecondary,
                                foregroundColor: Colors.white,
                                child: const Icon(Icons.add, size: 50.0),
                              ),
                            );
                          }
                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        });
                  }
                  return const CircularProgressIndicator();
                });
          }
          return const CircularProgressIndicator();
        });
  }
}
