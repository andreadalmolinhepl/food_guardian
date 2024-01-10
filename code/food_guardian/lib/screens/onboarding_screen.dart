import 'package:flutter/material.dart';
import 'package:food_guardian/styles/others.dart';
import 'package:food_guardian/styles/spacings.dart';

import '../styles/font.dart';
import '../widgets/main_button.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = "/onboarding";

  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageContent() {
    return [
      _onboardingPage(
          image: 'assets/images/onboarding1.png',
          title: 'Welcome to Food Guardian',
          text: 'Discover a new way to manage your food intake.'
      ),
      _onboardingPage(
          image: 'assets/images/onboarding2.png',
          title: 'Track Your Allergies',
          text: 'Keep an eye on what matters most for your health.'
      ),
      _onboardingPage(
          image: 'assets/images/onboarding3.png',
          title: 'Stay Healthy',
          text: 'Enjoy a healthier lifestyle with personalized food recommendations.'
      ),
    ];
  }

  Widget _onboardingPage({
    required String image,
    required String title,
    required String text
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // evenly space the elements vertically
      children: <Widget>[
        const Expanded(
          flex: 6,
          child: Padding(
            padding: EdgeInsets.all(kHorizontalPaddingXL),
            child: Image(
              image: AssetImage("assets/img/food.png"),
              height: kProfileSize,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: kLargeMessageFontsize,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(kHorizontalPadding),
            child: Text(
                text,
                textAlign: TextAlign.center
            ),
          ),
        ),
        if (_currentPage == 2)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kHorizontalPadding),
            child: MainButton(
              label: "Let's go !",
              onTap: () => Navigator.pushNamed(context, "/welcome"),
              mainColor: false,
            ),
          ),
      ],
    );
  }


  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: kAnimatedContainerAnimationTime),
      margin: const EdgeInsets.symmetric(horizontal: kVerticalPaddingXS),
      height: kAnimatedContainerHeight,
      width: isActive ? kAnimatedContainerWidthActive : kAnimatedContainerWidthInactive,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(kButtonBorderRadiusM)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kHorizontalPaddingS),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: _buildPageContent(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
