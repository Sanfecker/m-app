import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/models/providers/homePageProvider.dart';
import 'package:Nuvle/models/providers/mainPageProvider.dart';
import 'package:Nuvle/pages/user/main/profile/profile.dart';
import 'package:Nuvle/styles/colors.dart';
import 'package:Nuvle/styles/nuvleIcons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeDisplayPicture extends StatefulWidget {
  @override
  _ChangeDisplayPictureState createState() => _ChangeDisplayPictureState();
}

class _ChangeDisplayPictureState extends State<ChangeDisplayPicture> {
  PickedFile _pickedFile;

  _handleSubmitted(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('dp', _pickedFile.path);
    setState(() {});
  }

  _pickFile() async {
    try {
      _pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              page == 'home'
                  ? Consumer<HomePageProvider>(
                      builder: (context, pro, child) => Container(
                        height: screenSize.height * 0.1,
                        child: GestureDetector(
                          onTap: () => pro.selectedIndex = 1,
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xFFD2B271),
                                size: 20,
                              ),
                              Text(
                                'Back',
                                style: TextStyle(
                                  color: Color(0xFFD2B271),
                                  fontSize: 14,
                                  letterSpacing: 1,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Consumer<MainPageProvider>(
                      builder: (context, pro, child) => Container(
                        height: screenSize.height * 0.1,
                        child: GestureDetector(
                          onTap: () => pro.selectedIndex = 1,
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xFFD2B271),
                                size: 20,
                              ),
                              Text(
                                'Back',
                                style: TextStyle(
                                  color: Color(0xFFD2B271),
                                  fontSize: 14,
                                  letterSpacing: 1,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              Container(
                width: screenSize.width * 0.60,
                margin: EdgeInsets.only(bottom: 60, top: 20),
                child: Text(
                  "Change Avatar",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    InkResponse(
                      onTap: _pickFile,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 161,
                          width: 161,
                          child: _pickedFile != null
                              ? Image.file(
                                  File(_pickedFile.path),
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  Icons.image,
                                  size: 50,
                                ),
                          decoration: BoxDecoration(color: Color(0xffFF596E)),
                        ),
                      ),
                    ),
                    SizedBox(height: 150),
                    page == 'home'
                        ? Consumer<HomePageProvider>(
                            builder: (context, pro, child) =>
                                Functions().customButton(
                              context,
                              onTap: () {
                                if (_pickedFile != null) {
                                  _handleSubmitted(context);
                                }
                                pro.selectedIndex = 1;
                              },
                              width: screenSize.width,
                              text: "Finish",
                              color: CustomColors.primary900,
                              hasIcon: true,
                              trailing: Icon(
                                NuvleIcons.icon_checkmark,
                                color: Color(0xff474551),
                                size: 14,
                              ),
                            ),
                          )
                        : Consumer<MainPageProvider>(
                            builder: (context, pro, child) =>
                                Functions().customButton(
                              context,
                              onTap: () {
                                if (_pickedFile != null) {
                                  _handleSubmitted(context);
                                }
                                pro.selectedIndex = 1;
                              },
                              width: screenSize.width,
                              text: "Finish",
                              color: CustomColors.primary900,
                              hasIcon: true,
                              trailing: Icon(
                                NuvleIcons.icon_checkmark,
                                color: Color(0xff474551),
                                size: 14,
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
