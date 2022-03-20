import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';

class EditTask extends StatefulWidget {
  const EditTask({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditTask();
  }
}

class _EditTask extends State<EditTask> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        backgroundColor: Constants.lightPrimary,
        titleTextStyle: Constants.appBarStyle,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Align(
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
                  minLines: 2,
                  maxLines: 3,
                  maxLength: 255,
                ),
              ),

              Constants.sectionPadding,

              const Text(
                "Assigned to",
                textAlign: TextAlign.left,
                style: Constants.sectionHeading,
              ),

              Constants.formPadding,

              Row(
                children: [
                  //the spouse chips
                  InputChip(
                    isEnabled: true,
                    backgroundColor: Constants.pinkSpouse,
                    label: const Text("Sammy"),
                    labelStyle: Constants.chipSelectedStyle,
                    padding: const EdgeInsets.only(
                        top: 10, left: 40, right: 40, bottom: 10),
                    //TODO: Assign spouse 1 the task
                    onPressed: () {
                      print("Spouse 1 has been selected");
                    },
                  ),

                  const Padding(padding: EdgeInsets.only(right: 20)),

                  InputChip(
                    isEnabled: true,
                    backgroundColor: Constants.blueSpouse,
                    label: const Text("Walter"),
                    labelStyle: Constants.chipSelectedStyle,
                    padding: const EdgeInsets.only(
                        top: 10, left: 40, right: 40, bottom: 10),
                    //TODO: Assign spouse 2 the task
                    onPressed: () {
                      print("Spouse 2 has been selected");
                    },
                  )
                ],
              ),

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
                  child: const Text("Save", style: Constants.buttonRedStyle),
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
    );
  }
}
