import 'package:flutter/material.dart';
import 'package:Nuvle/components/widgets/onboarding/onBoardingWidgetOne.dart';
import 'package:Nuvle/models/skeltons/onBoarding/onBoardData.dart';

class OnBoardProvider extends ChangeNotifier {
  pages() => [
        OnBoardingWidgetOne(
          onBoardData: OnBoardData(
              description:
                  "Own your dining out experience. See your options before choosing",
              title: "Visual menus help you choose your meal",
              img: "assets/images/onboarding 11.png"),
        ),
        OnBoardingWidgetOne(
          onBoardData: OnBoardData(
              description:
                  "Order for yourself and others on your table and request the attention of a waiter",
              title: "Order and be served seamlessly",
              img: "assets/images/onboarding 12.png"),
        ),
        OnBoardingWidgetOne(
          onBoardData: OnBoardData(
              description:
                  "Connect your card once and pay securely with your mobile device",
              title: "Pay with ease from your device",
              img: "assets/images/illustration page 7.png"),
        ),
      ];

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  set selectedIndex(int val) {
    _selectedIndex = val;
    notifyListeners();
  }
}
