import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';

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
  int? _selectedIndex = 0; // Index of selected chip
  final List<String> _chips = ['All', 'Confirmed', 'Pending']; // List of chip options
  // List<String> guestNames = List<String>.generate(1000, (index) => 'Guest $index');
  // List<String> guestRelationships = List<String>.generate(1000, (index) => '???');

  /// This Widget builds out the main Guest page
  ///
  /// Given the build [context], return the Guest page Widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: <Widget>[
          Card(
              margin: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 100.0), // Hack for shrinking card padding
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),
              color: Constants.lightSecondary,
              child: const ListTile(
                  minVerticalPadding: 30.0,
                  title: Text('Total Guests',
                      textAlign: TextAlign.center,
                      style: Constants.cardHeaderStyle
                  ),
                  subtitle: Text('XX Guests',
                      textAlign: TextAlign.center,
                      style: Constants.cardContentStyle
                  )
              )
          ),
          Wrap(
            spacing: 30.0,
            // Creates a list of 3 chips that will highlight the selected ones
            children: List<Widget>.generate(
              3, (int index) {
                return ChoiceChip(
                  label: Text(_chips[index]),
                  labelStyle: _selectedIndex == index ? Constants.chipSelectedStyle : Constants.chipUnselectedStyle,
                  selected: _selectedIndex == index, // If selected index IS the index then it is selected
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
            ).toList()
          ),
          // ListView.builder(
          //   itemCount: guestNames.length,
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       title: Text(guestNames[index]),
          //       subtitle: Text(guestRelationships[index]),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
