import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key); // Home page key identifier

  /// Creates a state
  ///
  /// Return the Home page State
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  /// This Widget builds out the Home page
  ///
  /// Given the build [context], return the Home page Widget.
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home Page',
            style: TextStyle(color: Colors.black, fontFamily: 'Roboto Slab')),
      ),
    );
  }
}
