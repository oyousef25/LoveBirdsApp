import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/guestInfo.dart';

class GuestsPage extends StatefulWidget {
  const GuestsPage({Key? key, required this.guestList}) : super(key: key); // Guests page key identifier

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
  final List<String> _chips = ['All', 'Confirmed', 'Pending']; // List of chip options

  /// This Widget builds out the main Guest page
  ///
  /// Given the build [context], return the Guest page Widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column( // Column containing 4 rows:
          // 1. Total guests card, 2. Choice chips for filtering, 3. Padding, 4. Guest list
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
            ).toList()
          ),
          Padding(padding: EdgeInsets.all(5.0)), // Some padding before the guest list
          Expanded( // Makes sure that ListView expands to fit inside the column
            child: ListView.builder( // ListView that is built as it is scrolled onto the screen
              itemCount: widget.guestList.length,
              itemBuilder: (context, index) {
                return Card(
                    margin: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    color: Colors.white,
                    shadowColor: Colors.grey,
                    elevation: 5.0,
                    child: ListTile(
                        leading: Icon(Icons.person_outline_rounded, size: 40.0),
                        title: Text(widget.guestList[index].firstName + ' ' + widget.guestList[index].lastName,
                            textAlign: TextAlign.left,
                            style: Constants.listTitleStyle
                        ),
                        subtitle: Text(widget.guestList[index].relationship,
                            textAlign: TextAlign.left,
                            style: Constants.listSubtitleStyle
                        ),
                      trailing: Icon(Icons.chevron_right_rounded),
                      onTap: () { // Open up the Guest Info route
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => GuestDetailsScreen(guestInfo: widget.guestList[index]),
                          )
                        );
                      },
                    ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add a guest when FAB is pressed
        },
        backgroundColor: Constants.lightSecondary,
        child: Icon(Icons.add, size: 50.0),
      ),
    );
  }
}

class GuestDetailsScreen extends StatelessWidget {
  // In the constructor, require a GuestInfo.
  const GuestDetailsScreen({Key? key, required this.guestInfo}) : super(key: key);

  // Declare a field that holds the GuestInfo.
  final GuestInfo guestInfo;

  @override
  Widget build(BuildContext context) {
    // Use the GuestInfo to create the UI.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.lightPrimary,
        title: Center(
          child: Text('Guest Details',
              style: Constants.appBarStyle),
        ),
      ),
      body: Column( // A column with image, guest detail card, and two buttons
        children: <Widget>[
          Padding(padding: EdgeInsets.all(50.0)),
          Icon(Icons.person_outline_rounded, size: 100.0),
          Card(
            shadowColor: Colors.grey,
            elevation: 5.0,
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero)
                  ),
                  margin: EdgeInsets.zero,
                  color: Constants.lightSecondary,
                  child: ListTile(
                    title: Text('Guest Information',
                    textAlign: TextAlign.center,
                    style: Constants.cardHeaderStyle),
                    trailing: Icon(Icons.edit),
                  )
                ),
                ListTile(
                  leading: Text('Full Name', style: Constants.detailGreyedStyle),
                  trailing: Text(guestInfo.firstName + ' ' + guestInfo.lastName, style: Constants.detailStyle),
                ),
                ListTile(
                  leading: Text('Relationship', style: Constants.detailGreyedStyle),
                  trailing: Text(guestInfo.relationship, style: Constants.detailStyle),
                ),
                ListTile(
                  leading: Text('E-mail', style: Constants.detailGreyedStyle),
                  trailing: Text(guestInfo.email, style: Constants.detailStyle),
                ),
                ListTile(
                  leading: Text('Phone #', style: Constants.detailGreyedStyle),
                  trailing: Text(guestInfo.phoneNum, style: Constants.detailStyle),
                ),
              ],
            ),
          ),
          Row( // This row contains the two buttons for removing and contacting a guest
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(onPressed: () {
                // TODO: Remove guest functionality goes here
              },
                child: Text('Remove Guest', style: Constants.buttonRedStyle),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Constants.buttonRed),
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0)),
                )
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),),
              ElevatedButton(
                onPressed: () {
                // TODO: Contact guest functionality goes here
                },
                child: Text('Contact Guest', style: Constants.buttonWhiteStyle),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
