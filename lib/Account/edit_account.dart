import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lovebirds_app/helper/Account/updateAccount.dart';
import 'package:lovebirds_app/helper/constants.dart';

import '../helper/Account/accountInfo.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({Key? key, required this.accountInfo}) : super(key: key);

  final AccountInfo accountInfo;

  @override
  State<StatefulWidget> createState() {
    return _EditAccount();
  }
}

class _EditAccount extends State<EditAccount> {
  final _formKey = GlobalKey<FormState>();
  DateTime currentDate = DateTime.now();
  TextEditingController dateEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  // TextEditingController emailEditingController = TextEditingController();
  TextEditingController budgetEditingController = TextEditingController();
  late Future<bool> _futureUpdate;
  String userWeddingDate = '';
  String userName = '';
  // String userEmail = '';
  String userBudget = '';

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
  Widget build(BuildContext context) {
    // Store user id
    int userId = widget.accountInfo.id;

    // Set text to be account's wedding date if userWeddingDate has not been set yet by the form
    // Same with name, email and budget
    dateEditingController.text = userWeddingDate.isNotEmpty ? userWeddingDate : widget.accountInfo.weddingDate;
    nameEditingController.text = userName.isNotEmpty ? userName : widget.accountInfo.name;
    // emailEditingController.text = userEmail.isNotEmpty ? userEmail : widget.accountInfo.email;
    budgetEditingController.text = userBudget.isNotEmpty ? userBudget : widget.accountInfo.budget;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Account'),
        backgroundColor: Constants.lightPrimary,
        titleTextStyle: Constants.appBarStyle,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            //column which contains all form elements
            child: Column(
              //aligning to the left
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //form heading
                const Text(
                  "Name",
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
                    onSaved: (String? value) {
                      userName = value ?? '';
                    },
                    onChanged: (String? value) {
                      userName = value ?? '';
                    },
                    controller: nameEditingController,
                    decoration: InputDecoration(
                        floatingLabelBehavior: Constants.floatingLabelBehaviour,
                        border: Constants.outlineInputBorder,
                        labelText: 'Name',
                        fillColor: Colors.white),
                    validator: (String? value) {
                      // Name validation
                      if (value == null || value.isEmpty) {
                        return 'Name cannot be empty';
                      } else if (value.length > Constants.maxTextFieldLength) {
                        return 'Max ${Constants.maxTextFieldLength} characters allowed';
                      }
                      return null;
                    },
                  ),
                ),

                // Constants.sectionPadding,

                // const Text(
                //   "Email",
                //   textAlign: TextAlign.left,
                //   style: Constants.sectionHeading,
                // ),
                //
                // Constants.formPadding,
                //
                // Material(
                //   borderRadius: Constants.borderRadius,
                //   shadowColor: Constants.formfieldColor,
                //   elevation: Constants.elevation,
                //   color: Colors.white,
                //   child: TextFormField(
                //     maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                //     maxLength: Constants.maxTextFieldLength,
                //     controller: emailEditingController,
                //     onSaved: (String? value) {
                //       userEmail = value ?? '';
                //     },
                //     onChanged: (String? value) {
                //       userEmail = value ?? '';
                //     },
                //     decoration: InputDecoration(
                //         floatingLabelBehavior: Constants.floatingLabelBehaviour,
                //         border: Constants.outlineInputBorder,
                //         labelText: 'sample@example.com',
                //         fillColor: Colors.white),
                //     validator: (String? value) {
                //       // Email validation
                //       if (value == null || value.isEmpty) {
                //         return 'E-mail cannot be empty';
                //       } else if (!Constants.emailRegex.hasMatch(value)) {
                //         return 'Please enter a valid email';
                //       } else if (userEmail.length >=
                //           Constants.maxEmailLength) {
                //         return 'Max ${Constants.maxEmailLength} characters allowed';
                //       }
                //       return null;
                //     },
                //   ),
                // ),

                Constants.sectionPadding,

                const Text(
                  "Budget",
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
                    keyboardType: TextInputType.number,
                    controller: budgetEditingController,
                    maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                    maxLength: Constants.maxTextFieldLength,
                    onSaved: (String? value) {
                      userBudget = value ?? '';
                    },
                    onChanged: (String? value) {
                      userBudget = value ?? '';
                    },
                    decoration: InputDecoration(
                        floatingLabelBehavior: Constants.floatingLabelBehaviour,
                        border: Constants.outlineInputBorder,
                        labelText: "e.g. 9999.99",
                        fillColor: Colors.white),
                    validator: (String? value) {
                      // Budget validation
                      if (double.tryParse(value!) == null) {
                        return 'Please enter a valid number';
                      } else if (double.parse(value) > Constants.maxBudgetSize) {
                        return 'Max budget of ${Constants.maxBudgetSize} allowed';
                      }
                      return null;
                    },
                  ),
                ),

                Constants.sectionPadding,

                const Text(
                  "Wedding Day",
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
                      userWeddingDate = value!;
                    },
                    onChanged: (String? value) {
                      userWeddingDate = value!;
                    },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          // Calendar picker
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
                                    userWeddingDate = '${newDate.year}-${newDate.month > 9 ? '' : '0'}${newDate.month}-${newDate.day > 9 ? '' : '0'}${newDate.day}';
                                    dateEditingController.text = userWeddingDate;
                                  });
                                }
                              ),
                            );
                          },
                          icon: Icon(Icons.calendar_month_rounded),
                        ),
                        labelText: "YYYY-MM-DD",
                        floatingLabelBehavior: Constants.floatingLabelBehaviour,
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

                const Padding(padding: EdgeInsets.only(bottom: 27)),

                //Save Changes
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Make sure all fields are validated before showing the confirmation dialog
                      if (_formKey.currentState!.validate()) {
                        // Update account functionality
                        _futureUpdate =
                            updateAccount(
                                userId,
                                nameEditingController.text,
                                // emailEditingController.text,
                                double.tryParse(budgetEditingController.text),
                                dateEditingController.text);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Apply Changes",
                        style: Constants.buttonRedStyle),
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
                            vertical: 20.0, horizontal: 70),
                      ),
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
