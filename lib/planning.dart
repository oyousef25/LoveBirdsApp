import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';

class PlanningPage extends StatefulWidget {
  const PlanningPage({Key? key})
      : super(key: key); // Planning page key identifier

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
  final List<String> _chips = ['All', 'To Do', 'Done']; // List of chip options

  /// This Widget builds out the Planning page
  ///
  /// Given the build [context], return the Planning page Widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        //top center aligned
        alignment: const Alignment(1.0, -1.0),

        //column which contains budget overview, progress bar and tasks list
        child: Column(
          children: [
            //container for the budget overview
            Container(
              padding: const EdgeInsets.all(20),
              child: IntrinsicHeight(
                //row containing overview texts and vertical divider
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Budget Total Overview
                    Column(children: const [
                      Text("Budget Total",
                          textAlign: TextAlign.center, style: Constants.title),
                      Text(
                        "\$20,000",
                        textAlign: TextAlign.center,
                        style: Constants.budgetExpense,
                      ),
                    ]),

                    //Vertical Divider
                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 1.3,
                      width: 20,
                      indent: 7,
                    ),

                    //Total Spent Overview
                    Column(
                      children: const [
                        Text("Total Spent",
                            textAlign: TextAlign.center,
                            style: Constants.title),
                        Text(
                          "\$10,000",
                          textAlign: TextAlign.center,
                          style: Constants.budgetExpense,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Text(
              "Great! You are under budget!",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
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
                    const LinearProgressIndicator(
                      value: 0.5,
                      minHeight: 9,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Constants.darkPrimary),
                      backgroundColor: Constants.lightPrimary,
                    ),

                    //row containing labels
                    Row(
                      children: const [
                        Expanded(
                          child: Text(
                            "TOTAL REMAINING",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Constants.mediumPrimary),
                          ),
                        ),
                        Expanded(
                            child: Text("\$10,000",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Colors.black)))
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Wrap(
                  spacing: 30.0,
                  // Creates a list of 3 chips that will highlight the selected ones
                  children: List<Widget>.generate(
                    3,
                    (int index) {
                      return ChoiceChip(
                        label: Text(_chips[index]),
                        labelStyle: _selectedIndex == index
                            ? Constants.chipSelectedStyle
                            : Constants.chipUnselectedStyle,
                        selected: _selectedIndex ==
                            index, // If selected index IS the index then it is selected
                        backgroundColor: Colors.white,
                        shadowColor: Colors.grey,
                        elevation: 2.0,
                        selectedColor: Constants.darkSecondary,
                        onSelected: (bool selected) {
                          // Toggles selected chip only if the user presses on an unselected chip
                          if (_selectedIndex != index) {
                            setState(() {
                              _selectedIndex = selected ? index : null;
                            });
                          }
                        },
                      );
                    },
                  ).toList()),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add a task when FAB is pressed
        },
        backgroundColor: Constants.lightSecondary,
        child: Icon(Icons.add, size: 50.0),
      ),
    );
  }
}
