import 'package:flutter/material.dart';
import 'package:Nuvle/models/providers/homePageProvider.dart';
import 'package:Nuvle/models/providers/mainPageProvider.dart';
import 'package:Nuvle/pages/user/main/profile/profile.dart';
import 'package:provider/provider.dart';

class PaymentMethods extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: page == 'home'
            ? Consumer<HomePageProvider>(
                builder: (context, pro, child) => Container(
                  margin: EdgeInsets.only(left: 20),
                  height: screenSize.height * 0.1,
                  child: GestureDetector(
                    onTap: () => pro.selectedIndex = 1,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFFD2B271),
                      size: 20,
                    ),
                  ),
                ),
              )
            : Consumer<MainPageProvider>(
                builder: (context, pro, child) => Container(
                  margin: EdgeInsets.only(left: 20),
                  height: screenSize.height * 0.1,
                  child: GestureDetector(
                    onTap: () => pro.selectedIndex = 1,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFFD2B271),
                      size: 20,
                    ),
                  ),
                ),
              ),
      ),
      body: Center(
        child: Column(),
      ),
    );
  }
}
