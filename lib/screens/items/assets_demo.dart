// ignore: invalid_constant
// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:posse_gallery/screens/items/assets_demo_detail.dart';

class AssetsDemo extends StatefulWidget {
  @override
  _AssetsDemoState createState() => new _AssetsDemoState();
}

class _AssetsDemoState extends State<AssetsDemo> with TickerProviderStateMixin {
  ThemeData _selectedTheme;
  TargetPlatform _targetPlatform;

  Animation<double> _rotationAnimation;
  Animation<FractionalOffset> _slideInAnimation;

  AnimationController _heroAnimationController;

  static const int _kHeroAnimationDuration = 1000;

  _AssetsDemoState() {
    _configureAnimation();
  }

  _configureAnimation() {
    _heroAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kHeroAnimationDuration),
      vsync: this,
    );
    _rotationAnimation = _initAnimation(
        from: 0.0,
        to: 1.0,
        curve: Curves.easeOut,
        controller: _heroAnimationController);
    _slideInAnimation = _initSlideAnimation(
        from: const FractionalOffset(-2.0, 0.0),
        to: const FractionalOffset(0.0, 0.0),
        curve: Curves.decelerate,
        controller: _heroAnimationController);
  }

  @override
  dispose() {
    _heroAnimationController.dispose();
    super.dispose();
  }

  Animation<double> _initAnimation(
      {@required double from,
      @required double to,
      @required Curve curve,
      @required AnimationController controller}) {
    final CurvedAnimation animation = new CurvedAnimation(
      parent: controller,
      curve: curve,
    );
    return new Tween<double>(begin: from, end: to).animate(animation);
  }

  Animation<FractionalOffset> _initSlideAnimation(
      {@required FractionalOffset from,
      @required FractionalOffset to,
      @required Curve curve,
      @required AnimationController controller}) {
    final CurvedAnimation animation = new CurvedAnimation(
      parent: controller,
      curve: curve,
    );
    return new Tween<FractionalOffset>(begin: from, end: to).animate(animation);
  }

  Widget _buildAppBar() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    TextAlign titleTextAlignment = _targetPlatform == TargetPlatform.iOS ? TextAlign.center : TextAlign.left;
    return new Container(
      height: 76.0,
      padding: new EdgeInsets.only(top: statusBarHeight),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new IconButton(
            icon: new Icon(Icons.arrow_back,
                color: _selectedTheme.iconTheme.color),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new Expanded(
            child: new Text(
              "My Recipe Book",
              style: new TextStyle(
                color: _selectedTheme.textTheme.title.color,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
              textAlign: titleTextAlignment,
            ),
          ),
          new IconButton(
            icon: new Icon(
              Icons.more_vert,
              color: _selectedTheme.iconTheme.color,
            ),
            onPressed: () {
              showModalBottomSheet<Null>(
                  context: context,
                  builder: (BuildContext context) {
                    return _buildBottomSheet();
                  },
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildBottomSheet() {
    return new Container(
      height: MediaQuery.of(context).size.height * 0.34,
      color: Colors.white,
    );
  }

  Widget _buildBody() {
    _heroAnimationController.forward();
    return new Expanded(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Padding(
            padding: const EdgeInsets.only(right: 20.0, bottom: 20.0),
            child: new SlideTransition(
              position: _slideInAnimation,
              child: new RotationTransition(
                turns: _rotationAnimation,
                child: new Image(
                  image: new AssetImage("assets/images/brand_apple_pie.png"),
                ),
              ),
            ),
          ),
          new Text(
            "Classic Apple Pie",
            style: new TextStyle(
              color: _selectedTheme.textTheme.title.color,
              fontSize: 22.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
            child: new Image(
              image: new AssetImage("assets/images/brand_profile.png"),
            ),
          ),
          new Text(
            "By Jenny Flay",
            style: new TextStyle(
              color: _selectedTheme.textTheme.subhead.color,
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: new Center(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: new Image(
                      image: new AssetImage("assets/images/brand_stars.png"),
                    ),
                  ),
                  new Text(
                    "120",
                    style: new TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: _selectedTheme.textTheme.body1.color,
                    ),
                  ),
                  new Text(
                    " Mins",
                    style: new TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: _selectedTheme.textTheme.body2.color,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return new Container(
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
      child: new Row(
        children: [
          new Expanded(
            child: new FlatButton(
              color: const Color(0xFF5FAD2C),
              child: new Text(
                "View Recipe",
                style: new TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  new PageRouteBuilder<Null>(
                    settings: new RouteSettings(),
                    pageBuilder: (BuildContext context, Animation<double> _,
                        Animation<double> __) {
                      return new AssetsDetailDemo();
                    },
                    transitionsBuilder: (
                      BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child,
                    ) {
                      return new FadeTransition(
                          opacity: animation, child: child);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentWidget() {
    return new Column(
      children: [
        _buildAppBar(),
        _buildBody(),
        _buildBottomButton(),
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
    _selectedTheme = playfulThemeData;
    return new Theme(
      data: _selectedTheme,
      child: new Material(
        color: _selectedTheme.primaryColor,
        child: _contentWidget(),
      ),
    );
  }
}
