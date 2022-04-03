import 'package:flutter/material.dart';
import '../helper/constants.dart';

class CreateBudgetPage extends StatefulWidget {
  const CreateBudgetPage({Key? key}) : super(key: key);

  /// Creates a state
  ///
  /// Return the Budget Categories page State
  @override
  State<StatefulWidget> createState() {
    return _CreateBudgetPageState();
  }
}

class _CreateBudgetPageState extends State<CreateBudgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Budget Category'),
        backgroundColor: Constants.lightPrimary,
        titleTextStyle: Constants.appBarStyle,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Container(
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
          const Material(
            borderRadius: Constants.borderRadius,
            shadowColor: Constants.formfieldColor,
            elevation: Constants.elevation,
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                  floatingLabelBehavior: Constants.floatingLabelBehaviour,
                  border: Constants.outlineInputBorder,
                  labelText: 'Enter a category name',
                  fillColor: Colors.white),
            ),
          ),

          const Padding(padding: EdgeInsets.only(bottom: 27)),

          //Create Button
          Center(
            child: ElevatedButton(
              onPressed: () {
                //TODO: Save Budget Category Information
                print("Information has been saved");
                Navigator.pop(context);
              },
              child:
              const Text("Create", style: Constants.buttonRedStyle),
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

      floatingActionButton: FloatingActionButton(
        onPressed: null,
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
