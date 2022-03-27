import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';

class EditPartner extends StatefulWidget {
  const EditPartner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditPartner();
  }
}

class _EditPartner extends State<EditPartner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Partner'),
        backgroundColor: Constants.lightPrimary,
        titleTextStyle: Constants.appBarStyle,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Align(
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
                      labelText: 'Alexa Pear',
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
                      labelText: 'alexa@pear.com',
                      fillColor: Colors.white),
                ),
              ),

              Constants.sectionPadding,
              Constants.formPadding,

              Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      //TODO: Remove partner functionality
                      print("remove partner");
                      Navigator.pop(context);
                    },
                    child: const Text("Remove", style: Constants.buttonRedStyle),
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
                              vertical: 25.0, horizontal: 70.0)),
                    ),
                  ),

                  const Padding(padding: EdgeInsets.only(right: 30)),

                  ElevatedButton(
                    onPressed: () {
                      //TODO: Invite partner functionality
                      print("Invite partner");
                      Navigator.pop(context);
                    },
                    child: const Text("Invite", style: Constants.buttonRedStyle),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Constants.buttonGreen),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 70.0)),
                    ),
                  ),
                ],
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
