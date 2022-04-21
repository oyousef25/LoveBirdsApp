import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/Account/invitePartner.dart';
import 'package:lovebirds_app/helper/constants.dart';

import '../helper/Account/accountInfo.dart';

class EditPartner extends StatefulWidget {
  const EditPartner({Key? key, required this.accountInfo}) : super(key: key);

  final AccountInfo accountInfo;

  @override
  State<StatefulWidget> createState() {
    return _EditPartner();
  }
}

class _EditPartner extends State<EditPartner> {
  var partnerEmail = '';
  late Future<bool> _futurePartner;
  final _formKey = GlobalKey<FormState>();

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
          child: Form(
            key: _formKey,
            child: Column(
              //aligning to the left
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Partner's Email",
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
                        floatingLabelBehavior: Constants.floatingLabelBehaviour,
                        border: Constants.outlineInputBorder,
                        labelText: 'sample@example.com',
                        fillColor: Colors.white),
                    validator: (String? emailValue) {
                      // Email validation
                      if (emailValue == null || emailValue.isEmpty) {
                        return 'Please enter email';
                      } else if (!Constants.emailRegex.hasMatch(emailValue)) {
                        return 'Please enter a valid email';
                      } else if (emailValue.length >=
                          Constants.maxEmailLength) {
                        return 'Email must be less than ${Constants.maxEmailLength}';
                      }
                      partnerEmail = emailValue;
                      return null;
                    },
                  ),
                ),
                Constants.sectionPadding,
                Constants.formPadding,
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          // Make sure all fields are validated before showing the confirmation dialog
                          if (_formKey.currentState!.validate()) {
                            _invitePartner();
                          }
                        },
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
                              const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 100.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _invitePartner() {
    showDialog<String>(
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
            top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
        content: Text(
            'Are you sure you want to invite ${partnerEmail} as your partner?',
            style: Constants.dialogContentStyle),
        actionsAlignment: MainAxisAlignment.center,
        // actionsPadding: ,
        buttonPadding: EdgeInsets.symmetric(horizontal: 25.0),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () =>
                  Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel',
                  style: Constants.buttonRedStyle),
              style: ButtonStyle(
                shape:
                MaterialStateProperty.all<OutlinedBorder>(
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
              // Invite partner functionality
              setState(() {
                _futurePartner = invitePartner(widget.accountInfo.email, partnerEmail);
              }),

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
              padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 35.0)),
            ),
          ),
        ],
      ),
    );
  }
}
