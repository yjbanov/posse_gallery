// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:posse_gallery/screens/demos/customized_design_detail.dart';

class CustomizedDesign extends StatefulWidget {
  @override
  _CustomizedDesignState createState() => new _CustomizedDesignState();
}

class _CustomizedDesignState extends State<CustomizedDesign>
    with TickerProviderStateMixin {
  static const int _kAnimateHeroFadeDuration = 600;
  static const int _kAnimateTextDuration = 500;
  static const double _kDetailTabHeight = 70.0;

  TargetPlatform _targetPlatform;
  TextAlign _platformTextAlignment;
  ThemeData _themeData;
  Animation<double> _heroFadeInAnimation;
  Animation<double> textFadeInAnimation;
  AnimationController _heroAnimationController;

  AnimationController _textAnimationController;

  double _verticalOffset;

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
    _heroAnimationController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _verticalOffset = _kDetailTabHeight;
    _configureAnimation();
    _heroAnimationController.forward().whenComplete(() {
      _textAnimationController.forward();
    });
  }

  Widget _buildBackButton() {
    TargetPlatform platform = Theme.of(context).platform;
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
    return new Stack(
      children: [
        new FadeTransition(
          opacity: _heroFadeInAnimation,
          child: new Image(
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fitHeight,
            image: new AssetImage(
              "assets/images/custom_hero.png",
            ),
          ),
        ),
        new Positioned.fill(
          child: new Center(
            child: new FadeTransition(
              opacity: textFadeInAnimation,
              child: _buildTextBody(),
            ),
          ),
        ),
        new Positioned(
          left: -7.0,
          top: 13.0,
          child: _buildBackButton(),
        ),
        _buildBottomBar(),
      ],
    );
  }

  _buildBottomBar() {
    double screenHeight = MediaQuery.of(context).size.height;
    return new Positioned(
      left: 0.0,
      top: screenHeight - _verticalOffset,
      right: 0.0,
      child: new GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            if (details.primaryDelta > -20 &&
                details.primaryDelta < 20 &&
                _verticalOffset >= _kDetailTabHeight &&
                _verticalOffset <= screenHeight) {
              _verticalOffset -= details.primaryDelta;
            } else if (details.primaryDelta < -30 &&
                _verticalOffset <= screenHeight) {
              _verticalOffset = screenHeight;
            } else if (details.primaryDelta > 30 &&
                _verticalOffset >= _kDetailTabHeight) {
              _verticalOffset = _kDetailTabHeight;
            }
            if (_verticalOffset < _kDetailTabHeight) {
              _verticalOffset = _kDetailTabHeight;
            } else if (_verticalOffset > screenHeight) {
              _verticalOffset = screenHeight;
            }
          });
        },
        child: new Container(
          height: MediaQuery.of(context).size.height,
          child: new CustomizedDesignDetail(),
        ),
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
    _heroFadeInAnimation = _initAnimation(
      from: 0.0,
      to: 1.0,
      curve: Curves.easeOut,
      controller: _heroAnimationController,
    );
    textFadeInAnimation = _initAnimation(
      from: 0.0,
      to: 1.0,
      curve: Curves.easeIn,
      controller: _textAnimationController,
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
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildBody(),
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
}
