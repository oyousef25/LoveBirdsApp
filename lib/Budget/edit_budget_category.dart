import 'package:flutter/material.dart';
import '../helper/constants.dart';

class EditBudgetPage extends StatefulWidget {
  const EditBudgetPage({Key? key}) : super(key: key);

  /// Creates a state
  ///
  /// Return the Edit Budget Category page State
  @override
  State<StatefulWidget> createState() {
    return _EditBudgetPageState();
  }
}

class _EditBudgetPageState extends State<EditBudgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Budget Category'),
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
                    fillColor: Colors.white),
              ),
            ),

            const Padding(padding: EdgeInsets.only(bottom: 27)),

            //Save Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //TODO: Save Budget Category Information
                  print("Budget Category Information has been saved");
                  Navigator.pop(context);
                },
                child:
                const Text("Save", style: Constants.buttonRedStyle),
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
                          vertical: 25.0, horizontal: 209.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
