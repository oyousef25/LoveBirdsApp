import 'package:flutter/material.dart';

class GuestsPage extends StatefulWidget {
  const GuestsPage({Key? key}) : super(key: key); // Guests page key identifier

  /// Creates a state
  ///
  /// Return the Guest page State
  @override
  State<StatefulWidget> createState() {
    return _GuestsPageState();
  }
}

class _GuestsPageState extends State<GuestsPage> {
  /// This Widget builds out the main Guest page
  ///
  /// Given the build [context], return the Guest page Widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const <Widget>[
          Card(
              child: ListTile(
                  title: Text('Total Guests', textAlign: TextAlign.center),
                  subtitle: Text('XX Guests', textAlign: TextAlign.center)
              )
          )
        ],
      ),
    );
  }
}
