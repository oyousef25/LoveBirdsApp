import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovebirds_app/helper/GuestCRUD/fetchConfirmedGuests.dart';
import 'package:lovebirds_app/helper/GuestCRUD/fetchPendingGuests.dart';
import 'package:lovebirds_app/helper/accountInfo.dart';
import 'package:lovebirds_app/helper/constants.dart';
import 'package:lovebirds_app/helper/fetchAccount.dart';
import 'package:lovebirds_app/helper/guestInfo.dart';

import 'Guest/guestDetails.dart';
import 'Guest/modifyGuest.dart';
import 'helper/GuestCRUD/fetchAllGuests.dart';
import 'helper/GuestCRUD/fetchAllRelationships.dart';

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
  late Future<List<GuestInfo>> _futureGuests;
  late Future<Map<int, String>> _futureRelationships;
  late Future<AccountInfo> _futureAccount;

  int? _selectedIndex = 0; // Index of selected chip
  final List<String> _chips = [
    'All',
    'Confirmed',
    'Pending'
  ]; // List of chip options

  // Reload the guest page with new data
  refreshPage(int? choiceChipIndex, String userEmail) {
    switch (choiceChipIndex) {
      case 1: // Confirmed guests
        _futureGuests = fetchConfirmedGuests(userEmail);
        break;
      case 2: // Pending guests
        _futureGuests = fetchPendingGuests(userEmail);
        break;
      default: // All guests
        _futureGuests = fetchAllGuests(userEmail);
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    // Get the current user's account info
    _futureAccount = fetchAccount();
  }

  /// This Widget builds out the main Guest page
  ///
  /// Given the build [context], return the Guest page Widget.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureAccount,
        // Takes the snapshotted data
        builder: (context, AsyncSnapshot snapshotAccount) {
          // If the data retrieval went wrong
          if (snapshotAccount.hasError) {
            return Center(
              child: Text(
                  'There was an error fetching your account details'),
            );
          } else if (snapshotAccount.hasData) {
            // Get a list of all guests and guest relationships
            _futureGuests = fetchAllGuests(snapshotAccount.data.email);
            _futureRelationships = fetchAllRelationships();

            return FutureBuilder(
                future: _futureRelationships,
                // Takes the snapshotted data
                builder: (context, AsyncSnapshot snapshotRelationship) {
                  // If the data retrieval went wrong
                  if (snapshotRelationship.hasError) {
                    return Center(
                      child: Text(
                          'There was an error fetching the guest relationship data'),
                    );
                  } else if (snapshotRelationship.hasData) {
                    return Scaffold(
                      body: FutureBuilder(
                          future: _futureGuests,
                          // Takes the snapshotted data
                          builder: (context, AsyncSnapshot snapshotGuest) {
                            // If the data retrieval went wrong
                            if (snapshotGuest.hasError) {
                              return Center(
                                child: Text(
                                    'There was an error fetching the guest data'),
                              );
                            } else if (snapshotGuest.hasData) {
                              // Successful data retrieval
                              return NestedScrollView(
                                // Setting floatHeaderSlivers to true is required in order to float
                                // the outer slivers over the inner scrollable.
                                floatHeaderSlivers: true,
                                headerSliverBuilder: (BuildContext context,
                                    bool innerBoxIsScrolled) {
                                  return <Widget>[
                                    SliverAppBar(
                                      floating: true,
                                      expandedHeight: 230.0,
                                      collapsedHeight: 230.0,
                                      backgroundColor: Colors.white,
                                      forceElevated: innerBoxIsScrolled,
                                      flexibleSpace: Stack(
                                        // Image of the vendor (can be cached)
                                        children: [
                                          Column(
                                            children: [
                                              Card(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 25.0,
                                                      horizontal:
                                                          100.0), // Hack for shrinking card padding
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  color:
                                                      Constants.lightSecondary,
                                                  child: ListTile(
                                                      minVerticalPadding: 30.0,
                                                      title: Text(
                                                          '${_chips[_selectedIndex!]}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: Constants
                                                              .cardHeaderStyle),
                                                      subtitle: Text(
                                                          '${snapshotGuest.data.length} Guests',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: Constants
                                                              .cardContentStyle))),
                                              Wrap(
                                                  spacing: 30.0,
                                                  // Creates a list of 3 chips that will highlight the selected ones
                                                  children:
                                                      List<Widget>.generate(
                                                    3,
                                                    (int index) {
                                                      return ChoiceChip(
                                                        label:
                                                            Text(_chips[index]),
                                                        labelStyle: _selectedIndex ==
                                                                index
                                                            ? Constants
                                                                .chipSelectedStyle
                                                            : Constants
                                                                .chipUnselectedStyle,
                                                        selected: _selectedIndex ==
                                                            index, // If selected index IS the index then it is selected
                                                        backgroundColor:
                                                            Colors.white,
                                                        shadowColor:
                                                            Colors.grey,
                                                        elevation: 2.0,
                                                        selectedColor: Constants
                                                            .darkSecondary,
                                                        onSelected:
                                                            (bool selected) {
                                                          // Toggles selected chip only if the user presses on an unselected chip
                                                          if (_selectedIndex !=
                                                              index) {
                                                            setState(() {
                                                              _selectedIndex =
                                                                  selected
                                                                      ? index
                                                                      : null;
                                                              refreshPage(
                                                                  _selectedIndex, snapshotAccount.data.email);
                                                            });
                                                          }
                                                        },
                                                      );
                                                    },
                                                  ).toList()),
                                              // Some padding before the guest list
                                              Padding(
                                                  padding: EdgeInsets.all(5.0)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ];
                                },
                                body: RefreshIndicator(
                                    child: ListView.builder(
                                      // ListView that is built as it is scrolled onto the screen
                                      itemCount: snapshotGuest.data.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 7.0, horizontal: 10.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          color: Colors.white,
                                          shadowColor: Colors.grey,
                                          elevation: 5.0,
                                          child: ListTile(
                                            leading: Icon(
                                                Icons.person_outline_rounded,
                                                size: 40.0),
                                            title: Text(
                                                snapshotGuest
                                                        .data[index].firstName +
                                                    ' ' +
                                                    snapshotGuest
                                                        .data[index].lastName,
                                                textAlign: TextAlign.left,
                                                style:
                                                    Constants.listTitleStyle),
                                            subtitle: Text(
                                                snapshotRelationship.data[
                                                    snapshotGuest.data[index]
                                                        .relationship],
                                                textAlign: TextAlign.left,
                                                style: Constants
                                                    .listSubtitleStyle),
                                            trailing: Icon(
                                                Icons.chevron_right_rounded),
                                            onTap: () {
                                              // Open up the Guest Info route
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    GuestDetailsScreen(
                                                  guestInfo:
                                                      snapshotGuest.data[index],
                                                  guestRelationships:
                                                      snapshotRelationship.data,
                                                  userID: snapshotAccount.data.id,
                                                ),
                                              ));
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    onRefresh: () async => {
                                          // Refresh the guest list
                                          refreshPage(_selectedIndex, snapshotAccount.data.email),
                                        }),
                              );
                            } else {
                              // Loading data animation
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {
                          // Go to add guest page
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ModifyGuestScreen(
                              guestInfo: null,
                              guestRelationships: snapshotRelationship.data,
                              userID: snapshotAccount.data.id,
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
