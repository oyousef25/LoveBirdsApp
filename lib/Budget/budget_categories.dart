import 'package:flutter/material.dart';
import 'package:lovebirds_app/Budget/BudgetCategory.dart';
import 'package:lovebirds_app/Budget/create_budget_category.dart';
import 'package:lovebirds_app/Budget/view_budget_category.dart';
import 'package:lovebirds_app/Task/Task.dart';
import 'package:lovebirds_app/helper/Account/accountInfo.dart';
import 'package:pie_chart/pie_chart.dart';

import '../helper/constants.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key,
    required this.taskList, required this.budgetCategories,
    required this.accountInfo, required this.currentChip}) : super(key: key);

  final List<Task> taskList;
  final Map<int, String> budgetCategories;
  final AccountInfo accountInfo;
  final int currentChip;

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

  String title = '';

  String category = ""; //will hold the current category selected
  int? categoryId; //will hold the current category id selected

  Map<int, List<int>> numOfTasksInEachCategory = {};
  Map<String, double> dataMap = {};

  @override
  void initState() {
    super.initState();
    futureCategories = BudgetCategory.fetchBudgetCategoriesMap();

    /// Hack for populating the datamap
    // Populate the categories
    for(int id in widget.budgetCategories.keys) {
      numOfTasksInEachCategory[id] = [];
    }
    // Populate the tasks in the categories
    for(Task task in widget.taskList) {
      int? validId = task.budgetCategoryId;
      if(validId != null) {
        numOfTasksInEachCategory[validId]?.add(1);
      }
    }
    // Now populate the datamap used for the pie chart
    for(int id in widget.budgetCategories.keys) {
      dataMap[widget.budgetCategories[id]!] = numOfTasksInEachCategory[id]!.length * 1.0;
    }

    // Title based on current person
    switch(widget.currentChip) {
      case 0:
        title = 'Budget (Me)';
        break;
      case 1:
        title = "Budget (Partner)";
        break;
      default:
        title = "Budget (All)";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Constants.lightPrimary,
        titleTextStyle: Constants.appBarStyle,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, double>>(
        future: futureCategories,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
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
                            category = widget.budgetCategories.values.elementAt(index);
                            categoryId = widget.budgetCategories.keys.elementAt(index);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewBudgetCategory(
                                categoryString: category, index: index,
                                taskList: widget.taskList,
                                categoryId: categoryId,
                                categoryMap: widget.budgetCategories,
                                accountInfo: widget.accountInfo,
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
