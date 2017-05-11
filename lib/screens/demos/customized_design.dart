// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class CustomizedDesign extends StatefulWidget {
  @override
  _CustomizedDesignState createState() => new _CustomizedDesignState();
}

class _CustomizedDesignState extends State<CustomizedDesign>
    with TickerProviderStateMixin {
  static const int _kAnimateHeroFadeDuration = 1000;
  static const int _kAnimateTextDuration = 400;
  static const double _kDetailTabHeight = 70.0;
  static const int _kStatsAnimationDuration = 100;
  static const int _kRotationAnimationDuration = 200;

  List<Widget> _stats;
  TargetPlatform _targetPlatform;
  TextAlign _platformTextAlignment;
  ThemeData _themeData;
  double _statsOpacity = 1.0;
  double _mileCounter = 643.6;
  int _elevationCounter = 8365;
  int _runCounter = 158;
  bool _hasAnimatedCounters = false;

  Animation<double> _heroFadeInAnimation;
  Animation<double> _textFadeInAnimation;
  Animation<double> _statsAnimationOne;
  Animation<double> _statsAnimationTwo;
  Animation<double> _statsAnimationThree;
  Animation<double> _statsAnimationFour;
  Animation<double> _rotationAnimation;

  AnimationController _heroAnimationController;
  AnimationController _textAnimationController;
  AnimationController _statsAnimationControllerOne;
  AnimationController _statsAnimationControllerTwo;
  AnimationController _statsAnimationControllerThree;
  AnimationController _statsAnimationControllerFour;
  AnimationController _rotationAnimationController;

  @override
  Widget build(BuildContext context) {
    _configureThemes();
    _stats = [_buildStatsContentWidget()];
    return new Theme(
      data: _themeData,
      child: new Material(
        color: const Color(0x00FFFFFF),
        child: _contentWidget(),
      ),
    );
  }

  @override
  dispose() {
    _heroAnimationController.dispose();
    _textAnimationController.dispose();
    _statsAnimationControllerOne.dispose();
    _statsAnimationControllerTwo.dispose();
    _statsAnimationControllerThree.dispose();
    _statsAnimationControllerFour.dispose();
    _rotationAnimationController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _configureAnimation();
    _heroAnimationController.forward().whenComplete(() {
      _textAnimationController.forward();
    });
  }

  _animateCounters() {
    if (!_hasAnimatedCounters) {
      _animateRunCounter();
      _animateElevationCounter();
      _animateMileCounter();
      _hasAnimatedCounters = true;
    }
  }

  _animateElevationCounter() {
    Duration duration = new Duration(milliseconds: 500);
    return new Timer(duration, _updateElevationCounter);
  }

  _animateMileCounter() {
    Duration duration = new Duration(milliseconds: 700);
    return new Timer(duration, _updateMileCounter);
  }

  _animateRunCounter() {
    Duration duration = new Duration(milliseconds: 300);
    return new Timer(duration, _updateRunCounter);
  }

  _buildAppBar() {
    return new Container(
      color: const Color(0xFF212024),
      height: 70.0,
      child: new Stack(
        children: [
          new Positioned(
            left: 26.0,
            top: 0.0,
            bottom: 0.0,
            child: new Center(
              child: new Text(
                "VIEW MY STATS",
                style: new TextStyle(
                  color: const Color(0xFF02CEA1),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          new Positioned(
            right: 10.0,
            top: 0.0,
            bottom: 0.0,
            child: new RotationTransition(
              turns: _rotationAnimation,
              child: new IconButton(
                color: Colors.white,
                icon: new RotatedBox(
                  quarterTurns: 2,
                  child: new ImageIcon(
                    new AssetImage("assets/icons/ic_custom_circle_arrow.png"),
                  ),
                ),
                onPressed: (() {}),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    TargetPlatform platform = Theme
        .of(context)
        .platform;
    final IconData backIcon = platform == TargetPlatform.android
        ? Icons.arrow_back
        : Icons.arrow_back_ios;
    return new Container(
      height: 70.0,
      width: 70.0,
      child: new Material(
        color: const Color(0x00FFFFFF),
        child: new IconButton(
          icon: new Icon(backIcon, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return new Opacity(
      opacity: _statsOpacity,
      child: new Stack(
        children: [
          new FadeTransition(
            opacity: _heroFadeInAnimation,
            child: new OverflowBox(
              alignment: FractionalOffset.topLeft,
              maxHeight: 1000.0,
              child: new Image(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                fit: BoxFit.fill,
                image: new AssetImage(
                  "assets/images/custom_hero.png",
                ),
              ),
            ),
          ),
          new Positioned.fill(
            child: new Center(
              child: new FadeTransition(
                opacity: _textFadeInAnimation,
                child: _buildTextBody(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildPathContent() {
    return new Container(
      color: const Color(0xFF333333),
      child: new Stack(
        children: [
          new Positioned.fill(
            child: new Image(
              image: new AssetImage("assets/images/custom_runner_bg.png"),
              fit: BoxFit.cover,
              alignment: FractionalOffset.topCenter,
            ),
          ),
          new Positioned(
            right: 18.0,
            top: 30.0,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new ScaleTransition(
                  scale: _statsAnimationThree,
                  child: new Text(
                    "3.5mi",
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                      color: const Color(0xFFF6FB09),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                new ScaleTransition(
                  scale: _statsAnimationThree,
                  child: new Text(
                    "974 calories",
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Positioned(
            left: 5.0,
            right: 5.0,
            top: 15.0,
            child: new FadeTransition(
              opacity: _statsAnimationTwo,
              child: new Image(
                image: new AssetImage("assets/images/custom_path.png"),
              ),
            ),
          ),
          new Positioned(
            left: 14.0,
            bottom: 55.0,
            child: new ScaleTransition(
              scale: _statsAnimationOne,
              child: new Text(
                "4/9/17 Run",
                style: new TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
//          new Positioned(
//            right: 10.0,
//            bottom: 60.0,
//            child: new ScaleTransition(
//              scale: _statsAnimationFour,
//              child: new Icon(Icons.event, color: const Color(0xFF02CEA1)),
//            ),
//          ),
          new Positioned(
            left: 0.0,
            bottom: 20.0,
            right: 0.0,
            child: new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: _buildPathStatsRow(),
            ),
          ),
        ],
      ),
    );
  }

  _buildPathStatsRow() {
    TextStyle statsTextStyle = new TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
      color: Colors.white,
    );
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new ScaleTransition(
            scale: _statsAnimationOne,
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                new Icon(Icons.timer, color: Colors.white),
                new Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: new Text(
                    "00:26:13",
                    style: statsTextStyle,
                  ),
                ),
              ],
            ),
          ),
          new ScaleTransition(
            scale: _statsAnimationTwo,
            child: new Row(
              children: [
                new Icon(Icons.access_time, color: Colors.white),
                new Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: new Text(
                    "7'13\"",
                    style: statsTextStyle,
                  ),
                )
              ],
            ),
          ),
          new ScaleTransition(
            scale: _statsAnimationThree,
            child: new Row(
              children: [
                new Icon(Icons.landscape, color: Colors.white),
                new Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: new Text(
                    "120ft",
                    style: statsTextStyle,
                  ),
                ),
              ],
            ),
          ),
          new ScaleTransition(
            scale: _statsAnimationFour,
            child: new Row(
              children: [
                new Icon(Icons.favorite, color: Colors.white),
                new Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: new Text(
                    "97bpm",
                    style: statsTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildStatsBox() {
    final TextStyle figureStyle = new TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    final TextStyle titleStyle = new TextStyle(
      fontSize: 9.0,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
    NumberFormat elevation = new NumberFormat("#,###.#", "en_US");
    return new Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.4,
      color: const Color(0xFFF6FB09),
      child: new Stack(
        children: [
          new Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                new Column(
                  children: [
                    new Text(
                      _runCounter.toString(),
                      style: figureStyle,
                    ),
                    new Text(
                      "TOTAL RUNS",
                      style: titleStyle,
                    ),
                  ],
                ),
                new Column(
                  children: [
                    new Text(
                      "6'45\"",
                      style: figureStyle,
                    ),
                    new Text(
                      "AVG PACE",
                      style: titleStyle,
                    ),
                  ],
                ),
                new Column(
                  children: [
                    new Text(
                      elevation.format(_elevationCounter).toString(),
                      style: figureStyle,
                    ),
                    new Text(
                      "TOTAL ELEVATION",
                      style: titleStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          new Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 24.0,
            child: new Column(
              children: [
                new Text(
                  _mileCounter.toString(),
                  style: new TextStyle(
                    fontSize: 82.0,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                ),
                new Text(
                  "TOTAL MILES",
                  style: new TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsContentWidget() {
    return new Container(
      color: const Color(0xFF212024),
      height: MediaQuery
          .of(context)
          .size
          .height -
          MediaQuery
              .of(context)
              .padding
              .top,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: new Stack(
        children: [
          _buildAppBar(),
          new Positioned(
            left: 0.0,
            right: 0.0,
            top: 70.0,
            bottom: MediaQuery
                .of(context)
                .size
                .height * 0.4,
            child: _buildPathContent(),
          ),
          new Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: _buildStatsBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextBody() {
    final firstText = new Text(
      "EASILY TRACK YOUR ACTIVITY",
      textAlign: _platformTextAlignment,
      style: new TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 40.0,
        fontWeight: FontWeight.w900,
        color: Colors.white,
      ),
    );
    final secondText = new Text(
      "ACTIVITY",
      style: new TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 40.0,
        fontWeight: FontWeight.w900,
        color: const Color(0xFFF6F309),
      ),
    );
    final combinedText = firstText;
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        new Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: combinedText,
        ),
        new Padding(
          padding: _targetPlatform == TargetPlatform.android
              ? const EdgeInsets.only(left: 20.0)
              : const EdgeInsets.only(left: 0.0, right: 0.0),
          child: new Align(
            alignment: _targetPlatform == TargetPlatform.android
                ? FractionalOffset.centerLeft
                : FractionalOffset.center,
            child: new Container(
              height: 3.0,
              width: 66.0,
              color: Colors.white,
            ),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 50.0),
          child: new Text(
            "Keep your phone with you while running, cycling, or walking to get stats on your activity.",
            textAlign: _platformTextAlignment,
            style: new TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  _configureAnimation() {
    _heroAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kAnimateHeroFadeDuration),
      vsync: this,
    );
    _textAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kAnimateTextDuration),
      vsync: this,
    );
    _statsAnimationControllerOne = new AnimationController(
      duration: const Duration(milliseconds: _kStatsAnimationDuration),
      vsync: this,
    );
    _statsAnimationControllerTwo = new AnimationController(
      duration: const Duration(milliseconds: _kStatsAnimationDuration),
      vsync: this,
    );
    _statsAnimationControllerThree = new AnimationController(
      duration: const Duration(milliseconds: _kStatsAnimationDuration),
      vsync: this,
    );
    _statsAnimationControllerFour = new AnimationController(
      duration: const Duration(milliseconds: _kStatsAnimationDuration),
      vsync: this,
    );
    _rotationAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kRotationAnimationDuration),
      vsync: this,
    );
    _heroFadeInAnimation = _initAnimation(
      from: 0.0,
      to: 1.0,
      curve: Curves.easeOut,
      controller: _heroAnimationController,
    );
    _textFadeInAnimation = _initAnimation(
      from: 0.0,
      to: 1.0,
      curve: Curves.easeIn,
      controller: _textAnimationController,
    );
    _statsAnimationOne = _initAnimation(
        from: 0.0,
        to: 1.0,
        curve: Curves.easeOut,
        controller: _statsAnimationControllerOne);
    _statsAnimationTwo = _initAnimation(
        from: 0.0,
        to: 1.0,
        curve: Curves.easeOut,
        controller: _statsAnimationControllerTwo);
    _statsAnimationThree = _initAnimation(
        from: 0.0,
        to: 1.0,
        curve: Curves.easeOut,
        controller: _statsAnimationControllerThree);
    _statsAnimationFour = _initAnimation(
        from: 0.0,
        to: 1.0,
        curve: Curves.easeOut,
        controller: _statsAnimationControllerFour);
    _rotationAnimation = _initAnimation(
        from: 0.0,
        to: 0.5,
        curve: Curves.easeOut,
        controller: _rotationAnimationController);
  }

  _configureThemes() {
    _targetPlatform = Theme
        .of(context)
        .platform;
    _platformTextAlignment = _targetPlatform == TargetPlatform.android
        ? TextAlign.left
        : TextAlign.center;
    _themeData = new ThemeData(
      primaryColor: const Color(0xFF212024),
      buttonColor: const Color(0xFF3D3D3D),
      iconTheme: const IconThemeData(color: const Color(0xFF4A4A4A)),
      brightness: Brightness.light,
      platform: _targetPlatform,
    );
  }

  Widget _contentWidget() {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    TargetPlatform platform = Theme
        .of(context)
        .platform;
    String backTitle = platform == TargetPlatform.android ? "TrackFit" : "";
    return new Scaffold(
      backgroundColor: const Color(0xFF212024),
      body: new NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: new CustomScrollView(
          slivers: [
            new SliverAppBar(
              pinned: false,
              title: new Text(backTitle),
              expandedHeight: screenHeight -
                  _kDetailTabHeight -
                  MediaQuery
                      .of(context)
                      .padding
                      .top,
              leading: _buildBackButton(),
              backgroundColor: const Color(0xFF212024),
              flexibleSpace: new FlexibleSpaceBar(
                background: _buildBody(),
              ),
            ),
            new SliverList(
              delegate: new SliverChildListDelegate(_stats),
            ),
          ],
        ),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    double visibleStatsHeight = notification.metrics.pixels;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height -
        _kDetailTabHeight -
        MediaQuery
            .of(context)
            .padding
            .top;
    double opacity = visibleStatsHeight / screenHeight;
    double calculatedOpacity = 1.0 - opacity;
    if (calculatedOpacity > 1.0) {
      _statsOpacity = 1.0;
    } else if (calculatedOpacity < 0.0) {
      _statsOpacity = 0.0;
    } else {
      _statsOpacity = calculatedOpacity;
    }
    if (_statsOpacity == 0.0) {
      _statsAnimationControllerOne.forward().whenComplete(() {
        _statsAnimationControllerTwo.forward().whenComplete(() {
          _statsAnimationControllerThree.forward().whenComplete(() {
            _statsAnimationControllerFour.forward().whenComplete(() {
              _rotationAnimationController.forward();
              _animateCounters();
            });
          });
        });
      });
    } else if (_statsOpacity == 1.0) {
      _statsAnimationControllerOne.value = 0.0;
      _statsAnimationControllerTwo.value = 0.0;
      _statsAnimationControllerThree.value = 0.0;
      _statsAnimationControllerFour.value = 0.0;
      _rotationAnimationController.reverse();
    }
    setState(() {});
    return false;
  }

  Animation<double> _initAnimation({@required double from,
    @required double to,
    @required Curve curve,
    @required AnimationController controller}) {
    final CurvedAnimation animation = new CurvedAnimation(
      parent: controller,
      curve: curve,
    );
    return new Tween<double>(begin: from, end: to).animate(animation);
  }

  _updateElevationCounter() {
    setState(() {
      _elevationCounter += 356;
    });
  }

  _updateMileCounter() {
    setState(() {
      _mileCounter += 7.3;
    });
  }

  _updateRunCounter() {
    setState(() {
      _runCounter += 1;
    });
  }
}
