import 'package:flutter/material.dart';

class VendorsPage extends StatefulWidget {
  const VendorsPage({Key? key}) : super(key: key); // Vendors page key identifier

  /// Creates a state
  ///
  /// Return the Vendors page State
  @override
  State<StatefulWidget> createState() {
    return _VendorsPageState();
  }
}

class _VendorsPageState extends State<VendorsPage> {
  /// This Widget builds out the Vendors page
  ///
  /// Given the build [context], return the Vendors page Widget.
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Vendors Page',
            style: TextStyle(color: Colors.black, fontFamily: 'Roboto Slab')),
      ),
    );
  }
}