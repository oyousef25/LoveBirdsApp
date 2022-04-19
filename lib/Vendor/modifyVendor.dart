import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lovebirds_app/helper/accountInfo.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/CustomVendor/createCustomVendorInfo.dart';
import 'package:lovebirds_app/helper/CustomVendor/updateCustomVendorInfo.dart';

import '../helper/CustomVendor/fetchCustomVendorInfo.dart';
import '../helper/customVendorInfo.dart';

class ModifyVendorScreen extends StatefulWidget {
  const ModifyVendorScreen(
      {Key? key, required this.customVendor, required this.accountInfo})
      : super(key: key);

  // Will be null if adding a custom vendor
  // Otherwise it will contain the custom vendor info to edit.
  final CustomVendorInfo? customVendor;
  final AccountInfo accountInfo;

  @override
  State<StatefulWidget> createState() {
    return _ModifyVendorState();
  }
}

class _ModifyVendorState extends State<ModifyVendorScreen> {
  /// Form key for validation of custom vendor form
  final GlobalKey<FormState> _vendorFormKey = GlobalKey<FormState>();
  Future<CustomVendorInfo>? _futureCustomVendor;

  @override
  void initState() {
    super.initState();
    _futureCustomVendor = fetchCustomVendorInfo(widget.customVendor?.id ?? -1);
  }

  @override
  Widget build(BuildContext context) {
    // Break the custom vendor info apart, if null then set defaults
    int customVendorId = widget.customVendor?.id ?? 0;
    String customVendorName = widget.customVendor?.name ?? '';
    String customVendorDescription = widget.customVendor?.description ?? '';
    String customVendorPhone = widget.customVendor?.phoneNum ?? '';
    String customVendorType = widget.customVendor?.vendorType ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.lightPrimary,
        centerTitle: true,
        title: Text(
            widget.customVendor == null ? 'Create Vendor' : 'Edit Vendor',
            style: Constants.appBarStyle),
      ),
      body: FutureBuilder<CustomVendorInfo>(
        future: _futureCustomVendor,
        builder: (context, snapshot) {
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
                    key: _vendorFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),

                        // Form heading
                        const Text(
                          "Vendor",
                          textAlign: TextAlign.left,
                          style: Constants.sectionHeading,
                        ),

                        Constants.formPadding,

                        /// Custom vendor name
                        Material(
                          shadowColor: Colors.grey,
                          elevation: 3.0,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: TextFormField(
                            maxLengthEnforcement: MaxLengthEnforcement
                                .truncateAfterCompositionEnds,
                            maxLength: Constants.maxTextFieldLength,
                            initialValue: customVendorName,
                            onSaved: (String? value) {
                              customVendorName = value ?? '';
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Enter a name (ie. Caboto Club)",
                              hintStyle: Constants.formHintStyle,
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            validator: (String? value) {
                              // Vendor name validation code
                              if (value == null || value.isEmpty) {
                                return 'Name cannot be empty';
                              } else if (value.length >
                                  Constants.maxTextFieldLength) {
                                return 'Max ${Constants.maxTextFieldLength} characters allowed';
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

                        /// Custom vendor phone number
                        Material(
                          shadowColor: Colors.grey,
                          elevation: 3.0,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            initialValue: customVendorPhone,
                            onSaved: (String? value) {
                              customVendorPhone = value ?? '';
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: '1234567890',
                              hintStyle: Constants.formHintStyle,
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            validator: (String? value) {
                              // Phone number validation
                              if (value == null || value.isEmpty) {
                                return 'Phone number cannot be empty';
                              } else if (!Constants.phoneRegex
                                  .hasMatch(value)) {
                                return 'Only numbers are allowed (no space or dash etc.)';
                              }
                              return null;
                            },
                          ),
                        ),

                        Constants.sectionPadding,

                        // Form heading
                        const Text(
                          "Description",
                          textAlign: TextAlign.left,
                          style: Constants.sectionHeading,
                        ),

                        Constants.formPadding,

                        /// Custom vendor description
                        Material(
                          shadowColor: Colors.grey,
                          elevation: 3.0,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: TextFormField(
                            minLines: 2,
                            maxLines: 4,
                            maxLength: Constants.maxTextBoxLength,
                            maxLengthEnforcement: MaxLengthEnforcement
                                .truncateAfterCompositionEnds,
                            onSaved: (String? value) {
                              customVendorDescription = value ?? '';
                            },
                            initialValue: customVendorDescription,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText:
                                  'Enter a brief description of the vendor',
                              hintStyle: Constants.formHintStyle,
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            validator: (String? value) {
                              // Vendor description validation
                              if (value == null || value.isEmpty) {
                                return 'Description cannot be empty';
                              } else if (value.length >
                                  Constants.maxTextBoxLength) {
                                return 'Max ${Constants.maxTextBoxLength} characters allowed';
                              }
                              return null;
                            },
                          ),
                        ),

                        Constants.sectionPadding,

                        // Form heading
                        const Text(
                          "Vendor Type",
                          textAlign: TextAlign.left,
                          style: Constants.sectionHeading,
                        ),

                        Constants.formPadding,

                        /// Custom vendor type
                        Material(
                          shadowColor: Colors.grey,
                          elevation: 3.0,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: TextFormField(
                            maxLengthEnforcement: MaxLengthEnforcement
                                .truncateAfterCompositionEnds,
                            maxLength: Constants.maxTextFieldLength,
                            onSaved: (String? value) {
                              customVendorType = value ?? '';
                            },
                            initialValue: customVendorType,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText:
                                  'Enter the type of vendor (e.g. Hair Salon)',
                              hintStyle: Constants.formHintStyle,
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            validator: (String? value) {
                              // Vendor type validation code
                              if (value == null || value.isEmpty) {
                                return 'Vendor type cannot be empty';
                              } else if (value.length >
                                  Constants.maxTextFieldLength) {
                                return 'Max ${Constants.maxTextFieldLength} characters allowed';
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
                                  if (_vendorFormKey.currentState!.validate()) {
                                    _vendorFormKey.currentState!
                                        .save(); // Save all the form field items
                                    // Process data.
                                    if (widget.customVendor == null) {
                                      // Case where adding a custom vendor

                                      setState(() {
                                        // Add a custom vendor to API
                                        _futureCustomVendor =
                                            createCustomVendorInfo(
                                                customVendorName,
                                                customVendorDescription,
                                                customVendorPhone,
                                                customVendorType,
                                                widget.accountInfo.id);

                                        // Go back to previous page
                                        Navigator.pop(context);
                                      });
                                    } else {
                                      // Case where editing a custom vendor

                                      setState(() {
                                        // Update custom vendor to API
                                        _futureCustomVendor =
                                            updateCustomVendorInfo(
                                                customVendorId,
                                                customVendorName,
                                                customVendorDescription,
                                                customVendorPhone,
                                                customVendorType,
                                                widget.accountInfo.id);

                                        // Go back to previous page
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      });
                                    }
                                  }
                                },
                                child: Text(
                                    widget.customVendor == null
                                        ? 'Create'
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
