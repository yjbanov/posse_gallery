// ignore: invalid_constant
// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:posse_gallery/screens/items/platform_demo_detail.dart';

class PlatformDemo extends StatefulWidget {
  @override
  PlatformDemoState createState() => new PlatformDemoState();
}

class PlatformDemoState extends State<PlatformDemo>
    with TickerProviderStateMixin {
  static const int _kAnimationInDuration = 400;

  TargetPlatform _targetPlatform;
  TextAlign _platformTextAlignment;
  ThemeData _themeData;

  int _radioValue = 0;
  Animation<double> _fadeInAnimation;
  Animation<FractionalOffset> _leftPaneAnimation;
  Animation<FractionalOffset> _rightPaneAnimation;
  Animation<double> _scaleInAnimation;
  Animation<double> _pivotCounterClockwiseAnimation;
  Animation<double> _pivotClockwiseAnimation;

  AnimationController _animationController;
  AnimationController _leftPaneAnimationController;
  AnimationController _rightPaneAnimationController;

  @override
  Widget build(BuildContext context) {
    _configureThemes();
    return new Theme(
      data: _themeData,
      child: new Material(
        color: _themeData.primaryColor,
        child: _contentWidget(),
      ),
    );
  }

  @override
  dispose() {
    _animationController.dispose();
    _leftPaneAnimationController.dispose();
    _rightPaneAnimationController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _configureAnimation();
    _animationController.forward();
    _leftPaneAnimationController.forward();
    _rightPaneAnimationController.forward();
  }

  Widget _buildAppBar() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return new Container(
      height: 56.0,
      padding: new EdgeInsets.only(top: statusBarHeight),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new BackButton(),
          new Expanded(
            child: new Text(
              "Modern Furniture",
              style: new TextStyle(
                color: _themeData.textTheme.title.color,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
              textAlign: _platformTextAlignment,
            ),
          ),
          new IconButton(
            icon: new Icon(
              Icons.more_vert,
              color: _themeData.iconTheme.color,
            ),
            onPressed: () {
              showModalBottomSheet<Null>(
                context: context,
                builder: (BuildContext context) {
                  return _buildBottomSheet();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return new Expanded(
      child: new FadeTransition(
        opacity: _fadeInAnimation,
        child: new Container(
          child: new Column(
            children: [
              _buildHeroWidget(),
              _buildBottomPanes(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    double buttonBorderRadius =
        _targetPlatform == TargetPlatform.iOS ? 2.0 : 0.0;
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(buttonBorderRadius),
      ),
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
      child: new Row(
        children: [
          new Expanded(
            child: new FlatButton(
              color: _themeData.buttonColor,
              child: new Text(
                "ADD TO CART",
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

  List<BottomNavigationBarItem> _buildBottomNavBar() {
    List<BottomNavigationBarItem> buttons = [];
    final homeButton = new BottomNavigationBarItem(
      icon: new Icon(Icons.home, color: Colors.black),
      title: const Text(""),
    );
    final flashButton = new BottomNavigationBarItem(
      icon: new Icon(Icons.flash_on, color: Colors.black),
      title: const Text(""),
    );
    final cartButton = new BottomNavigationBarItem(
      icon: new Icon(Icons.shopping_cart, color: Colors.black),
      title: const Text(""),
    );
    final profileButton = new BottomNavigationBarItem(
      icon: new Icon(Icons.person, color: Colors.black),
      title: const Text(""),
    );
    buttons.add(homeButton);
    buttons.add(flashButton);
    buttons.add(cartButton);
    buttons.add(profileButton);
    return buttons;
  }

  Widget _buildBottomPanes() {
    return new Row(
      children: [
        new SlideTransition(
          position: _leftPaneAnimation,
          child: new Container(
            child: new Stack(
              children: [
                new Image(
                  width: MediaQuery.of(context).size.width * 0.5,
                  image: new AssetImage("assets/images/platform_lamp.png"),
                ),
                new Positioned(
                  left: 10.0,
                  bottom: 12.0,
                  child: new Text(
                    "THE\nWALL LAMP",
                    style: new TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        new SlideTransition(
          position: _rightPaneAnimation,
          child: new Container(
            child: new Stack(
              children: [
                new Image(
                  width: MediaQuery.of(context).size.width * 0.5,
                  image: new AssetImage("assets/images/platform_table.png"),
                ),
                new Positioned(
                  left: 10.0,
                  bottom: 12.0,
                  child: new Text(
                    "NATURAL\nSIDE TABLE",
                    style: new TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSheet() {
    return new Container(
      height: MediaQuery.of(context).size.height * 0.34,
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
                      left: 20.0, right: 20.0, bottom: 42.0),
                  child: new Column(
                    children: [
                      new Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: new Text(
                          "Toggle between an iOS and Android design screen to view the unified user experence.",
                          textAlign: _platformTextAlignment,
                          style: new TextStyle(
                            letterSpacing: 0.6,
                            fontSize: 16.0,
                            height: 1.4,
                          ),
                        ),
                      ),
                      new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          new Expanded(
                            child: new Column(
                              children: [
                                new Radio<int>(
                                    value: 0,
                                    groupValue: _radioValue,
                                    onChanged: _handleRadioValueChanged),
                                new Text(
                                  "iOS",
                                  style: new TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFAAAAAA),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          new Expanded(
                            child: new Column(
                              children: [
                                new Radio<int>(
                                    value: 1,
                                    groupValue: _radioValue,
                                    onChanged: _handleRadioValueChanged),
                                new Text(
                                  "ANDROID",
                                  style: new TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFAAAAAA),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroWidget() {
    FractionalOffset offset = new FractionalOffset(1.5, 0.0);
    Animation<FractionalOffset> animation = _initSlideAnimation(
      from: offset,
      to: const FractionalOffset(0.0, 0.0),
      curve: Curves.easeOut,
      controller: _animationController,
    );
    return new Expanded(
      child: new GestureDetector(
        onTap: (() {
          _tappedHero();
        }),
        child: new SlideTransition(
          position: animation,
          child: new Container(
            child: new Stack(
              alignment: FractionalOffset.bottomCenter,
              children: [
                new Hero(
                  tag: "platform.hero",
                  child: new Image(
                      image: new AssetImage("assets/images/platform_hero.png"),
                    ),
                ),
                new Center(
                  child: new Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Text(
                        "FEATURED",
                        style: new TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: new Text(
                          "GEOMETRIC DINING CHAIR",
                          style: new TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _configureAnimation() {
    _animationController = new AnimationController(
      duration: const Duration(milliseconds: _kAnimationInDuration),
      vsync: this,
    );
    _fadeInAnimation = _initAnimation(
        from: 0.0,
        to: 1.0,
        curve: Curves.easeOut,
        controller: _animationController);
    _leftPaneAnimationController = new AnimationController(
      duration: new Duration(milliseconds: _kAnimationInDuration + 100),
      vsync: this,
    );
    _rightPaneAnimationController = new AnimationController(
      duration: new Duration(milliseconds: _kAnimationInDuration + 100),
      vsync: this,
    );
    FractionalOffset offset = new FractionalOffset(1.5, 0.0);
    _leftPaneAnimation = _initSlideAnimation(
      from: offset,
      to: const FractionalOffset(0.0, 0.0),
      curve: Curves.easeOut,
      controller: _leftPaneAnimationController,
    );
    _rightPaneAnimation = _initSlideAnimation(
      from: offset,
      to: const FractionalOffset(0.0, 0.0),
      curve: Curves.easeOut,
      controller: _rightPaneAnimationController,
    );
  }

  _configureThemes() {
    _targetPlatform = Theme.of(context).platform;
    _platformTextAlignment = _targetPlatform == TargetPlatform.android
        ? TextAlign.left
        : TextAlign.center;
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle iOSButtonTextStyle = textTheme.button.copyWith(
        fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold);
    TextStyle androidButtonTextStyle = textTheme.button.copyWith(
        fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.normal);
    TextStyle targetPlatformButtonTextStyle =
        _targetPlatform == TargetPlatform.iOS
            ? iOSButtonTextStyle
            : androidButtonTextStyle;
    _themeData = new ThemeData(
      primaryColor: Colors.white,
      buttonColor: const Color(0xFF3D3D3D),
      iconTheme: const IconThemeData(color: const Color(0xFF4A4A4A)),
      brightness: Brightness.light,
      platform: _targetPlatform,
    );
  }

  Widget _contentWidget() {
    return new Scaffold(
//      bottomNavigationBar: new BottomNavigationBar(
//        items: _buildBottomNavBar(),
//      ),
      body: new Column(
        children: [
          _buildAppBar(),
          _buildBody(),
//        _buildBottomButton(),
        ],
      ),
    );
  }

  _handleRadioValueChanged(int value) {
    setState(() {
      _radioValue = value;
      _targetPlatform =
          _radioValue == 0 ? TargetPlatform.iOS : TargetPlatform.android;
    });
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

  _tappedHero() {
    Navigator.push(
      context,
      new PageRouteBuilder<Null>(
        settings: new RouteSettings(),
        pageBuilder:
            (BuildContext context, Animation<double> _, Animation<double> __) {
          return new PlatformDetailDemo(targetPlatform: _targetPlatform);
        },
      ),
    );
  }
}
