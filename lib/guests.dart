import 'package:flutter/material.dart';

class GuestsPage extends StatefulWidget {
  const GuestsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GuestsPageState();
  }
}

class _GuestsPageState extends State<GuestsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Guests Page',
            style: TextStyle(color: Colors.black, fontFamily: 'Roboto Slab')),
      ),
    );
  }
}
