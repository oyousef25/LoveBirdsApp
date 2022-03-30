import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';

class RegisterAccount extends StatefulWidget {
  const RegisterAccount({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegisterAccount();
  }
}

class _RegisterAccount extends State<RegisterAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Registration'),
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
                "Username",
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
                      labelText: 'Enter a username',
                      fillColor: Colors.white),
                ),
              ),

              Constants.sectionPadding,

              const Text(
                "Email",
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
                      labelText: 'Enter an email',
                      fillColor: Colors.white),
                ),
              ),

              Constants.sectionPadding,

              const Text(
                "Password",
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
                      labelText: 'Enter a password',
                      fillColor: Colors.white),
                ),
              ),

              Constants.sectionPadding,

              const Text(
                "Confirm Password",
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
                      labelText: 'Confirm your password',
                      fillColor: Colors.white),
                ),
              ),

              Constants.sectionPadding,
              Constants.formPadding,

              //Create account button
              Center(
                child: Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      //TODO: Fix create account functionality
                      print("Account has been created");
                      Navigator.pop(context);
                    },
                    child: const Text("Create Account",
                        style: Constants.buttonRedStyle),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Constants.buttonRed),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 25.0, horizontal: 168),
                      ),
                    ),
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
