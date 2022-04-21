import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lovebirds_app/Login/login.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Account/edit_account.dart';
import 'Account/edit_partner.dart';
import 'Network_Utils/api.dart';
import 'helper/Account/accountInfo.dart';
import 'helper/Account/fetchAccount.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key})
      : super(key: key); // Account page key identifier

  /// Creates a state
  ///
  /// Return the Account page State
  @override
  State<StatefulWidget> createState() {
    return _AccountPageState();
  }
}

class _AccountPageState extends State<AccountPage> {
  late Future<AccountInfo> _futureAccount;

  // Reload the account page with new data
  refreshPage() {
    _futureAccount = fetchAccount();
    setState(() {});
  }

  void initState() {
    super.initState();

    // Get the current user's account info
    _futureAccount = fetchAccount();
  }

  /// This Widget builds out the Account page
  ///
  /// Given the build [context], return the Account page Widget.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureAccount,
        // Takes the snapshotted data
        builder: (context, AsyncSnapshot snapshotAccount) {
          // If the data retrieval went wrong
          if (snapshotAccount.hasError) {
            return Center(
              child: Text('There was an error fetching your account details'),
            );
          } else if (snapshotAccount.hasData) {
            return RefreshIndicator(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: 1050,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 40, left: 20, right: 20, bottom: 20),
                          child: Text(
                            "Welcome, " + snapshotAccount.data.name + "!",
                            style: Constants.title,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Card(
                                shadowColor: Colors.grey,
                                elevation: 5.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Column(
                                  children: [
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
                                          title: Text("Tasks",
                                              textAlign: TextAlign.center,
                                              style: Constants.cardHeaderStyle),
                                        )),

                                    //Task Name
                                    Constants.sectionPadding,
                                    Text('${snapshotAccount.data.userTasks}',
                                        style: Constants.taskNumber),
                                    Constants.formPadding2,
                                    Text("remaining",
                                        style: Constants.cardContentStyle2),
                                    Constants.sectionPadding,
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
                                shadowColor: Colors.grey,
                                elevation: 5.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Column(
                                  children: [
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
                                          title: Text("Partner's",
                                              textAlign: TextAlign.center,
                                              style: Constants.cardHeaderStyle),
                                        )),

                                    //Task Name
                                    Constants.sectionPadding,
                                    Text('${snapshotAccount.data.partnerTasks}',
                                        style: Constants.taskNumber),
                                    Constants.formPadding2,
                                    Text("remaining",
                                        style: Constants.cardContentStyle2),
                                    Constants.sectionPadding,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 400,
                          child: Card(
                            shadowColor: Colors.grey,
                            elevation: 5.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Card(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.zero,
                                              bottomRight: Radius.zero)),
                                      margin: EdgeInsets.zero,
                                      color: Constants.lightSecondary,
                                      child: ListTile(
                                        title: const Text("Account Details",
                                            textAlign: TextAlign.center,
                                            style: Constants.cardHeaderStyle),
                                        trailing: IconButton(
                                          onPressed: () {
                                            // Jump to edit screen
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) => EditAccount(
                                                accountInfo:
                                                    snapshotAccount.data,
                                              ),
                                            ));
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                      )),
                                  Constants.formPadding2,
                                  ListTile(
                                    leading: Text("Name",
                                        style: Constants.detailGreyedStyle),
                                    trailing: Text(snapshotAccount.data.name,
                                        style: Constants.detailStyle),
                                  ),
                                  ListTile(
                                      leading: Text("Email",
                                          style: Constants.detailGreyedStyle),
                                      trailing: SizedBox(
                                        width: 200,
                                        child: Text(snapshotAccount.data.email,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            style: Constants.detailStyle),
                                      )),
                                  const ListTile(
                                    leading: Text("Password",
                                        style: Constants.detailGreyedStyle),
                                    trailing:
                                        Text("", style: Constants.detailStyle),
                                  ),
                                  ListTile(
                                    leading: Text("Budget",
                                        style: Constants.detailGreyedStyle),
                                    trailing: Text('${NumberFormat.simpleCurrency().currencySymbol}${snapshotAccount.data.budget}',
                                        style: Constants.detailStyle),
                                  ),
                                  ListTile(
                                    leading: Text("Wedding Day",
                                        style: Constants.detailGreyedStyle),
                                    trailing: Text(
                                        snapshotAccount.data.weddingDate,
                                        style: Constants.detailStyle),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 230,
                          child: Card(
                            shadowColor: Colors.grey,
                            elevation: 5.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Card(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.zero,
                                              bottomRight: Radius.zero)),
                                      margin: EdgeInsets.zero,
                                      color: Constants.lightSecondary,
                                      child: ListTile(
                                        title: const Text("Partner Details",
                                            textAlign: TextAlign.center,
                                            style: Constants.cardHeaderStyle),
                                        trailing: IconButton(
                                          onPressed: () {
                                            // Jump to edit screen
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) => EditPartner(
                                                accountInfo:
                                                    snapshotAccount.data,
                                              ),
                                            ));
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                      )),
                                  Constants.formPadding2,
                                  ListTile(
                                    leading: Text("Name",
                                        style: Constants.detailGreyedStyle),
                                    trailing: Text(
                                        snapshotAccount.data.partnerName ?? '',
                                        style: Constants.detailStyle),
                                  ),
                                  ListTile(
                                      leading: Text("Email",
                                          style: Constants.detailGreyedStyle),
                                      trailing: SizedBox(
                                        width: 200,
                                        child: Text(
                                            snapshotAccount.data.partnerEmail ??
                                                '',
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            style: Constants.detailStyle),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Constants.sectionPadding,
                        Center(
                          child: ElevatedButton(
                            onPressed: () => {
                              // Provide sign out functionality
                              logout()
                            },
                            child: const Text('Sign Out',
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
                                  const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 100.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onRefresh: () async => {
                      // Refresh the account page
                      refreshPage(),
                    });
          }
          return const CircularProgressIndicator();
        });
  }

  void logout() async {
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context)=>Login()));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }
}
