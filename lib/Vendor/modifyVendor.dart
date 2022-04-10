import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/createCustomVendorInfo.dart';

import '../helper/customVendorInfo.dart';

class ModifyVendorScreen extends StatefulWidget {
  const ModifyVendorScreen({Key? key, required this.customVendor})
      : super(key: key);

  // Will be null if adding a guest
  // Otherwise it will contain the custom vendor info to edit.
  final CustomVendorInfo? customVendor;

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
  Widget build(BuildContext context) {
    // Populate the custom vendor info text, if any
    CustomVendorInfo? customVendor = widget.customVendor;
    CustomVendorInfo customVendorTextValue =
    CustomVendorInfo(name: '', description: '', phoneNum: '', vendorType: ''); // Default
    if (customVendor != null) {
      // Make sure custom vendor info exists
      customVendorTextValue = customVendor;
    }

    // Custom vendor info
    String customVendorName = '';
    String customVendorDescription = '';
    String customVendorPhone = '';
    String customVendorType = '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.lightPrimary,
        centerTitle: true,
        title: Text(
            widget.customVendor == null ? 'Create Vendor' : 'Edit Vendor',
            style: Constants.appBarStyle),
      ),
      body: SingleChildScrollView(
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
                    initialValue: customVendorTextValue.name,
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
                      if (value == null || value.isEmpty) {
                        return 'Name cannot be empty';
                      }
                      // TODO: Vendor name validation code
                      return null;
                    },
                  ),
                ),

                Constants.sectionPadding,

                // // Form heading
                // const Text(
                //   "Location",
                //   textAlign: TextAlign.left,
                //   style: Constants.sectionHeading,
                // ),
                //
                // Constants.formPadding,

                /// Custom vendor location (removed until further notice)
                // Material(
                //   shadowColor: Colors.grey,
                //   elevation: 3.0,
                //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                //   child: TextFormField(
                //     initialValue: customVendorTextValue.location,
                //     decoration: const InputDecoration(
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide.none,
                //       ),
                //       hintText: 'Enter a location (ie. Windsor, ON)',
                //       hintStyle: Constants.formHintStyle,
                //       fillColor: Colors.white,
                //       filled: true,
                //     ),
                //     validator: (String? value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Location cannot be empty';
                //       }
                //       // TODO: Location validation code
                //       return null;
                //     },
                //   ),
                // ),
                //
                // Constants.sectionPadding,

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
                    initialValue: customVendorTextValue.phoneNum,
                    onSaved: (String? value) {
                      customVendorPhone = value ?? '';
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
                        return 'Phone number cannot be empty';
                      }
                      // TODO: Phone number validation code
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
                    maxLength: 255,
                    onSaved: (String? value) {
                      customVendorDescription = value ?? '';
                    },
                    initialValue: customVendorTextValue.description,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Enter a brief description of the vendor',
                      hintStyle: Constants.formHintStyle,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Description cannot be empty';
                      }
                      // TODO: Vendor description validation code
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
                    onSaved: (String? value) {
                      customVendorType = value ?? '';
                    },
                    initialValue: customVendorTextValue.vendorType,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Enter the type of vendor (e.g. Hair Salon)',
                      hintStyle: Constants.formHintStyle,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Vendor type cannot be empty';
                      }
                      // TODO: Vendor type validation code
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
                            _vendorFormKey.currentState!.save(); // Save all the form field items
                            // Process data.
                            if (widget.customVendor == null) {
                              // Case where adding a custom vendor
                              _futureCustomVendor = createCustomVendorInfo(customVendorName, customVendorDescription, customVendorPhone, customVendorType, 1);

                              // Add a custom vendor to database
                              FutureBuilder<CustomVendorInfo>(
                                future: _futureCustomVendor,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(snapshot.data!.name + " vendor successfully added!");
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }

                                  return const CircularProgressIndicator();
                                },
                              );
                            } else {
                              // Case where editing a custom vendor
                              // TODO: Edit a custom vendor
                            }
                          }
                        },
                        child: Text(
                            widget.customVendor == null ? 'Create' : 'Save',
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