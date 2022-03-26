import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';

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
  /// This Widget builds out the Account page
  ///
  /// Given the build [context], return the Account page Widget.
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 40, left: 20, right: 20, bottom: 20),
                child: const Text(
                  "Welcome, Alex Apple!",
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
                              child:  ListTile(
                                title: Text("Tasks",
                                    textAlign: TextAlign.center,
                                    style: Constants.cardHeaderStyle),
                              )),

                          //Task Name
                          Constants.sectionPadding,
                          Text("50", style: Constants.taskNumber),
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
                        children: const [
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
                                title: Text("Partner",
                                    textAlign: TextAlign.center,
                                    style: Constants.cardHeaderStyle),
                              )),

                          //Task Name
                          Constants.sectionPadding,
                          Text("30", style: Constants.taskNumber),
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
              Expanded(
                child: Card(
                  shadowColor: Colors.grey,
                  elevation: 5.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
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
                                //TODO: Fix this edit button
                                print("Pressed");
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          )),
                      const ListTile(
                        leading:
                            Text("Name", style: Constants.detailGreyedStyle),
                        trailing:
                            Text("Alex Apple", style: Constants.detailStyle),
                      ),
                      const ListTile(
                        leading:
                            Text("Email", style: Constants.detailGreyedStyle),
                        trailing: Text("alex@apple.com",
                            style: Constants.detailStyle),
                      ),
                      const ListTile(
                        leading: Text("Password",
                            style: Constants.detailGreyedStyle),
                        trailing: Text("", style: Constants.detailStyle),
                      ),
                      const ListTile(
                        leading:
                            Text("Role", style: Constants.detailGreyedStyle),
                        trailing: Text("Husband", style: Constants.detailStyle),
                      ),
                      const ListTile(
                        leading: Text("Wedding Day",
                            style: Constants.detailGreyedStyle),
                        trailing: Text("May 25th, 2022",
                            style: Constants.detailStyle),
                      ),

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
                                //TODO: Fix this edit button
                                print("Pressed");
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          )),

                      const ListTile(
                        leading: Text("Name",
                            style: Constants.detailGreyedStyle),
                        trailing: Text("Alexa Pear",
                            style: Constants.detailStyle),
                      ),

                      const ListTile(
                        leading: Text("Email",
                            style: Constants.detailGreyedStyle),
                        trailing: Text("alexa@pear.com",
                            style: Constants.detailStyle),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
