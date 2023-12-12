import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:food_guardian/screens/account_page.dart';
import 'package:food_guardian/screens/home_page.dart';
import 'package:food_guardian/screens/product_detail_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/product.dart';
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
  String _scanBarcode = 'Unknown';


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    /*String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      debugPrint(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }*/

    var url = Uri.parse('https://world.openfoodfacts.org/api/v0/product/80050834?fields=product_name,nutriscore_grade,allergens,ingredients_text,traces,image_url,brands');
    var jsonString = await http.read(url);

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    Product product = Product.fromJson(jsonMap);

    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetail(product: product),
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
