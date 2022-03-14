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
                      Text(
                        "Budget Total",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        "\$20,000",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            color: Constants.darkSecondary),
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
                        Text(
                          "Total Spent",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Text(
                          "\$10,000",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                              color: Constants.darkSecondary),
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
              width: 500,
                child: Container(
                    padding: const EdgeInsets.all(10),

                    //Column for progress bar and labels
                    child: Column(
                      children: [
                        //progress bar
                        const LinearProgressIndicator(
                          value: 0.5,
                          minHeight: 9,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Constants.darkPrimary),
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
                    )))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add a guest when FAB is pressed
        },
        backgroundColor: Constants.lightSecondary,
        child: Icon(Icons.add, size: 50.0),
      ),
    );
  }
}
