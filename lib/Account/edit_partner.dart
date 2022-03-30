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
                  children: <Widget> [
                    Expanded(
                      child: ElevatedButton(
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
                                'Are you sure you want to remove your partner Alexa Pear?',
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
                                            vertical: 25.0,
                                            horizontal: 40.0)),
                                  )),
                              ElevatedButton(
                                onPressed: () => {
                                  // TODO: Delete guest functionality
                                  Navigator.pop(context),
                                  Navigator.pop(context)
                                },
                                child: const Text('Confirm',
                                    style: Constants.buttonRedStyle),
                                style: ButtonStyle(
                                  shape:
                                  MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Constants.buttonGreen),
                                  padding:
                                  MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                          vertical: 25.0,
                                          horizontal: 35.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        child: const Text("Remove",
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
                              const EdgeInsets.symmetric(vertical: 25.0)),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 30)),
                    Expanded(
                      child: ElevatedButton(
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
                                  title: Text('Invite Confirmation',
                                      textAlign: TextAlign.center,
                                      style: Constants.cardHeaderStyle),
                                )),
                            contentPadding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 0.0,
                                left: 25.0,
                                right: 25.0),
                            content: Text(
                                'Are you sure you want to invite Alexa Pear as your partner?',
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
                                            vertical: 25.0,
                                            horizontal: 40.0)),
                                  )),
                              ElevatedButton(
                                onPressed: () => {
                                  // TODO: Delete guest functionality
                                  Navigator.pop(context),
                                  Navigator.pop(context)
                                },
                                child: const Text('Confirm',
                                    style: Constants.buttonRedStyle),
                                style: ButtonStyle(
                                  shape:
                                  MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Constants.buttonGreen),
                                  padding:
                                  MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                          vertical: 25.0,
                                          horizontal: 35.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        child: const Text("Invite",
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
                              const EdgeInsets.symmetric(vertical: 25.0)),
                        ),
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
