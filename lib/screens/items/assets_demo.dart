// ignore: invalid_constant
// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:posse_gallery/screens/items/assets_demo_detail.dart';

class AssetsDemo extends StatefulWidget {
  @override
  AssetsDemoState createState() => new AssetsDemoState();
}

class AssetsDemoState extends State<AssetsDemo> with TickerProviderStateMixin {
  static const int _kHeroAnimationDuration = 1000;
  ThemeData selectedTheme;
  ThemeData luxuryThemeData;
  ThemeData playfulThemeData;
  ThemeData darkTheme;

  TargetPlatform targetPlatform;

  Animation<double> _rotationAnimation;
  Animation<FractionalOffset> _slideInAnimation;
  AnimationController _heroAnimationController;

  String appBarTitle;
  String bottomButtonTitle;

  TabController _tabController;

  final List<Tab> _tabs = [
    new Tab(
      text: "LUXURY",
      icon: new ImageIcon(
        new AssetImage("assets/icons/ic_assets_diamond.png"),
      ),
    ),
    new Tab(
      text: "PLAYFUL",
      icon: new ImageIcon(
        new AssetImage("assets/icons/ic_assets_smiley.png"),
      ),
    ),
    new Tab(
      text: "DARK",
      icon: new ImageIcon(
        new AssetImage("assets/icons/ic_assets_moon.png"),
      ),
    ),
  ];

  AssetsDemoState() {
    _configureAnimation();
  }

  @override
  Widget build(BuildContext context) {
    _configureThemes();
    if (_tabController.index == 0) {
      selectedTheme = luxuryThemeData;
    } else if (_tabController.index == 1) {
      selectedTheme = playfulThemeData;
    } else if (_tabController.index == 2) {
      selectedTheme = darkTheme;
    } else {
      selectedTheme = luxuryThemeData;
    }
    return new Theme(
      data: selectedTheme,
      child: new Material(
        color: selectedTheme.primaryColor,
        child: _contentWidget(),
      ),
    );
  }

  Widget buildAppBar() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    TextAlign titleTextAlignment = targetPlatform == TargetPlatform.android
        ? TextAlign.center
        : TextAlign.left;
    return new Container(
      height: 76.0,
      padding: new EdgeInsets.only(top: statusBarHeight),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new BackButton(),
          new Expanded(
            child: new Text(
              appBarTitle,
              style: new TextStyle(
                color: selectedTheme.textTheme.title.color,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
              textAlign: titleTextAlignment,
            ),
          ),
          new IconButton(
            icon: new Icon(
              Icons.more_vert,
              color: selectedTheme.iconTheme.color,
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

  Widget buildBody() {
    _heroAnimationController.forward();
    return new Expanded(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: new SlideTransition(
              position: _slideInAnimation,
              child: new RotationTransition(
                turns: _rotationAnimation,
                child: new Container(
                  decoration: _buildRadialGradient(),
                  child: new Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: new Image(
                      image:
                          new AssetImage("assets/images/brand_apple_pie.png"),
                    ),
                  ),
                ),
              ),
            ),
          ),
          new Text(
            "Classic Apple Pie",
            style: new TextStyle(
              color: selectedTheme.textTheme.title.color,
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
              color: selectedTheme.textTheme.subhead.color,
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
                      color: selectedTheme.textTheme.body1.color,
                    ),
                  ),
                  new Text(
                    " Mins",
                    style: new TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: selectedTheme.textTheme.body2.color,
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

  Widget buildBottomButton() {
    double buttonBorderRadius =
        targetPlatform == TargetPlatform.iOS ? 2.0 : 0.0;
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(buttonBorderRadius),
      ),
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
      child: new Row(
        children: [
          new Expanded(
            child: new FlatButton(
              color: const Color(0xFF5FAD2C),
              child: new Text(
                bottomButtonTitle,
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

  @override
  dispose() {
    _heroAnimationController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();

    appBarTitle = "My Recipe Book";
    bottomButtonTitle = "View Recipe";

    _configureUI();
    _registerObservables();
  }

  Widget _buildBottomSheet() {
    return new Container(
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.white,
      child: new Material(
        child: new Column(
          children: [
            new Align(
              alignment: FractionalOffset.centerRight,
              child: new IconButton(
                icon: new Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            new Expanded(
              child: new Center(
                child: new Padding(
                  padding: const EdgeInsets.only(
                      left: 50.0, right: 50.0, bottom: 42.0),
                  child: new Text(
                    "Toggle between themes to see how changing elements can give an app a whole new identity.",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      letterSpacing: 0.6,
                      fontSize: 16.0,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ),
            _buildTabBar(),
          ],
        ),
      ),
    );
  }

  _buildRadialGradient() {
    if (_tabController.index == 1) {
      return new BoxDecoration(
        gradient: new RadialGradient(
          center: FractionalOffset.center,
          radius: 0.5,
          colors: [
            Colors.white,
            const Color(0xFFF68D99),
            selectedTheme.primaryColor,
          ],
          stops: [0.0, 0.35, 1.0],
        ),
      );
    } else {
      return null;
    }
  }

  Widget _buildTabBar() {
    TabBar tabBar = new TabBar(
      controller: _tabController,
      isScrollable: false,
      labelColor: Theme.of(context).primaryColor,
      unselectedLabelColor: const Color(0xFFAAAAAA),
      indicatorColor: Theme.of(context).primaryColor,
      labelStyle: new TextStyle(
        fontSize: 14.0,
      ),
      tabs: _tabs,
    );
    return new Padding(
        padding: const EdgeInsets.only(bottom: 1.0),
        child: new Center(child: tabBar));
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

  void _configureThemes() {
    targetPlatform = TargetPlatform.iOS;
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
    luxuryThemeData = new ThemeData(
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
      platform: targetPlatform,
    );
    playfulThemeData = new ThemeData(
      primaryColor: const Color(0xFFF0465A),
      buttonColor: const Color(0xFF1DBC98),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: new Typography(platform: targetPlatform).white,
      brightness: Brightness.light,
      platform: targetPlatform,
    );
    darkTheme = new ThemeData(
      primaryColor: const Color(0xFF212121),
      buttonColor: const Color(0xFF4A4A4A),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: new Typography(platform: targetPlatform).white,
      brightness: Brightness.dark,
      platform: targetPlatform,
    );
  }

  void _configureUI() {
    _tabController = new TabController(
      vsync: this,
      length: _tabs.length,
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

  void _registerObservables() {
    _tabController.addListener(() {
      setState(() {});
    });
  }
}
