import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/GuestCRUD/deleteGuest.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/guestInfo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/GuestCRUD/fetchGuest.dart';
import 'modifyGuest.dart';

class GuestDetailsScreen extends StatefulWidget {
  // In the constructor, require a GuestInfo.
  const GuestDetailsScreen(
      {Key? key, required this.guestInfo, required this.guestRelationships, required this.userID})
      : super(key: key);

  // Declare a field that holds the GuestInfo and relationships.
  final GuestInfo guestInfo;
  final Map<int, String> guestRelationships;
  final int userID;

  @override
  State createState() {
    return _GuestDetailsScreenState();
  }
}

class _GuestDetailsScreenState extends State<GuestDetailsScreen> {
  Future<GuestInfo>? _futureGuest;

  @override
  void initState() {
    super.initState();
    _futureGuest = fetchGuest(widget.guestInfo.id);
  }

  @override
  Widget build(BuildContext context) {
    String guestRelationshipValue =
        widget.guestRelationships[widget.guestInfo.relationship]!;

    // Use the GuestInfo to create the UI.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.lightPrimary,
        centerTitle: true,
        title: Text('Guest Details', style: Constants.appBarStyle),
      ),
      body: FutureBuilder<GuestInfo>(
          future: _futureGuest,
          builder: (context, snapshot) {
            // If the connection is done,
            // check for response data or an error.
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    // A column with image, guest detail card, and two buttons
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(10.0)),
                      Icon(Icons.person_outline_rounded, size: 100.0),
                      Card(
                        shadowColor: Colors.grey,
                        elevation: 5.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
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
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => ModifyGuestScreen(
                                          guestInfo: widget.guestInfo,
                                          guestRelationships:
                                              widget.guestRelationships,
                                          userID: widget.userID,
                                        ),
                                      ));
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                )),
                            ListTile(
                              leading: Text('Full Name',
                                  style: Constants.detailGreyedStyle),
                              trailing: Text(
                                  widget.guestInfo.firstName +
                                      ' ' +
                                      widget.guestInfo.lastName,
                                  style: Constants.detailStyle),
                            ),
                            ListTile(
                              leading: Text('Relationship',
                                  style: Constants.detailGreyedStyle),
                              trailing: Text(guestRelationshipValue,
                                  style: Constants.detailStyle),
                            ),
                            ListTile(
                              leading: Text('E-mail',
                                  style: Constants.detailGreyedStyle),
                              trailing: Text(widget.guestInfo.email,
                                  style: Constants.detailStyle),
                            ),
                            ListTile(
                              leading: Text('Phone #',
                                  style: Constants.detailGreyedStyle),
                              trailing: Text(widget.guestInfo.phoneNum,
                                  style: Constants.detailStyle),
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
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
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
                                                style:
                                                    Constants.cardHeaderStyle),
                                          )),
                                      contentPadding: EdgeInsets.only(
                                          top: 20.0,
                                          bottom: 0.0,
                                          left: 25.0,
                                          right: 25.0),
                                      content: Text(
                                          'Are you sure you want to remove ' +
                                              widget.guestInfo.firstName +
                                              ' ' +
                                              widget.guestInfo.lastName +
                                              '?',
                                          style: Constants.dialogContentStyle),
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      // actionsPadding: ,
                                      buttonPadding: EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      actions: <Widget>[
                                        ElevatedButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel',
                                                style:
                                                    Constants.buttonRedStyle),
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  OutlinedBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                              ),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Constants.buttonRed),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsets>(
                                                      EdgeInsets.symmetric(
                                                          vertical: 20.0,
                                                          horizontal: 20.0)),
                                            )),
                                        ElevatedButton(
                                          onPressed: () => {
                                            setState(() {
                                              // Delete guest functionality
                                              _futureGuest = deleteGuest(
                                                  snapshot.data!.id);

                                              // Go back
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            }),
                                          },
                                          child: const Text('Confirm',
                                              style: Constants.buttonRedStyle),
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                OutlinedBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    Constants.buttonGreen),
                                            padding: MaterialStateProperty.all<
                                                    EdgeInsets>(
                                                EdgeInsets.symmetric(
                                                    vertical: 20.0,
                                                    horizontal: 20.0)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              child: Text('Remove Guest',
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
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 20.0)),
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 60.0, horizontal: 10.0),
                          ),
                          ElevatedButton(
                            // Contact guest button
                            onPressed: () {
                              // Contact guest functionality
                              launch('tel:${widget.guestInfo.phoneNum}');
                            },
                            child: Text('Contact Guest',
                                style: Constants.buttonWhiteStyle),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 20.0)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(
                    "Guest was already deleted, please go back and refresh the page");
              }
            }
            // By default, show a loading spinner.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
