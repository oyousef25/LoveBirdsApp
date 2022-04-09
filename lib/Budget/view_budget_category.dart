import 'package:flutter/material.dart';
import 'package:lovebirds_app/Budget/edit_budget_category.dart';
import 'package:lovebirds_app/helper/constants.dart';

import '../Task/view_task.dart';

class ViewBudgetCategory extends StatefulWidget {
  ViewBudgetCategory({Key? key, required this.category}) : super(key: key);

  final List<String> dueDates = <String>[
    "January 13th, 2022",
    "February 5th, 2022",
    "February 9th, 2022"
  ];
  final List<String> taskNames = <String>[
    "Buy a wedding dress",
    "Buy a tuxedo",
    "Buy Flowers"
  ];
  final List<String> taskPrices = <String>["\$500.00", "\$500.00", "\$150.00"];

  @override
  State<StatefulWidget> createState() {
    return _ViewBudgetCategory();
  }

  final String category;
}

class _ViewBudgetCategory extends State<ViewBudgetCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget'),
        backgroundColor: Constants.lightPrimary,
        titleTextStyle: Constants.appBarStyle,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 15)),
            Card(
              shadowColor: Colors.grey,
              elevation: 5.0,
              margin:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero)),
                      margin: EdgeInsets.zero,
                      color: Constants.lightSecondary,
                      child: ListTile(
                        title: const Text("Budget Category",
                            textAlign: TextAlign.center,
                            style: Constants.cardHeaderStyle),
                        trailing: IconButton(
                          onPressed: () {
                            // Jump to edit screen
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditBudgetPage(category: widget.category,),
                            ));
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      )),

                  //Category
                  Constants.sectionPadding,
                  const Text("Category", style: Constants.taskHeading),
                  Constants.formPadding,
                  Text(widget.category,
                      style: Constants.cardContentStyle),
                  Constants.taskPadding,

                  ElevatedButton(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        titlePadding: EdgeInsets.zero,
                        title: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.zero,
                                    bottomRight: Radius.zero)),
                            margin: EdgeInsets.zero,
                            color: Constants.lightSecondary,
                            child: ListTile(
                              title: Text('Deletion Confirmation',
                                  textAlign: TextAlign.center,
                                  style: Constants.cardHeaderStyle),
                            )),
                        contentPadding: EdgeInsets.only(
                            top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
                        content: Text(
                            'Are you sure you want to delete this category? All tasks that are associated will also be removed.',
                            style: Constants.dialogContentStyle, textAlign: TextAlign.center,),
                        actionsAlignment: MainAxisAlignment.center,
                        // actionsPadding: ,
                        buttonPadding: EdgeInsets.symmetric(horizontal: 25.0),
                        actions: <Widget>[
                          ElevatedButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel',
                                  style: Constants.buttonRedStyle),
                              style: ButtonStyle(
                                shape:
                                MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0)),
                                ),
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    Constants.buttonRed),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 40.0)),
                              )),
                          ElevatedButton(
                            onPressed: () => {
                              // TODO: Delete guest functionality
                              Navigator.pop(context),
                              Navigator.pop(context)
                            },
                            child: const Text('Delete',
                                style: Constants.buttonRedStyle),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Constants.buttonGreen),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(
                                      vertical: 25.0, horizontal: 35.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    child:
                    const Text('Delete', style: Constants.buttonRedStyle),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Constants.buttonRed),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 161.0)),
                    ),
                  ),

                  Constants.formPadding,
                  Constants.taskPadding,
                ],
              ),
            ),

            //the list of tasks (contained in a listview builder)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: widget.taskNames.length,
                itemBuilder: (BuildContext context, int index) {
                  //an individual list item is a card
                  return GestureDetector(
                    //This helps to make the card clickable
                    onTap: () {
                      // Open up the View Task route
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ViewTask()));
                    },

                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 7.0,
                          horizontal: 10.0), // Hack for shrinking card padding
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Colors.white,
                      shadowColor: Colors.grey,
                      elevation: 5.0,

                      //this card contains a row of the labels and widgets that make up a task item
                      child: Row(
                        children: [
                          const Padding(padding: EdgeInsets.only(left: 12)),

                          Expanded(
                            //column containing task name and due date
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
          ],
      ),
    );
  }
}
