import 'package:flutter/material.dart';
import 'package:lovebirds_app/Budget/BudgetCategory.dart';
import '../helper/constants.dart';

class CreateBudgetPage extends StatefulWidget {
  const CreateBudgetPage({Key? key, required this.category}) : super(key: key);

  /// Creates a state
  ///
  /// Return the Create Budget Category page State
  @override
  State<StatefulWidget> createState() {
    return _CreateBudgetPageState();
  }

  final BudgetCategory? category;
}

class _CreateBudgetPageState extends State<CreateBudgetPage> {
  final GlobalKey<FormState> _categoryFormKey = GlobalKey<FormState>();
  Future<BudgetCategory>? _futureCategory;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String category = widget.category?.category ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Budget Category'),
        backgroundColor: Constants.lightPrimary,
        titleTextStyle: Constants.appBarStyle,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: _categoryFormKey,
        child: Container(
          margin:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //form heading
              const Text(
                "Category Name",
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
                  decoration: InputDecoration(
                      floatingLabelBehavior: Constants.floatingLabelBehaviour,
                      border: Constants.outlineInputBorder,
                      labelText: 'Enter a category name',
                      fillColor: Colors.white),
                  onSaved: (String? value) {
                    category = value ?? '';
                  },
                  validator: (String? value) {
                    // Vendor name validation code
                    if (value == null || value.isEmpty) {
                      return 'Task Name cannot be empty';
                    } else if (value.length > Constants.maxTextFieldLength) {
                      return 'Max ${Constants.maxTextFieldLength} characters allowed';
                    }
                    return null;
                  },
                ),
              ),

              const Padding(padding: EdgeInsets.only(bottom: 27)),

              //Create Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_categoryFormKey.currentState!.validate()) {
                      _categoryFormKey.currentState!
                          .save(); // Save all the form field items
                      // Process data.

                      setState(() {
                        // Update task to API
                        _futureCategory = BudgetCategory.createBudgetCategory(
                            category);

                        // Go back to previous page
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: const Text("Create", style: Constants.buttonRedStyle),
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
                            vertical: 25.0, horizontal: 203.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
