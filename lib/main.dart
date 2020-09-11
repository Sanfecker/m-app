import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Nuvle/misc/strings.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:Nuvle/pages/auth/login/loginEmail.dart';
import 'package:Nuvle/pages/onBoarding.dart';
import 'package:Nuvle/pages/user/homepage.dart';
import 'package:Nuvle/pages/user/main/mainPage.dart';
import 'package:Nuvle/services/providerRegistry.dart';
import 'package:Nuvle/styles/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String currentUserDetails = prefs.getString(Strings.currentUserSPKey);
  bool hasSeenOnBoard = prefs.getBool(Strings.hasSeenOnBoardSPKey) ?? false;
  UserAccount userAccount;
  if (currentUserDetails != null) {
    userAccount = UserAccount.fromJson(jsonDecode((currentUserDetails)));
  }
  runApp(AppRoot(
    hasSeenOnBoard: hasSeenOnBoard,
    userAccount: userAccount,
  ));
}

class AppRoot extends StatelessWidget {
  final UserAccount userAccount;
  final bool hasSeenOnBoard;

  AppRoot({Key key, this.userAccount, this.hasSeenOnBoard}) : super(key: key);

  final Map<int, Color> color = {
    50: Color.fromRGBO(192, 163, 104, .1),
    100: Color.fromRGBO(192, 163, 104, .2),
    200: Color.fromRGBO(192, 163, 104, .3),
    300: Color.fromRGBO(192, 163, 104, .4),
    400: Color.fromRGBO(192, 163, 104, .5),
    500: Color.fromRGBO(192, 163, 104, .6),
    600: Color.fromRGBO(192, 163, 104, .7),
    700: Color.fromRGBO(192, 163, 104, .8),
    800: Color.fromRGBO(192, 163, 104, .9),
    900: Color.fromRGBO(192, 163, 104, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: registerProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nuvlet',
        theme: ThemeData(
          primarySwatch: MaterialColor(0xffC0A368, color),
          canvasColor: Color(0xff363A47),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          unselectedWidgetColor: Colors.transparent,
          buttonTheme: ButtonThemeData(
            splashColor: CustomColors.primary900,
            buttonColor: CustomColors.primary100,
          ),
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(
            color: Color(0xff21252B),
            brightness: Brightness.dark,
            iconTheme: IconThemeData(
              color: CustomColors.primary,
            ),
          ),
          scaffoldBackgroundColor: Color(0xff21252B),
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ).apply(
            bodyColor: Colors.white,
          ),
        ),
        home: userAccount != null
            ? userAccount.tab != null
                ? MainPage(userAccount: userAccount)
                : HomePage(userAccount: userAccount)
            : hasSeenOnBoard ? LoginEmailPage() : OnBoarding(),
      ),
    );
  }
}
