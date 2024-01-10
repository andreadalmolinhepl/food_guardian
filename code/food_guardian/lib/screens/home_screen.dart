import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:food_guardian/screens/mainMenuPages/account_page.dart';
import 'package:food_guardian/screens/mainMenuPages/home_page.dart';
import 'package:food_guardian/screens/product_detail_screen.dart';
import 'package:food_guardian/styles/others.dart';

import '../styles/spacings.dart';
import 'mainMenuPages/favorites_page.dart';
import 'mainMenuPages/history_page.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetail(barcode: barcodeScanRes),
        ),
      );
    }
  }

  void changePageIndex(int newIndex) {
    setState(() {
      currentPageIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: kNavigationBarHeight,
        onDestinationSelected: (int index) {
          setState(() {
            if (index == 2) {
              scanBarcodeNormal();
              return;
            }
            setState(() {
              currentPageIndex = index;
            });
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          const NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          const NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: const NavigationDestination(
                icon: Icon(Icons.qr_code_scanner),
                label: 'Scan',
              ),
            ),
          ),
          const NavigationDestination(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          const NavigationDestination(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        HomePage(onPageChanged: changePageIndex, scanBarcodeRequest: scanBarcodeNormal),

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
