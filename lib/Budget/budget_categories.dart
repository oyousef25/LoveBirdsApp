import 'package:flutter/material.dart';
import 'package:lovebirds_app/Budget/BudgetCategory.dart';
import 'package:lovebirds_app/Budget/create_budget_category.dart';
import 'package:lovebirds_app/Budget/view_budget_category.dart';
import 'package:lovebirds_app/Task/Task.dart';
import 'package:pie_chart/pie_chart.dart';

import '../helper/constants.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key, required this.taskList, required this.budgetCategories}) : super(key: key);

  final List<Task> taskList;
  final Map<int, String> budgetCategories;

  /// Creates a state
  ///
  /// Return the Budget Categories page State
  @override
  State<StatefulWidget> createState() {
    return _BudgetPageState();
  }
}

class _BudgetPageState extends State<BudgetPage> {
  late Future<Map<String, double>> futureCategories;

  String category = ""; //will hold the current category selected
  int categoryId = 0; //will hold the current category id selected

  @override
  void initState() {
    super.initState();
    futureCategories = BudgetCategory.fetchBudgetCategoriesMap();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget'),
        backgroundColor: Constants.lightPrimary,
        titleTextStyle: Constants.appBarStyle,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, double>>(
        future: futureCategories,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            dataMap = snapshot.data;
            return Column(
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
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 100,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 8.0,
                            childAspectRatio: 1.5
                      ),
                      itemCount: widget.budgetCategories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            // Jump to view budget category screen
                            category = snapshot.data.keys.elementAt(index);
                            categoryId = widget.budgetCategories.keys.elementAt(index);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewBudgetCategory(
                                categoryString: category, index: index,
                                taskList: widget.taskList,
                                categoryId: categoryId,
                              ),
                            ));
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Colors.white,
                            shadowColor: Colors.grey,
                            elevation: 5.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.budgetCategories.values.elementAt(index),
                                    style: Constants.title),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add a budget category when FAB is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateBudgetPage(category: null)),
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
