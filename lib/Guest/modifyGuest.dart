import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/guestInfo.dart';

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
    GuestInfo(id: -1, firstName: '', lastName: '', relationship: '', email: '', phoneNum: '', status: 1); // Default
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
