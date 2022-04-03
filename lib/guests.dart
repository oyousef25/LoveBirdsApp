import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/guestInfo.dart';

import 'Guest/guestDetails.dart';
import 'Guest/modifyGuest.dart';

class GuestsPage extends StatefulWidget {
  const GuestsPage({Key? key, required this.guestList})
      : super(key: key); // Guests page key identifier

  // Require guest data to be passed into this Widget
  final List<GuestInfo> guestList;

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
  final List<String> _chips = [
    'All',
    'Confirmed',
    'Pending'
  ]; // List of chip options

  /// This Widget builds out the main Guest page
  ///
  /// Given the build [context], return the Guest page Widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: 800,
            child: Column(
              // Column containing 4 rows:
              // 1. Total guests card, 2. Choice chips for filtering, 3. Padding, 4. Guest list
              children: <Widget>[
                Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 25.0,
                        horizontal: 100.0), // Hack for shrinking card padding
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Constants.lightSecondary,
                    child: const ListTile(
                        minVerticalPadding: 30.0,
                        title: Text('Total Guests',
                            textAlign: TextAlign.center,
                            style: Constants.cardHeaderStyle),
                        subtitle: Text('XX Guests',
                            textAlign: TextAlign.center,
                            style: Constants.cardContentStyle))),
                Wrap(
                    spacing: 30.0,
                    // Creates a list of 3 chips that will highlight the selected ones
                    children: List<Widget>.generate(
                      3,
                          (int index) {
                        return ChoiceChip(
                          label: Text(_chips[index]),
                          labelStyle: _selectedIndex == index
                              ? Constants.chipSelectedStyle
                              : Constants.chipUnselectedStyle,
                          selected: _selectedIndex ==
                              index, // If selected index IS the index then it is selected
                          backgroundColor: Colors.white,
                          shadowColor: Colors.grey,
                          elevation: 2.0,
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
                    ).toList()),
                Padding(
                    padding:
                    EdgeInsets.all(5.0)), // Some padding before the guest list
                Expanded(
                  // Makes sure that ListView expands to fit inside the column
                  child: ListView.builder(
                    // ListView that is built as it is scrolled onto the screen
                    itemCount: widget.guestList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Colors.white,
                        shadowColor: Colors.grey,
                        elevation: 5.0,
                        child: ListTile(
                          leading: Icon(Icons.person_outline_rounded, size: 40.0),
                          title: Text(
                              widget.guestList[index].firstName +
                                  ' ' +
                                  widget.guestList[index].lastName,
                              textAlign: TextAlign.left,
                              style: Constants.listTitleStyle),
                          subtitle: Text(widget.guestList[index].relationship,
                              textAlign: TextAlign.left,
                              style: Constants.listSubtitleStyle),
                          trailing: Icon(Icons.chevron_right_rounded),
                          onTap: () {
                            // Open up the Guest Info route
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GuestDetailsScreen(
                                  guestInfo: widget.guestList[index]),
                            ));
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            ),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Go to add guest page
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ModifyGuestScreen(
              guestInfo: null,
            ),
          ));
        },
        backgroundColor: Constants.lightSecondary,
        child: Icon(
          Icons.add,
          size: 50.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

