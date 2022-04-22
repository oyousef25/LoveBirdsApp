import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lovebirds_app/helper/Account/accountInfo.dart';
import 'package:lovebirds_app/helper/constants.dart';

import 'Task.dart';

class ModifyTask extends StatefulWidget {
  const ModifyTask(
      {Key? key,
      required this.budgetCategories,
      required this.taskInfo,
      required this.accountInfo})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ModifyTask();
  }

  final Map<int, String> budgetCategories;
  final Task? taskInfo;
  final AccountInfo accountInfo;
}

class _ModifyTask extends State<ModifyTask> {
  bool isSwitched = false;
  int? _selectedIndex = 0; // Index of selected chip
  final List<String> _chips = ['Me']; // List of chip options

  final GlobalKey<FormState> _taskFormKey = GlobalKey<FormState>();
  late Future<Task> _futureTask;

  TextEditingController dateEditingController = TextEditingController();
  String taskDueDate = '';

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoDatePicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: child,
          ),
        ));
  }

  @override
  void initState() {
    super.initState();

    // Get the task if given one
    _futureTask = Task.fetchTask(widget.taskInfo?.id ?? -1);

    // If user has a partner then add to the assigned user choice chip
    if(widget.accountInfo.partnerId != null) {
      _chips.add('Partner');
    }
  }

  @override
  Widget build(BuildContext context) {
    int id = widget.taskInfo?.id ?? 0;
    String task = widget.taskInfo?.task ?? '';
    String? dueDate = widget.taskInfo?.dueDate;
    String description = widget.taskInfo?.description ?? '';
    int assignedUser = widget.taskInfo?.spouse ?? widget.accountInfo.id;
    String? cost = widget.taskInfo?.cost;
    int? categoryId = widget.taskInfo?.budgetCategoryId;
    String? categoryValue = widget.budgetCategories[widget.taskInfo?.budgetCategoryId];
    int? isComplete = widget.taskInfo?.isComplete;

    // Create the category map so we can access the category id by type
    List<int> categoryIds = [];
    List<String> categoryTypes = [];
    for (var id in widget.budgetCategories.keys) {
      categoryIds.add(id);
    }
    for (var type in widget.budgetCategories.values) {
      categoryTypes.add(type);
    }
    var categoryMap =
        Map<String, int>.fromIterables(categoryTypes, categoryIds);

    // Get due date
    dateEditingController.text = widget.taskInfo?.dueDate ?? taskDueDate;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.taskInfo == null ? 'Create Task' : 'Edit Task',
        ),
        backgroundColor: Constants.lightPrimary,
        titleTextStyle: Constants.appBarStyle,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<Task>(
          future: _futureTask,
          builder: (context, AsyncSnapshot snapshot) {
            // If the connection is done,
            // check for response data or an error.
            if (snapshot.connectionState == ConnectionState.done) {
              // snapshot.hasError in this case just means the user is adding a custom vendor
              // Because in the case of adding a vendor there is nothing to fetch
              if (snapshot.hasData || snapshot.hasError) {
                return SingleChildScrollView(
                  child: Align(
                    //top left aligned
                    alignment: const Alignment(-1.0, 1.0),

                    //nesting in a container allows for margin on all sides
                    child: Container(
                      margin:
                      const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                      child: Form(
                        key: _taskFormKey,
                        //column which contains all form elements
                        child: Column(
                          //aligning to the left
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //form heading
                            const Text(
                              "Task",
                              textAlign: TextAlign.left,
                              style: Constants.sectionHeading,
                            ),

                            Constants.formPadding,

                            //Textfield
                            Material(
                              borderRadius: Constants.borderRadius,
                              shadowColor: Constants.formfieldColor,
                              elevation: Constants.elevation,
                              color: Colors.white,
                              child: TextFormField(
                                maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                                maxLength: Constants.maxTextFieldLength,
                                initialValue: task,
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                    Constants.floatingLabelBehaviour,
                                    border: Constants.outlineInputBorder,
                                    fillColor: Colors.white),
                                onSaved: (String? value) {
                                  task = value ?? '';
                                },
                                validator: (String? value) {
                                  // Vendor name validation code
                                  if (value == null || value.isEmpty) {
                                    return 'Task Name cannot be empty';
                                  } else if (value.length >
                                      Constants.maxTextFieldLength) {
                                    return 'Max ${Constants.maxTextFieldLength} characters allowed';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            Constants.sectionPadding,

                            const Text(
                              "Due Date",
                              textAlign: TextAlign.left,
                              style: Constants.sectionHeading,
                            ),

                            Constants.formPadding,

                            Material(
                              borderRadius: Constants.borderRadius,
                              shadowColor: Constants.formfieldColor,
                              elevation: Constants.elevation,
                              color: Colors.white,
                              child: TextFormField(
                                controller: dateEditingController,
                                onSaved: (String? value) {
                                  taskDueDate = value!;
                                },
                                onChanged: (String? value) {
                                  taskDueDate = value!;
                                },
                                decoration: InputDecoration(
                                  //calendar functionality goes here
                                    suffixIcon: IconButton(
                                      // Supply Calendar functionality
                                      onPressed: () {
                                        // Set pointer to the end whenever user tries to edit date
                                        dateEditingController.selection = TextSelection.collapsed(offset: dateEditingController.text.length);
                                        _showDialog(
                                          CupertinoDatePicker(
                                              initialDateTime: DateTime.tryParse(dateEditingController.text) ?? DateTime.now(),
                                              mode: CupertinoDatePickerMode.date,
                                              // This is called when the user changes the date.
                                              onDateTimeChanged: (DateTime newDate) {
                                                setState(() {
                                                  taskDueDate = '${newDate.year}-${newDate.month > 9 ? '' : '0'}${newDate.month}-${newDate.day > 9 ? '' : '0'}${newDate.day}';
                                                  dateEditingController.text = taskDueDate;
                                                });
                                              }
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.calendar_month_rounded),
                                    ),
                                    floatingLabelBehavior:
                                    Constants.floatingLabelBehaviour,
                                    border: Constants.outlineInputBorder,
                                    fillColor: Colors.white),
                                validator: (String? value) {
                                  // Date validation
                                  if (value == '' || value == null) {
                                    // Don't bother checking validation if user leaves the date blank
                                    return null;
                                  } else if (!Constants.dateRegex.hasMatch(value)) {
                                    return 'Date format must match YYYY-MM-DD';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            Constants.sectionPadding,

                            const Text(
                              "Description",
                              textAlign: TextAlign.left,
                              style: Constants.sectionHeading,
                            ),

                            Constants.formPadding,

                            Material(
                              borderRadius: Constants.borderRadius,
                              shadowColor: Constants.formfieldColor,
                              elevation: Constants.elevation,
                              color: Colors.white,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                    Constants.floatingLabelBehaviour,
                                    border: Constants.outlineInputBorder,
                                    fillColor: Colors.white),
                                minLines: 1,
                                maxLines: 4,
                                maxLength: Constants.maxTextBoxLength,
                                maxLengthEnforcement: MaxLengthEnforcement
                                    .truncateAfterCompositionEnds,
                                onSaved: (String? value) {
                                  description = value ?? '';
                                },
                                validator: (String? value) {
                                  // Task description validation
                                  if (value == null || value.isEmpty) {
                                    return 'Description cannot be empty';
                                  } else if (value.length >
                                      Constants.maxTextBoxLength) {
                                    return 'Max ${Constants.maxTextBoxLength} characters allowed';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            Constants.sectionPadding,

                            const Text(
                              "Budget Category",
                              textAlign: TextAlign.left,
                              style: Constants.sectionHeading,
                            ),

                            Constants.formPadding,

                            //Drop down of Categories
                            Material(
                              shadowColor: Colors.grey,
                              elevation: 3.0,
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(
                                      left: 12.0, top: 12.0, right: 12.0, bottom: 2.0),
                                ),
                                iconSize: 50.0,
                                value: categoryValue,
                                focusNode:
                                FocusNode(), // Hack to not focus dropdown after selection
                                icon: const Icon(Icons.arrow_drop_down_rounded),
                                elevation: 16,
                                style: Constants.formDropdownStyle,
                                onSaved: (String? value) {
                                  categoryValue = value;
                                  categoryId = categoryMap[categoryValue];
                                },
                                onChanged: (String? newValue) {
                                  setState(() {
                                    categoryValue = newValue!;
                                  });
                                },
                                items: widget.budgetCategories.values.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: Constants.formDropdownStyle,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),

                            Constants.sectionPadding,

                            const Text(
                              "Assigned to",
                              textAlign: TextAlign.left,
                              style: Constants.sectionHeading,
                            ),

                            Constants.formPadding,

                            Wrap(
                                spacing: 30.0,
                                // Creates a list of 2 chips that will highlight the selected ones
                                children: List<Widget>.generate(
                                  2,
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
                                      elevation: 3.0,
                                      selectedColor: Constants.darkSecondary,
                                      onSelected: (bool selected) {
                                        // Toggles selected chip only if the user presses on an unselected chip
                                        if (_selectedIndex != index) {
                                          setState(() {
                                            _selectedIndex = selected ? index : null;
                                            // Set assigned user to user or partner (if partner exists) depending on 0 or 1 index
                                            assignedUser = _selectedIndex == 0 ? widget.accountInfo.id : widget.accountInfo.partnerId!;
                                          });
                                        }
                                      },
                                    );
                                  },
                                ).toList()),

                            Constants.sectionPadding,

                            Text(
                              "Cost (${NumberFormat.simpleCurrency().currencySymbol})",
                              textAlign: TextAlign.left,
                              style: Constants.sectionHeading,
                            ),

                            Constants.formPadding,

                            Row(
                              children: [
                                Expanded(
                                  child: Material(
                                    borderRadius: Constants.borderRadius,
                                    shadowColor: Constants.formfieldColor,
                                    elevation: Constants.elevation,
                                    color: Colors.white,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          floatingLabelBehavior:
                                          Constants.floatingLabelBehaviour,
                                          border: Constants.outlineInputBorder,
                                          fillColor: Colors.white),
                                      onSaved: (String? value) {
                                        cost = value ?? '';
                                      },
                                    ),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.only(right: 10)),
                                Switch(
                                  value: isSwitched,
                                  //TODO: Toggle Switch and enable/disable cost textfield
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched = value;
                                      print(isSwitched);
                                    });
                                  },
                                  activeTrackColor: Colors.lightGreenAccent,
                                  activeColor: Colors.green,
                                ),
                              ],
                            ),

                            const Padding(padding: EdgeInsets.only(bottom: 27)),

                            //Save Button
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Validate will return true if the form is valid, or false if
                                  // the form is invalid.
                                  if (_taskFormKey.currentState!.validate()) {
                                    _taskFormKey.currentState!
                                        .save(); // Save all the form field items
                                    // Process data.

                                    setState(() {
                                      // Update task to API
                                      // _futureTask = Task.createTask(
                                      //     task, dueDate, description, 1, cost, 1);

                                      // Go back to previous page
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                                child:
                                const Text("Create", style: Constants.buttonRedStyle),
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
                                          vertical: 20.0, horizontal: 100.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
