import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lovebirds_app/helper/Account/accountInfo.dart';
import 'package:lovebirds_app/helper/constants.dart';

import 'Task.dart';
import 'modify_task.dart';

class ViewTask extends StatefulWidget {
  const ViewTask({Key? key, required this.task, required this.budgetCategoryMap, required this.accountInfo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ViewTask();
  }

  final Task task;
  final Map<int, String> budgetCategoryMap;
  final AccountInfo accountInfo;
}

class _ViewTask extends State<ViewTask> {
  Future<Task>? _futureTask;
  String? budgetCategoryValue;

  @override
  void initState() {
    super.initState();
    _futureTask = Task.fetchTask(widget.task.id);

    budgetCategoryValue =
        widget.budgetCategoryMap[widget.task.budgetCategoryId];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planning'),
        backgroundColor: Constants.lightPrimary,
        titleTextStyle: Constants.appBarStyle,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: FutureBuilder<Task>(
        future: _futureTask,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.only(bottom: 15)),
                  Card(
                    shadowColor: Colors.grey,
                    elevation: 5.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
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
                              // determine if it's the user's task or their partner's task
                              title: Text(widget.task.spouse == widget.accountInfo.id ? 'My Task' : 'Partner Task',
                                  textAlign: TextAlign.center,
                                  style: Constants.cardHeaderStyle),
                              trailing: IconButton(
                                onPressed: () {
                                  // Jump to edit screen
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ModifyTask(
                                        budgetCategories: widget.budgetCategoryMap,
                                        taskInfo: widget.task,
                                        accountInfo: widget.accountInfo)
                                  ));
                                },
                                icon: const Icon(Icons.edit),
                              ),
                            )),

                        //Task Name
                        Constants.sectionPadding,
                        const Text("Task", style: Constants.taskHeading),
                        Constants.formPadding,
                        Text(widget.task.task,
                            style: Constants.cardContentStyle),
                        Constants.taskPadding,

                        //Due Date of Task
                        const Text("Due Date", style: Constants.taskHeading),
                        Constants.formPadding,
                        Text('${widget.task.dueDate}',
                            style: Constants.cardContentStyle),
                        Constants.taskPadding,

                        //Description of Task
                        const Text("Description", style: Constants.taskHeading),
                        Constants.formPadding,
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: Text(
                            widget.task.description,
                            style: Constants.cardContentStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),

                        Constants.taskPadding,

                        //Description of Task
                        const Text("Budget Category",
                            style: Constants.taskHeading),
                        Constants.formPadding,
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: Text(
                            budgetCategoryValue ?? 'None',
                            style: Constants.cardContentStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),

                        Constants.taskPadding,

                        //Cost
                        Text("Cost (${NumberFormat.simpleCurrency().currencySymbol})", style: Constants.taskHeading),
                        Constants.formPadding,
                        Text('${widget.task.cost}',
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
                                  top: 20.0,
                                  bottom: 0.0,
                                  left: 25.0,
                                  right: 25.0),
                              content: Text(
                                  'Are you sure you want to delete this task?',
                                  style: Constants.dialogContentStyle),
                              actionsAlignment: MainAxisAlignment.center,
                              // actionsPadding: ,
                              buttonPadding:
                                  EdgeInsets.symmetric(horizontal: 25.0),
                              actions: <Widget>[
                                ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel',
                                        style: Constants.buttonRedStyle),
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Constants.buttonRed),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.symmetric(
                                                  vertical: 20.0,
                                                  horizontal: 30.0)),
                                    )),
                                ElevatedButton(
                                  onPressed: () => {
                                    setState(() {
                                    _futureTask =
                                        Task.deleteTask(widget.task.id);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    })
                                  },
                                  child: const Text('Delete',
                                      style: Constants.buttonRedStyle),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Constants.buttonGreen),
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.symmetric(
                                                vertical: 20.0,
                                                horizontal: 30.0)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          child: const Text('Delete',
                              style: Constants.buttonRedStyle),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Constants.buttonRed),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 94.0)),
                          ),
                        ),

                        Constants.formPadding,

                        ElevatedButton(
                          onPressed: () => {
                            // TODO: Provide complete functionality
                            Navigator.pop(context),
                          },
                          child: const Text('Complete',
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
                                const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 80.0)),
                          ),
                        ),

                        Constants.taskPadding,
                      ],
                    ),
                  ),
                ],
              ));
            } else if (snapshot.hasError) {
              return Text(
                  "Task was already deleted, please go back and refresh the page");
            }
          }
          // By default, show a loading spinner.
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
