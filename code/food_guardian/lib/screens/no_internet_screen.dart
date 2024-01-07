import 'package:flutter/material.dart';
import 'package:food_guardian/widgets/main_button.dart';
import '../styles/font.dart';
import '../styles/spacings.dart';

class NoInternetScreen extends StatelessWidget {
  static const String routeName = "/no_internet";

  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - kNavigationBarHeight,
          ),
          child: IntrinsicHeight(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const Image(
                      image: AssetImage("assets/img/no_internet.png"),
                      height: kProfileSize,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: kVerticalPaddingL),
                    const Text(
                      "Oops! No Internet Connection",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: kVerticalPadding),
                    const Text(
                      "Please check your internet connection and try again.",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    MainButton(
                      onTap: () => Navigator.of(context).pushNamed("/splash"),
                      mainColor: false,
                      label: "Retry",
                    ),
                    const SizedBox(height: kVerticalPaddingL),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
