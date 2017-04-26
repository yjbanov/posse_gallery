// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:posse_gallery/screens/items/assets_demo.dart';

class AssetsDetailDemo extends AssetsDemo {
  @override
  _AssetsDetailDemoState createState() => new _AssetsDetailDemoState();
}

class _AssetsDetailDemoState extends AssetsDemoState {

//  Widget _buildAppBar() {
//    final double statusBarHeight = MediaQuery.of(context).padding.top;
//    TextAlign titleTextAlignment = targetPlatform == TargetPlatform.iOS ? TextAlign.center : TextAlign.left;
//    return new Container(
//      height: 76.0,
//      padding: new EdgeInsets.only(top: statusBarHeight),
//      child: new Row(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: [
//          new IconButton(
//            icon: new Icon(Icons.arrow_back,
//                color: _selectedTheme.iconTheme.color),
//            onPressed: () {
//              Navigator.of(context).pop();
//            },
//          ),
//          new Expanded(
//            child: new Text(
//              "Classic Apple Pie",
//              style: new TextStyle(
//                color: _selectedTheme.textTheme.title.color,
//                fontWeight: FontWeight.w500,
//                fontSize: 16.0,
//              ),
//              textAlign: titleTextAlignment,
//            ),
//          ),
//          new IconButton(
//            icon: new Icon(
//              Icons.more_vert,
//              color: _selectedTheme.iconTheme.color,
//            ),
//            onPressed: null,
//          )
//        ],
//      ),
//    );
//  }

  Widget buildBody() {
    return new Expanded(
      child: new Column(
        children: [
          new Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: new Column(
              children: [
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Padding(
                      padding: const EdgeInsets.only(top: 14.0, right: 10.0),
                      child: new Image(
                        image: new AssetImage("assets/images/brand_egg.png"),
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: new Image(
                        image: new AssetImage("assets/images/brand_flour.png"),
                      ),
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: new Image(
                        image:
                            new AssetImage("assets/images/brand_cinnamon.png"),
                      ),
                    ),
                    new Image(
                      image: new AssetImage("assets/images/brand_salt.png"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: new Text(
              "INGREDIENTS",
              style: new TextStyle(
                color: _selectedTheme.textTheme.title.color,
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 2.0,
              ),
            ),
          ),
          new Text(
            "2 Cups all-purpose flour\n"
                "3/4 teaspoon salt\n"
                "1 cup vegetable shortening\n"
                "1 egg\n"
                "2 tablespoons of cold water\n"
                "1 tablespoon of cinnamon",
            textAlign: TextAlign.center,
            style: new TextStyle(
                color: _selectedTheme.textTheme.body1.color,
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget buildBottomButton() {
    return new Container(
      height: 50.0,
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
      child: new Row(
        children: [
          new Expanded(
            child: new FlatButton(
              color: selectedTheme.buttonColor,
              child: new Text(
                "Step 1: Make Crust",
                style: new TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentWidget() {
    return new Column(
      children: [
        buildAppBar(),
        buildBody(),
        buildBottomButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _targetPlatform = TargetPlatform.android;
    TextTheme luxuryTextTheme = Theme.of(context).textTheme;
    TextStyle luxuryTitleTextStyle =
        luxuryTextTheme.title.copyWith(color: const Color(0xFF4A4A4A));
    TextStyle luxurySubheadTextStyle =
        luxuryTextTheme.subhead.copyWith(color: const Color(0xFFAAAAAA));
    TextStyle luxuryBody1TextStyle =
        luxuryTextTheme.body1.copyWith(color: const Color(0xFF4A4A4A));
    TextStyle luxuryBody2TextStyle =
        luxuryTextTheme.body2.copyWith(color: const Color(0xFF979797));
    TextStyle luxuryButtonTextStyle =
        luxuryTextTheme.button.copyWith(color: Colors.white);
    ThemeData luxuryThemeData = new ThemeData(
      primaryColor: Colors.white,
      buttonColor: const Color(0xFF5FAD2C),
      iconTheme: const IconThemeData(color: const Color(0xFFD1D1D1)),
      textTheme: new TextTheme(
        title: luxuryTitleTextStyle,
        subhead: luxurySubheadTextStyle,
        body1: luxuryBody1TextStyle,
        body2: luxuryBody2TextStyle,
        button: luxuryButtonTextStyle,
      ),
      brightness: Brightness.light,
      platform: _targetPlatform,
    );
    ThemeData playfulThemeData = new ThemeData(
      primaryColor: const Color(0xFFF0465A),
      buttonColor: const Color(0xFF1DBC98),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: new Typography(platform: _targetPlatform).white,
      brightness: Brightness.light,
      platform: Theme.of(context).platform,
    );
    ThemeData darkTheme = new ThemeData(
      primaryColor: const Color(0xFF212121),
      buttonColor: const Color(0xFF4A4A4A),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: new Typography(platform: _targetPlatform).white,
      brightness: Brightness.dark,
      platform: Theme.of(context).platform,
    );
    _selectedTheme = luxuryThemeData;
    return new Theme(
      data: _selectedTheme,
      child: new Material(
        color: _selectedTheme.primaryColor,
        child: _contentWidget(),
      ),
    );
  }
}
