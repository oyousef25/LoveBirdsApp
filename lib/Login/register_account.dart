import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Network_Utils/api.dart';
import '../main.dart';
import 'login.dart';

class RegisterAccount extends StatefulWidget {
  const RegisterAccount({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegisterAccount();
  }
}

class _RegisterAccount extends State<RegisterAccount> {
  final _formKey = GlobalKey<FormState>();
  var username;
  var email;
  var password;

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // _scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Registration'),
        centerTitle: true,
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
          child: Form(
            key: _formKey,
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
              Material(
                borderRadius: Constants.borderRadius,
                shadowColor: Constants.formfieldColor,
                elevation: Constants.elevation,
                color: Colors.white,
                child: TextFormField(
                  decoration: InputDecoration(
                      floatingLabelBehavior: Constants.floatingLabelBehaviour,
                      border: Constants.outlineInputBorder,
                      labelText: 'Enter a username',
                      fillColor: Colors.white),

                  validator: (String? usernameValue){
                    if (usernameValue != null && usernameValue.isEmpty) {
                      return 'Please enter username';
                    }
                    username = usernameValue;
                    return null;
                  },
                ),
              ),

              Constants.sectionPadding,

              const Text(
                "Email",
                textAlign: TextAlign.left,
                style: Constants.sectionHeading,
              ),

              Constants.formPadding,

              Material(
                borderRadius: Constants.borderRadius,
                shadowColor: Constants.formfieldColor,
                elevation: Constants.elevation,
                color: Colors.white,
                child: TextFormField(
                  decoration: InputDecoration(
                      floatingLabelBehavior: Constants.floatingLabelBehaviour,
                      border: Constants.outlineInputBorder,
                      labelText: 'Enter an email',
                      fillColor: Colors.white),

                  validator: (String? emailValue){
                    if (emailValue != null && emailValue.isEmpty) {
                      return 'Please enter email';
                    }
                    email = emailValue;
                    return null;
                  },
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
              Material(
                borderRadius: Constants.borderRadius,
                shadowColor: Constants.formfieldColor,
                elevation: Constants.elevation,
                color: Colors.white,
                child: TextFormField(
                  decoration: InputDecoration(
                      floatingLabelBehavior: Constants.floatingLabelBehaviour,
                      border: Constants.outlineInputBorder,
                      labelText: 'Enter a password',
                      fillColor: Colors.white),

                  validator: (String? passwordValue){
                    if (passwordValue != null && passwordValue.isEmpty) {
                      return 'Please enter password';
                    }
                    password = passwordValue;
                    return null;
                  },
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
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      //TODO: Fix create account functionality
                      if(_formKey.currentState?.validate() != null) {
                        _register();
                      }
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
      ),
    );
  }

  void _register() async{
    var data = {
      'email' : email,
      'password': password,
      'name' : username,
    };

    var res = await Network().authData(data, '/register');
    var body = json.decode(res.body);
    if(body['success']){
      // Store the user tokens so user can be automatically logged in
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));

      // Message to show that user was successful in creating an account
      _showMsg('Successfully created account!');

      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (context) => const Login()
        ),
      );
    }
  }
}
