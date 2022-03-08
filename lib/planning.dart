import 'package:flutter/material.dart';

class PlanningPage extends StatefulWidget {
  const PlanningPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlanningPageState();
  }
}

class _PlanningPageState extends State<PlanningPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Planning Page',
            style: TextStyle(color: Colors.black, fontFamily: 'Roboto Slab')),
      ),
    );
  }
}
