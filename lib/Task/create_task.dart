import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key, required this.dataMap}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CreateTask();
  }

  final Map<String, double>? dataMap;
}

class _CreateTask extends State<CreateTask> {
  bool isSwitched = false;
  int? _selectedIndex = 0; // Index of selected chip
  final List<String> _chips = ['Sammy', 'Walter']; // List of chip options

  @override
  Widget build(BuildContext context) {
    String category = widget.dataMap?.keys.elementAt(0) ?? "none";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
        backgroundColor: Constants.lightPrimary,
        titleTextStyle: Constants.appBarStyle,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Align(
          //top left aligned
          alignment: const Alignment(-1.0, 1.0),

          //nesting in a container allows for margin on all sides
          child: Container(
            margin:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            //column which contains all form elements
            child: Column(
              //aligning to the left
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //form heading
                const Text(
                  "Task",
                  textAlign: TextAlign.left,
                  style: Constants.sectionHeading,
                ),

                Constants.formPadding,

                //Textfield
                const Material(
                  borderRadius: Constants.borderRadius,
                  shadowColor: Constants.formfieldColor,
                  elevation: Constants.elevation,
                  color: Colors.white,
                  child: TextField(
                    decoration: InputDecoration(
                        floatingLabelBehavior: Constants.floatingLabelBehaviour,
                        border: Constants.outlineInputBorder,
                        labelText: 'Enter a task (ie. make a bouquet)',
                        fillColor: Colors.white),
                  ),
                ),

                Constants.sectionPadding,

                const Text(
                  "Due Date",
                  textAlign: TextAlign.left,
                  style: Constants.sectionHeading,
                ),

                Constants.formPadding,

                const Material(
                  borderRadius: Constants.borderRadius,
                  shadowColor: Constants.formfieldColor,
                  elevation: Constants.elevation,
                  color: Colors.white,
                  child: TextField(
                    decoration: InputDecoration(
                        //calendar functionality goes here
                        suffixIcon: IconButton(
                          //TODO: Supply Calendar functionality
                          onPressed: null,
                          icon: Icon(Icons.calendar_month_rounded),
                        ),
                        floatingLabelBehavior: Constants.floatingLabelBehaviour,
                        border: Constants.outlineInputBorder,
                        fillColor: Colors.white),
                  ),
                ),

                Constants.sectionPadding,

                const Text(
                  "Description",
                  textAlign: TextAlign.left,
                  style: Constants.sectionHeading,
                ),

                Constants.formPadding,

                const Material(
                  borderRadius: Constants.borderRadius,
                  shadowColor: Constants.formfieldColor,
                  elevation: Constants.elevation,
                  color: Colors.white,
                  child: TextField(
                    decoration: InputDecoration(
                        floatingLabelBehavior: Constants.floatingLabelBehaviour,
                        border: Constants.outlineInputBorder,
                        labelText: 'Enter a brief description of the task',
                        fillColor: Colors.white),
                    minLines: 1,
                    maxLines: 3,
                    maxLength: 255,
                  ),
                ),

                Constants.sectionPadding,

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


                Constants.sectionPadding,

                const Text(
                  "Assigned to",
                  textAlign: TextAlign.left,
                  style: Constants.sectionHeading,
                ),

                Constants.formPadding,

                Wrap(
                    spacing: 30.0,
                    // Creates a list of 2 chips that will highlight the selected ones
                    children: List<Widget>.generate(
                      2,
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
                          elevation: 3.0,
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

                Constants.sectionPadding,

                const Text(
                  "Cost",
                  textAlign: TextAlign.left,
                  style: Constants.sectionHeading,
                ),

                Constants.formPadding,

                Row(
                  children: [
                    const Expanded(
                      child: Material(
                        borderRadius: Constants.borderRadius,
                        shadowColor: Constants.formfieldColor,
                        elevation: Constants.elevation,
                        color: Colors.white,
                        child: TextField(
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  Constants.floatingLabelBehaviour,
                              border: Constants.outlineInputBorder,
                              fillColor: Colors.white),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 10)),
                    Switch(
                      value: isSwitched,
                      //TODO: Toggle Switch and enable/disable cost textfield
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          print(isSwitched);
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ],
                ),

                const Padding(padding: EdgeInsets.only(bottom: 27)),

                //Create Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      print("Information has been saved");
                      Navigator.pop(context);
                    },
                    child:
                        const Text("Create", style: Constants.buttonRedStyle),
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
                              vertical: 25.0, horizontal: 150.0)),
                    ),
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
