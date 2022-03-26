import 'package:flutter/material.dart';
import 'package:lovebirds_app/account.dart';
import 'package:lovebirds_app/guests.dart';
import 'package:lovebirds_app/helper/guestInfo.dart';
import 'package:lovebirds_app/helper/vendorInfo.dart';
import 'package:lovebirds_app/home.dart';
import 'package:lovebirds_app/planning.dart';
import 'package:lovebirds_app/vendors.dart';
import 'package:lovebirds_app/helper/constants.dart';

/// Main app
///
/// Runs the main app
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Main app key identifier

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Don't show the debug banner icon
      title: 'LoveBirds',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Constants.appMaterialSwatch,
        // Default font family
        fontFamily: 'Roboto Slab',
        primaryTextTheme:
            const TextTheme(titleSmall: TextStyle(color: Colors.black)),
      ),
      home: const MainPage(title: 'LoveBirds'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title})
      : super(key: key); // Main page key identifier

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title; // Top header

  /// Creates a state
  ///
  /// Return the Main page State
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPage = 0; // Current selected page index of the bottom nav
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    PlanningPage(),
    // TODO: Replace seeded List with API list of guests
    GuestsPage(guestList: List<GuestInfo>.generate(1000, (i) => GuestInfo('Guest', '$i', 'Hummus', 'email$i@ex.com', 'XXX-XXXX'))),
    VendorsPage(vendorList: List<VendorInfo>.generate(50, (i) => VendorInfo('Hummus Wedding', '5.0', 'This vendor sells wedding hummus', true, '12pm-5pm', 'abc.com', '(890)123-4567', "Windsor, ON"))),
    AccountPage(),
  ];

  /// Trigger bottom nav item tap
  ///
  /// Given an [index] set the selected page to it.
  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.lightPrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(
          child: Text(widget.title,
          style: Constants.appBarStyle),
        )
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedPage),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.house_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_calendar_rounded),
              label: 'Planning',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_contact_calendar_rounded),
              label: 'Guests',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront_rounded),
              label: 'Vendors',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts_rounded),
              label: 'Account',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Constants.lightPrimary,
          currentIndex: _selectedPage,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          onTap:
              _onItemTapped), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
