// ignore: invalid_constant
// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class PlatformDetailDemo extends StatefulWidget {
  final TargetPlatform _targetPlatform;

  PlatformDetailDemo({
    TargetPlatform targetPlatform,
  })
      : _targetPlatform = targetPlatform;

  @override
  _PlatformDetailDemoState createState() =>
      new _PlatformDetailDemoState(targetPlatform: _targetPlatform);
}

class _PlatformDetailDemoState extends State<PlatformDetailDemo>
    with TickerProviderStateMixin {
  static const int _kAnimationInDuration = 600;
  static const int _kHeartAnimationDuration = 300;
  TargetPlatform _targetPlatform;

  ThemeData _themeData;

  Animation<double> _scaleInAnimation;
  Animation<FractionalOffset> _slideInAnimation;
  Animation<double> _heartAnimation;

  AnimationController _animationController;
  AnimationController _heartAnimationController;

  Color _heartColor = Colors.white;

  int _heartCount = 1324;

  _PlatformDetailDemoState({
    TargetPlatform targetPlatform,
  })
      : _targetPlatform = targetPlatform;

  @override
  Widget build(BuildContext context) {
    _configureThemes();
    return new Theme(
      data: _themeData,
      child: new Material(
        color: Colors.white,
        child: _contentWidget(),
      ),
    );
  }

  @override
  dispose() {
    _animationController.dispose();
    _heartAnimationController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _configureAnimation();
    _animationController.forward();
  }

  Widget _buildBottomButton() {
    double buttonBorderRadius =
        _targetPlatform == TargetPlatform.iOS ? 2.0 : 0.0;
    double margin = _targetPlatform == TargetPlatform.iOS ? 8.0 : 0.0;
    Color borderColor = const Color(0xFF3D3D3D);
    Color textColor = _targetPlatform == TargetPlatform.iOS
        ? const Color(0xFF3D3D3D)
        : Colors.white;
    Text addToCartText = new Text(
      "ADD TO CART",
      style: new TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );
    CupertinoButton cupertinoButton = new CupertinoButton(
      child: addToCartText,
      onPressed: (() {}),
    );
    FlatButton androidButton = new FlatButton(
      color: _themeData.buttonColor,
      child: addToCartText,
      onPressed: () {},
    );
    Widget platformButton =
        _targetPlatform == TargetPlatform.iOS ? cupertinoButton : androidButton;
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(buttonBorderRadius),
        color: borderColor,
      ),
      margin: new EdgeInsets.all(margin),
      child: new Row(
        children: [
          new Expanded(
            child: new Container(
              height: 50.0,
              child: platformButton,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroContent() {
    NumberFormat heart = new NumberFormat("#,###", "en_US");
    return new Container(
      child: new Stack(
        children: [
          new Positioned.fill(
            child: new Container(
              color: const Color(0x40333333),
            ),
          ),
          new Center(
            child: new ScaleTransition(
              scale: _scaleInAnimation,
              child: new Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Text(
                    "THE GEO COLLECTION",
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: new Text(
                      "GEOMETRIC DINING CHAIR",
                      style: new TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Positioned(
            left: 30.0,
            bottom: 30.0,
            child: new ScaleTransition(
              scale: _scaleInAnimation,
              child: new Row(
                children: [
                  new ScaleTransition(
                    scale: _heartAnimation,
                    child: new IconButton(
                      icon: new Icon(Icons.favorite, color: _heartColor),
                      color: _heartColor,
                      onPressed: (() {
                        setState(() {
                          _heartColor = _heartColor == Colors.red
                              ? Colors.white
                              : Colors.red;
                          _heartCount += _heartColor == Colors.red ? 1 : -1;
                          _heartAnimationController.forward().whenComplete(() {
                            _heartAnimationController.reverse();
                          });
                        });
                      }),
                    ),
                  ),
                  new Text(
                    heart.format(_heartCount).toString(),
                    style: new TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Positioned(
            right: 30.0,
            bottom: 35.0,
            child: new ScaleTransition(
              scale: _scaleInAnimation,
              child: new Container(
                decoration: new BoxDecoration(
                  border: new Border(
                    left: new BorderSide(
                      color: const Color(0xFFF5A623),
                      width: 1.0,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                color: const Color(0xFFF5A623),
                child: new Text(
                  "\$321",
                  style: new TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildListContent() {
    List<Widget> cells = [];
    final textContainer = new Padding(
      padding: const EdgeInsets.only(top: 25.0, left: 45.0, right: 45.0),
      child: new SlideTransition(
        position: _slideInAnimation,
        child: new Column(
          children: [
            new Align(
              alignment: FractionalOffset.centerLeft,
              child: new Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: new Text(
                  "About The Geometric\nDining Chair",
                  textAlign: TextAlign.left,
                  style: new TextStyle(
                    color: const Color(0xFF4A4A4A),
                    fontWeight: FontWeight.w900,
                    fontSize: 16.0,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            new Text(
              "A chair is a piece of furniture with a raised surface supported by legs, commonly used to seat a single person. Chairs are supported most often by four legs and have a back; however, a chair can have three legs or can have a different shape.",
              style: new TextStyle(
                color: const Color(0xFF4A4A4A),
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
    cells.add(textContainer);
    return cells;
  }

  _configureAnimation() {
    _animationController = new AnimationController(
      duration: const Duration(milliseconds: _kAnimationInDuration),
      vsync: this,
    );
    _heartAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kHeartAnimationDuration),
      vsync: this,
    );
    _scaleInAnimation = _initAnimation(
        from: 0.0,
        to: 1.0,
        curve: Curves.easeOut,
        controller: _animationController);
    _slideInAnimation = _initSlideAnimation(
        from: const FractionalOffset(0.0, 2.0),
        to: const FractionalOffset(0.0, 0.0),
        curve: Curves.easeOut,
        controller: _animationController);
    _heartAnimation = _initAnimation(
        from: 1.0,
        to: 1.5,
        curve: Curves.easeOut,
        controller: _heartAnimationController);
  }

  _configureThemes() {
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
      body: new CustomScrollView(
        slivers: [
          new SliverAppBar(
            pinned: true,
            leading: new Material(
              color: const Color(0x00FFFFFF),
              child: new ScaleTransition(
                scale: _scaleInAnimation,
                child: new CloseButton(),
              ),
            ),
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            flexibleSpace: new FlexibleSpaceBar(
              background: new Hero(
                tag: "platform.hero",
                child: new Material(
                  child: new Stack(
                    children: [
                      new Positioned.fill(
                        child: new OverflowBox(
                          maxWidth: MediaQuery.of(context).size.width,
                          child: new Image(
                            fit: BoxFit.cover,
                            image: new AssetImage(
                                "assets/images/platform_hero.png"),
                          ),
                        ),
                      ),
                      _buildHeroContent(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          new SliverList(
            delegate: new SliverChildListDelegate(_buildListContent()),
          ),
        ],
      ),
      bottomNavigationBar: new Material(
        elevation: 10.0,
        child: _buildBottomButton(),
      ),
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
}
