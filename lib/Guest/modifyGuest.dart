import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lovebirds_app/helper/GuestCRUD/createGuest.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/guestInfo.dart';

import '../helper/GuestCRUD/fetchGuest.dart';
import '../helper/GuestCRUD/updateGuest.dart';

class ModifyGuestScreen extends StatefulWidget {
  const ModifyGuestScreen(
      {Key? key, required this.guestInfo, required this.guestRelationships})
      : super(key: key);

  // Will be null if adding a guest
  // Otherwise it will contain the guest info to edit.
  final GuestInfo? guestInfo;
  final Map<int, String> guestRelationships; // Guest relationship map

  @override
  State<StatefulWidget> createState() {
    return _ModifyGuestState();
  }
}

class _ModifyGuestState extends State<ModifyGuestScreen> {
  /// Form key for validation of guest form
  final GlobalKey<FormState> _guestFormKey = GlobalKey<FormState>();
  late Future<GuestInfo> _futureGuest;

  @override
  void initState() {
    super.initState();
    // Get the guest
    _futureGuest = fetchGuest(widget.guestInfo?.id ?? -1);
  }

  @override
  Widget build(BuildContext context) {
    // Break the guest info apart, if null then set defaults
    int guestId = widget.guestInfo?.id ?? 0;
    String guestFirstName = widget.guestInfo?.firstName ?? '';
    String guestLastName = widget.guestInfo?.lastName ?? '';
    int guestRelationship = widget.guestInfo?.relationship ??
        widget.guestRelationships.keys.first;
    String guestRelationshipValue = widget.guestRelationships[widget.guestInfo?.relationship] ??
        widget.guestRelationships.values.first;
    String guestEmail = widget.guestInfo?.email ?? '';
    String guestPhoneNum = widget.guestInfo?.phoneNum ?? '';
    int guestStatus = widget.guestInfo?.status ?? 1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.lightPrimary,
        centerTitle: true,
        title: Text(widget.guestInfo == null ? 'New Guest' : 'Edit Guest',
            style: Constants.appBarStyle),
      ),
      body: FutureBuilder<GuestInfo>(
        future: _futureGuest,
        builder: (context, AsyncSnapshot snapshot) {
          // If the connection is done,
          // check for response data or an error.
          if (snapshot.connectionState == ConnectionState.done) {
            // snapshot.hasError in this case just means the user is adding a custom vendor
            // Because in the case of adding a vendor there is nothing to fetch
            if (snapshot.hasData || snapshot.hasError) {
              return SingleChildScrollView(
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
                            maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                            maxLength: Constants.maxTextFieldLength,
                            initialValue: guestFirstName,
                            onSaved: (String? value) {
                              guestFirstName = value ?? '';
                            },
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
                              } else if (value.length > Constants.maxTextFieldLength) {
                                return 'Max ${Constants.maxTextFieldLength} characters allowed';
                              }

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
                            maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                            maxLength: Constants.maxTextFieldLength,
                            initialValue: guestLastName,
                            onSaved: (String? value) {
                              guestLastName = value ?? '';
                            },
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
                              } else if (value.length > Constants.maxTextFieldLength) {
                                return 'Max ${Constants.maxTextFieldLength} characters allowed';
                              }
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
                                  left: 12.0,
                                  top: 12.0,
                                  right: 12.0,
                                  bottom: 2.0),
                            ),
                            iconSize: 50.0,
                            value: guestRelationshipValue,
                            focusNode:
                                FocusNode(), // Hack to not focus dropdown after selection
                            icon: const Icon(Icons.arrow_drop_down_rounded),
                            elevation: 16,
                            style: Constants.formDropdownStyle,
                            onChanged: (String? newValue) {
                              setState(() {
                                guestRelationshipValue = newValue!;
                              });
                            },
                            items: widget.guestRelationships.values
                                .map<DropdownMenuItem<String>>((String value) {
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
                            maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                            maxLength: Constants.maxTextFieldLength,
                            initialValue: guestEmail,
                            onSaved: (String? value) {
                              guestEmail = value ?? '';
                            },
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
                              } else if (!Constants.emailRegex.hasMatch(guestEmail)) {
                                return 'Please enter a valid email';
                              } else if (guestEmail.length >=
                                  Constants.maxEmailLength) {
                                return 'Email must be less than ${Constants.maxEmailLength}';
                              }
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
                            keyboardType: TextInputType.phone,
                            initialValue: guestPhoneNum,
                            onSaved: (String? value) {
                              guestPhoneNum = value ?? '';
                            },
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
                              } else if (!Constants.phoneRegex.hasMatch(value)) {
                                return 'Only numbers are allowed (no space or dash etc.)';
                              }
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
                                    _guestFormKey.currentState!
                                        .save(); // Save all form field items
                                    // Process data.
                                    if (widget.guestInfo == null) {
                                      // Case where adding a guest

                                      setState(() {
                                        // Add a guest to API
                                        _futureGuest = createGuest(
                                          1,
                                          guestFirstName,
                                          guestLastName,
                                          guestRelationship,
                                          guestEmail,
                                          guestPhoneNum,
                                        );

                                        // Go back to previous page
                                        Navigator.pop(context);
                                      });
                                    } else {
                                      // Case where editing a guest
                                      setState(() {
                                        // Update a guest to API
                                        _futureGuest = updateGuest(
                                            guestId,
                                            1,
                                            guestFirstName,
                                            guestLastName,
                                            guestRelationship,
                                            guestEmail,
                                            guestPhoneNum,
                                            guestStatus);

                                        // Go back to previous page
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      });
                                    }
                                  }
                                },
                                child: Text(
                                    widget.guestInfo == null
                                        ? 'Add Guest'
                                        : 'Save',
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
                                              vertical: 20.0,
                                              horizontal: 100.0)),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
