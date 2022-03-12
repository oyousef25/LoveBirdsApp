import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key); // Account page key identifier

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
    return const Scaffold(
      body: Center(
        child: Text('Account Page',
            style: TextStyle(color: Colors.black, fontFamily: 'Roboto Slab')),
      ),
    );
  }
}
