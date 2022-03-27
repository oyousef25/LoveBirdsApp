import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/guestInfo.dart';

class GuestsPage extends StatefulWidget {
  const GuestsPage({Key? key, required this.guestList})
      : super(key: key); // Guests page key identifier

  // Require guest data to be passed into this Widget
  final List<GuestInfo> guestList;

  /// Creates a state
  ///
  /// Return the Guest page State
  @override
  State<StatefulWidget> createState() {
    return _GuestsPageState();
  }
}

class _GuestsPageState extends State<GuestsPage> {
  int? _selectedIndex = 0; // Index of selected chip
  final List<String> _chips = [
    'All',
    'Confirmed',
    'Pending'
  ]; // List of chip options

  /// This Widget builds out the main Guest page
  ///
  /// Given the build [context], return the Guest page Widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // Column containing 4 rows:
        // 1. Total guests card, 2. Choice chips for filtering, 3. Padding, 4. Guest list
        children: <Widget>[
          Card(
              margin: const EdgeInsets.symmetric(
                  vertical: 25.0,
                  horizontal: 100.0), // Hack for shrinking card padding
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Constants.lightSecondary,
              child: const ListTile(
                  minVerticalPadding: 30.0,
                  title: Text('Total Guests',
                      textAlign: TextAlign.center,
                      style: Constants.cardHeaderStyle),
                  subtitle: Text('XX Guests',
                      textAlign: TextAlign.center,
                      style: Constants.cardContentStyle))),
          Wrap(
              spacing: 30.0,
              // Creates a list of 3 chips that will highlight the selected ones
              children: List<Widget>.generate(
                3,
                (int index) {
                  return ChoiceChip(
                    label: Text(_chips[index]),
                    labelStyle: _selectedIndex == index
                        ? Constants.chipSelectedStyle
                        : Constants.chipUnselectedStyle,
                    selected: _selectedIndex ==
                        index, // If selected index IS the index then it is selected
                    backgroundColor: Colors.white,
                    shadowColor: Colors.grey,
                    elevation: 2.0,
                    selectedColor: Constants.darkSecondary,
                    onSelected: (bool selected) {
                      // Toggles selected chip only if the user presses on an unselected chip
                      if (_selectedIndex != index) {
                        setState(() {
                          _selectedIndex = selected ? index : null;
                        });
                      }
                    },
                  );
                },
              ).toList()),
          Padding(
              padding:
                  EdgeInsets.all(5.0)), // Some padding before the guest list
          Expanded(
            // Makes sure that ListView expands to fit inside the column
            child: ListView.builder(
              // ListView that is built as it is scrolled onto the screen
              itemCount: widget.guestList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 7.0, horizontal: 10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.white,
                  shadowColor: Colors.grey,
                  elevation: 5.0,
                  child: ListTile(
                    leading: Icon(Icons.person_outline_rounded, size: 40.0),
                    title: Text(
                        widget.guestList[index].firstName +
                            ' ' +
                            widget.guestList[index].lastName,
                        textAlign: TextAlign.left,
                        style: Constants.listTitleStyle),
                    subtitle: Text(widget.guestList[index].relationship,
                        textAlign: TextAlign.left,
                        style: Constants.listSubtitleStyle),
                    trailing: Icon(Icons.chevron_right_rounded),
                    onTap: () {
                      // Open up the Guest Info route
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GuestDetailsScreen(
                            guestInfo: widget.guestList[index]),
                      ));
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Go to add guest page
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ModifyGuestScreen(
              guestInfo: null,
            ),
          ));
        },
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
                              vertical: 25.0, horizontal: 30.0)),
                    )),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
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
                        EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0)),
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

class ModifyGuestScreen extends StatefulWidget {
  const ModifyGuestScreen({Key? key, required this.guestInfo})
      : super(key: key);

  // Will be null if adding a guest
  // Otherwise it will contain the guest info to edit.
  final GuestInfo? guestInfo;

  @override
  State<StatefulWidget> createState() {
    return _ModifyGuestState();
  }
}

class _ModifyGuestState extends State<ModifyGuestScreen> {
  /// Form key for validation of guest form
  final GlobalKey<FormState> _guestFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Populate the guest info text, if any
    GuestInfo? guestInfo = widget.guestInfo;
    GuestInfo guestInfoTextValue =
        GuestInfo('', '', 'Hummus', '', ''); // Default
    if (guestInfo != null) {
      // Make sure guest info exists
      guestInfoTextValue = guestInfo;
    }
    // Keeps track of relationship dropdown menu item
    String guestRelationship = guestInfoTextValue.relationship;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.lightPrimary,
        centerTitle: true,
        title: Text(widget.guestInfo == null ? 'New Guest' : 'Edit Guest',
            style: Constants.appBarStyle),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            // New guest form
            key: _guestFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),

                // Form heading
                const Text(
                  "First Name",
                  textAlign: TextAlign.left,
                  style: Constants.sectionHeading,
                ),

                Constants.formPadding,

                /// Guest's first name
                Material(
                  shadowColor: Colors.grey,
                  elevation: 3.0,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: TextFormField(
                    initialValue: guestInfoTextValue.firstName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Enter their first name (ie. John)',
                      hintStyle: Constants.formHintStyle,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'First name cannot be empty';
                      }
                      // TODO: First name validation code
                      return null;
                    },
                  ),
                ),

                Constants.sectionPadding,

                // Form heading
                const Text(
                  "Last Name",
                  textAlign: TextAlign.left,
                  style: Constants.sectionHeading,
                ),

                Constants.formPadding,

                /// Guest's last name
                Material(
                  shadowColor: Colors.grey,
                  elevation: 3.0,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: TextFormField(
                    initialValue: guestInfoTextValue.lastName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Enter their last name (ie. Smith)',
                      hintStyle: Constants.formHintStyle,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Last name cannot be empty';
                      }
                      // TODO: Last name validation code
                      return null;
                    },
                  ),
                ),

                Constants.sectionPadding,

                // Form heading
                const Text(
                  "Relationship",
                  textAlign: TextAlign.left,
                  style: Constants.sectionHeading,
                ),

                Constants.formPadding,

                /// Guest's relationship
                Material(
                  shadowColor: Colors.grey,
                  elevation: 3.0,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                          left: 12.0, top: 12.0, right: 12.0, bottom: 2.0),
                    ),
                    iconSize: 50.0,
                    value: guestRelationship,
                    focusNode:
                        FocusNode(), // Hack to not focus dropdown after selection
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    elevation: 16,
                    style: Constants.formDropdownStyle,
                    onChanged: (String? newValue) {
                      setState(() {
                        guestRelationship = newValue!;
                      });
                    },
                    items: <String>[
                      'Hummus',
                      'Sister',
                      'Brother',
                      'Unspecified'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: Constants.formDropdownStyle,
                        ),
                      );
                    }).toList(),
                  ),
                ),

                Constants.sectionPadding,

                // Form heading
                const Text(
                  "E-mail",
                  textAlign: TextAlign.left,
                  style: Constants.sectionHeading,
                ),

                Constants.formPadding,

                /// Guest's email
                Material(
                  shadowColor: Colors.grey,
                  elevation: 3.0,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: TextFormField(
                    initialValue: guestInfoTextValue.email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'email@example.com',
                      hintStyle: Constants.formHintStyle,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'E-mail cannot be empty';
                      }
                      // TODO: Email validation code
                      return null;
                    },
                  ),
                ),

                Constants.sectionPadding,

                // Form heading
                const Text(
                  "Phone Number",
                  textAlign: TextAlign.left,
                  style: Constants.sectionHeading,
                ),

                Constants.formPadding,

                /// Guest's phone number
                Material(
                  shadowColor: Colors.grey,
                  elevation: 3.0,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: TextFormField(
                    initialValue: guestInfoTextValue.phoneNum,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: '(123)456-7890',
                      hintStyle: Constants.formHintStyle,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone # cannot be empty';
                      }
                      // TODO: Phone number validation code
                      return null;
                    },
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: ElevatedButton(
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_guestFormKey.currentState!.validate()) {
                            // Process data.
                            if (widget.guestInfo == null) {
                              // Case where adding a guest
                              // TODO: Add a guest
                            } else {
                              // Case where editing a guest
                              // TODO: Edit a guest's info
                            }
                          }
                        },
                        child: Text(
                            widget.guestInfo == null ? 'Add Guest' : 'Save',
                            style: Constants.buttonRedStyle),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Constants.buttonRed),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 150.0)),
                        )),
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
