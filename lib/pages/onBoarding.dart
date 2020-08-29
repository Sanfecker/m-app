import 'package:flutter/material.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/providers/onBoardProvider.dart';
import 'package:nuvlemobile/pages/auth/login/loginEmail.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:provider/provider.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
        initialPage:
            Provider.of<OnBoardProvider>(context, listen: false).selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: PageView(
              controller: _pageController,
              onPageChanged: (i) =>
                  Provider.of<OnBoardProvider>(context, listen: false)
                      .selectedIndex = i,
              children:
                  Provider.of<OnBoardProvider>(context, listen: false).pages(),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: () =>
                      Functions().transitTo(context, LoginEmailPage()),
                  child: Text(
                    "Skip",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Row(
                  children: [
                    for (int i = 0;
                        i <
                            Provider.of<OnBoardProvider>(context, listen: false)
                                .pages()
                                .length;
                        i++)
                      Consumer<OnBoardProvider>(builder: (context, pro, child) {
                        bool isCurrent = pro.selectedIndex == i;
                        return Container(
                          // padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(right: 5),
                          width: isCurrent ? 24 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: isCurrent
                                ? CustomColors.primary
                                : Color(0xffE4E4E4),
                            borderRadius:
                                BorderRadius.circular(isCurrent ? 6 : 10),
                          ),
                        );
                      }),
                  ],
                ),
                FlatButton(
                  onPressed: () {
                    if (Provider.of<OnBoardProvider>(context, listen: false)
                                .selectedIndex +
                            1 ==
                        Provider.of<OnBoardProvider>(context, listen: false)
                            .pages()
                            .length) {
                      Functions().scaleTo(context, LoginEmailPage());
                    } else {
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    }
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: CustomColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
