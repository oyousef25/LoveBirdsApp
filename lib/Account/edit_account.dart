import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditAccount();
  }
}

class _EditAccount extends State<EditAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Account'),
        backgroundColor: Constants.lightPrimary,
        titleTextStyle: Constants.appBarStyle,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Align(
        //top left aligned
          alignment: const Alignment(-1.0, 1.0),
        //nesting in a container allows for margin on all sides
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
              const Material(
                borderRadius: Constants.borderRadius,
                shadowColor: Constants.formfieldColor,
                elevation: Constants.elevation,
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                      floatingLabelBehavior: Constants.floatingLabelBehaviour,
                      border: Constants.outlineInputBorder,
                      labelText: 'Alex Apple',
                      fillColor: Colors.white),
                ),
              ),

              Constants.sectionPadding,

              const Text(
                "Email",
                textAlign: TextAlign.left,
                style: Constants.sectionHeading,
              ),

              Constants.formPadding,

              const Material(
                borderRadius: Constants.borderRadius,
                shadowColor: Constants.formfieldColor,
                elevation: Constants.elevation,
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                      floatingLabelBehavior: Constants.floatingLabelBehaviour,
                      border: Constants.outlineInputBorder,
                      labelText: 'alex@apple.com',
                      fillColor: Colors.white),
                ),
              ),

              Constants.sectionPadding,

              const Text(
                "Password",
                textAlign: TextAlign.left,
                style: Constants.sectionHeading,
              ),

              Constants.formPadding,

              const Material(
                borderRadius: Constants.borderRadius,
                shadowColor: Constants.formfieldColor,
                elevation: Constants.elevation,
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                      floatingLabelBehavior: Constants.floatingLabelBehaviour,
                      border: Constants.outlineInputBorder,
                      labelText: '*********',
                      fillColor: Colors.white),
                ),
              ),

              Constants.sectionPadding,

              const Text(
                "Role",
                textAlign: TextAlign.left,
                style: Constants.sectionHeading,
              ),

              Constants.formPadding,

              const Material(
                borderRadius: Constants.borderRadius,
                shadowColor: Constants.formfieldColor,
                elevation: Constants.elevation,
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                      floatingLabelBehavior: Constants.floatingLabelBehaviour,
                      border: Constants.outlineInputBorder,
                      labelText: 'Husband',
                      fillColor: Colors.white),
                ),
              ),

              Constants.sectionPadding,

              const Text(
                "Budget",
                textAlign: TextAlign.left,
                style: Constants.sectionHeading,
              ),

              Constants.formPadding,

              const Material(
                borderRadius: Constants.borderRadius,
                shadowColor: Constants.formfieldColor,
                elevation: Constants.elevation,
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                      floatingLabelBehavior: Constants.floatingLabelBehaviour,
                      border: Constants.outlineInputBorder,
                      labelText: "\$20,000",
                      fillColor: Colors.white),
                ),
              ),

              Constants.sectionPadding,

              const Text(
                "Wedding Day",
                textAlign: TextAlign.left,
                style: Constants.sectionHeading,
              ),

              Constants.formPadding,

              const Material(
                borderRadius: Constants.borderRadius,
                shadowColor: Constants.formfieldColor,
                elevation: Constants.elevation,
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        //TODO: Supply Calendar functionality
                        onPressed: null,
                        icon: Icon(Icons.calendar_month_rounded),
                      ),
                      labelText: "25/05/2022",
                      floatingLabelBehavior: Constants.floatingLabelBehaviour,
                      border: Constants.outlineInputBorder,
                      fillColor: Colors.white),
                ),
              ),

              const Padding(padding: EdgeInsets.only(bottom: 27)),

              //Save Changes
              Center(
              child: Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    //TODO: Fix save functionality
                    print("Information has been saved");
                    Navigator.pop(context);
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
                      const EdgeInsets.symmetric(vertical: 20.0, horizontal: 70),
                    ),
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
