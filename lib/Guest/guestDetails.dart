import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/guestInfo.dart';

import 'modifyGuest.dart';

class GuestDetailsScreen extends StatelessWidget {
  // In the constructor, require a GuestInfo.
  const GuestDetailsScreen({Key? key, required this.guestInfo})
      : super(key: key);

  // Declare a field that holds the GuestInfo.
  final GuestInfo guestInfo;

  @override
  Widget build(BuildContext context) {
    // Use the GuestInfo to create the UI.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.lightPrimary,
        centerTitle: true,
        title: Text('Guest Details', style: Constants.appBarStyle),
      ),
      body: SingleChildScrollView(
        child: Column(
          // A column with image, guest detail card, and two buttons
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10.0)),
            Icon(Icons.person_outline_rounded, size: 100.0),
            Card(
              shadowColor: Colors.grey,
              elevation: 5.0,
              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero)),
                      margin: EdgeInsets.zero,
                      color: Constants.lightSecondary,
                      child: ListTile(
                        title: Text('Guest Information',
                            textAlign: TextAlign.center,
                            style: Constants.cardHeaderStyle),
                        trailing: IconButton(
                          onPressed: () {
                            // Jump to edit screen
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ModifyGuestScreen(
                                guestInfo: guestInfo,
                              ),
                            ));
                          },
                          icon: Icon(Icons.edit),
                        ),
                      )),
                  ListTile(
                    leading:
                    Text('Full Name', style: Constants.detailGreyedStyle),
                    trailing: Text(
                        guestInfo.firstName + ' ' + guestInfo.lastName,
                        style: Constants.detailStyle),
                  ),
                  ListTile(
                    leading: Text('Relationship',
                        style: Constants.detailGreyedStyle),
                    trailing: Text(guestInfo.relationship,
                        style: Constants.detailStyle),
                  ),
                  ListTile(
                    leading: Text('E-mail', style: Constants.detailGreyedStyle),
                    trailing:
                    Text(guestInfo.email, style: Constants.detailStyle),
                  ),
                  ListTile(
                    leading:
                    Text('Phone #', style: Constants.detailGreyedStyle),
                    trailing:
                    Text(guestInfo.phoneNum, style: Constants.detailStyle),
                  ),
                ],
              ),
            ),
            Row(
              // This row contains the two buttons for removing and contacting a guest
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  // Remove guest button
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
                            'Are you sure you want to remove ' +
                                guestInfo.firstName +
                                ' ' +
                                guestInfo.lastName +
                                '?',
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
                    child:
                    Text('Remove Guest', style: Constants.buttonRedStyle),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Constants.buttonRed),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0)),
                    )),
                Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 60.0, horizontal: 10.0),
                ),
                ElevatedButton(
                  // Contact guest button
                  onPressed: () {
                    // TODO: Contact guest functionality goes here
                  },
                  child:
                  Text('Contact Guest', style: Constants.buttonWhiteStyle),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}