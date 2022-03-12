import 'dart:ui';

import 'package:flutter/material.dart';

class PlanningPage extends StatefulWidget {
  const PlanningPage({Key? key}) : super(key: key); // Planning page key identifier

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
        alignment: Alignment(1.0, -1.0),

        //container for the budget overview
        child: Container(
          padding: const EdgeInsets.all(17),
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
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
                          fontWeight: FontWeight.bold, fontSize: 24.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
