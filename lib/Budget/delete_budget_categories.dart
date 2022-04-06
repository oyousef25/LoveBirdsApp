import 'package:flutter/material.dart';
import '../helper/constants.dart';

class DeleteBudgetPage extends StatefulWidget {
  const DeleteBudgetPage({Key? key, required this.dataMap}) : super(key: key);

  /// Creates a state
  ///
  /// Return the Delete Budget Category page State
  @override
  State<StatefulWidget> createState() {
    return _DeleteBudgetPageState();
  }

  final Map<String, double>? dataMap;
}

class _DeleteBudgetPageState extends State<DeleteBudgetPage> {
  @override
  Widget build(BuildContext context) {
    String category = widget.dataMap?.keys.elementAt(0) ?? "none";
    String currentCategory = "Food";


    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Budget Category'),
        backgroundColor: Constants.lightPrimary,
        titleTextStyle: Constants.appBarStyle,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Container(
        margin:
        const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //form heading
            const Text(
              "Budget Category",
              textAlign: TextAlign.left,
              style: Constants.sectionHeading,
            ),

            Constants.formPadding,

            //Drop down of Categories
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
                value: category,
                focusNode:
                FocusNode(), // Hack to not focus dropdown after selection
                icon: const Icon(Icons.arrow_drop_down_rounded),
                elevation: 16,
                style: Constants.formDropdownStyle,
                onChanged: (String? newValue) {
                  setState(() {
                    category = newValue!;
                  });
                },
                items: <String>[
                  'Food',
                  'Venue',
                  'Photos',
                  'Hummus',
                  'Bride',
                  'Other',
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

            const Padding(padding: EdgeInsets.only(bottom: 27)),

            //Delete Button
            Center(
              child: ElevatedButton(
                //TODO: Delete Budget Category
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
                        'Are you sure you want to delete the category?',

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
                const Text("Delete", style: Constants.buttonRedStyle),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Constants.buttonRed),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 203.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
