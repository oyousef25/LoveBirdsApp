import 'package:flutter/material.dart';
import 'package:lovebirds_app/Budget/create_budget_category.dart';
import 'package:lovebirds_app/Budget/edit_budget_category.dart';
import 'package:lovebirds_app/Budget/view_budget_category.dart';
import 'package:lovebirds_app/helper/BudgetCategoryInfo.dart';
import 'package:pie_chart/pie_chart.dart';

import '../helper/constants.dart';
import 'delete_budget_categories.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  /// Creates a state
  ///
  /// Return the Budget Categories page State
  @override
  State<StatefulWidget> createState() {
    return _BudgetPageState();
  }
}

class _BudgetPageState extends State<BudgetPage> {
  Map<String, double> dataMap = {
    "Food": 5,
    "Venue": 3,
    "Photos": 2,
    "Hummus": 7,
    "Bride": 1,
    "Other": 2,
  };

  String category = ""; //will hold the current category selected

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
          const Padding(padding: EdgeInsets.all(10)),
          PieChart(
            chartLegendSpacing: 20,
            dataMap: dataMap,
            legendOptions: const LegendOptions(
                showLegendsInRow: true,
                showLegends: true,
                legendPosition: LegendPosition.bottom,
                legendTextStyle: Constants.legendTextStyle),
            chartRadius: 170,
            chartValuesOptions: const ChartValuesOptions(
                showChartValuesInPercentage: true,
                chartValueBackgroundColor: Colors.white),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 250,
                ),
                itemCount: dataMap.keys.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Jump to view budget category screen
                      category = dataMap.keys.elementAt(index);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewBudgetCategory(category: category,),
                      ));
                    },
                    child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 30.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.white,
                    shadowColor: Colors.grey,
                    elevation: 5.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(dataMap.keys.elementAt(index),
                            style: Constants.title),
                      ],
                    ),
                    ),
                  );
                }),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add a budget category when FAB is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateBudgetPage()),
          );
        },
        backgroundColor: Constants.lightSecondary,
        child: Icon(
          Icons.add,
          size: 50.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
