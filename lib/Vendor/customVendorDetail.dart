import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/deleteCustomVendorInfo.dart';

import '../helper/customVendorInfo.dart';
import '../helper/fetchCustomVendorInfo.dart';
import 'modifyVendor.dart';

class CustomVendorDetailScreen extends StatefulWidget {
  // In the constructor, require a custom vendor.
  const CustomVendorDetailScreen({Key? key, required this.customVendor})
      : super(key: key);

  // Declare a field that holds the custom vendor info.
  final CustomVendorInfo customVendor;

  @override
  State createState() {
    return _CustomVendorDetailScreenState();
  }
}

class _CustomVendorDetailScreenState extends State<CustomVendorDetailScreen> {
  Future<CustomVendorInfo>? _futureCustomVendor;

  @override
  void initState() {
    super.initState();
    _futureCustomVendor = fetchCustomVendorInfo(widget.customVendor.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Vendors'),
        centerTitle: true,
        backgroundColor: Constants.lightPrimary,
        titleTextStyle: Constants.appBarStyle,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<CustomVendorInfo>(
        future: _futureCustomVendor,
        builder: (context, snapshot) {
          // If the connection is done,
          // check for response data or an error.
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.only(bottom: 0)),
                    Card(
                      shadowColor: Colors.grey,
                      elevation: 5.0,
                      margin:
                      const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                            trailing: IconButton(
                              onPressed: () {
                                // Jump to edit screen
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ModifyVendorScreen(customVendor: widget.customVendor),
                                ));
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ),

                          // Custom vendor name
                          const Text("Vendor", style: Constants.taskHeading),
                          Constants.formPadding,
                          Text(widget.customVendor.name, style: Constants.cardContentStyle),
                          Constants.taskPadding,

                          // Custom vendor location (removed until further notice)
                          // const Text("Location", style: Constants.taskHeading),
                          // Constants.formPadding,
                          // Text(customVendor.location,
                          //     style: Constants.cardContentStyle),
                          // Constants.taskPadding,

                          // Custom vendor phone number
                          const Text("Phone Number", style: Constants.taskHeading),
                          Constants.formPadding,
                          Text(widget.customVendor.phoneNum,
                              style: Constants.cardContentStyle),
                          Constants.taskPadding,

                          // Description of custom vendor
                          const Text("Description", style: Constants.taskHeading),
                          Constants.formPadding,
                          Container(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child: Text(
                              widget.customVendor.description,
                              style: Constants.cardContentStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Constants.taskPadding,

                          // Type of vendor
                          const Text("Vendor Type", style: Constants.taskHeading),
                          Constants.formPadding,
                          Text(widget.customVendor.vendorType,
                              style: Constants.cardContentStyle),
                          Constants.taskPadding,

                          // Remove custom vendor button
                          ElevatedButton(
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
                                      'Are you sure you want to remove the vendor ' +
                                          widget.customVendor.name +
                                          '?',
                                      style: Constants.dialogContentStyle),
                                  actionsAlignment: MainAxisAlignment.center,
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
                                        setState(() {
                                          // Delete custom vendor functionality
                                          _futureCustomVendor = deleteCustomVendorInfo(snapshot.data!.id);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        })
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
                              child: Text('Delete', style: Constants.buttonRedStyle),
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

                          Constants.taskPadding,
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("Vendor was already deleted, please go back and refresh the page");
            }
          }

          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
