import 'package:flutter/material.dart';
import 'package:food_guardian/screens/account_page.dart';
import 'package:food_guardian/screens/home_page.dart';

import '../styles/spacings.dart';
import 'favorites_page.dart';
import 'history_page.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  void changePageIndex(int newIndex) {
    setState(() {
      currentPageIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: kNavigationBarHeight,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        HomePage(onPageChanged: changePageIndex),

        /// Favorites page
        const FavoritesPage(),

        /// Scan page
        const Placeholder(),

        /// History page
        const HistoryPage(),

        /// Account page
        const AccountPage(),

      ][currentPageIndex],
    );
  }
}
