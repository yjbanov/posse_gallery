// ignore: invalid_constant
// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:posse_gallery/screens/items/assets_demo.dart';

class AssetsDetailDemo extends AssetsDemo {
  final int _themeIndex;

  AssetsDetailDemo({
    int themeIndex,
  })
      : _themeIndex = themeIndex;

  @override
  _AssetsDetailDemoState createState() =>
      new _AssetsDetailDemoState(themeIndex: _themeIndex);
}

class _AssetsDetailDemoState extends AssetsDemoState {
  static const int _kSlideInDuration = 500;
  static const int _kFadeInDuration = 500;
  static const int _kSizeInDuration = 500;

  int _themeIndex = 0;

  Animation<FractionalOffset> _slideInLeftAnimation;
  Animation<FractionalOffset> _slideInRightAnimation;
  Animation<FractionalOffset> _slideInDownAnimation;
  Animation<FractionalOffset> _slideInUpAnimation;
  Animation<double> _fadeInAnimation;
  Animation<double> _sizeInAnimation;

  AnimationController _slideInAnimationController;
  AnimationController _fadeInAnimationController;
  AnimationController _sizeInAnimationController;

  _AssetsDetailDemoState({
    int themeIndex,
  })
      : _themeIndex = themeIndex;

  @override
  Widget buildBody() {
    _startAnimation();
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
                    new SlideTransition(
                      position: _slideInRightAnimation,
                      child: new Padding(
                        padding: const EdgeInsets.only(top: 14.0, right: 10.0),
                        child: new Image(
                          image: new AssetImage("assets/images/brand_egg.png"),
                        ),
                      ),
                    ),
                    new SlideTransition(
                      position: _slideInDownAnimation,
                      child: new Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: new Image(
                          image:
                              new AssetImage("assets/images/brand_flour.png"),
                        ),
                      ),
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new SlideTransition(
                      position: _slideInUpAnimation,
                      child: new Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: new Image(
                          image: new AssetImage(
                              "assets/images/brand_cinnamon.png"),
                        ),
                      ),
                    ),
                    new SlideTransition(
                      position: _slideInLeftAnimation,
                      child: new Image(
                        image: new AssetImage("assets/images/brand_salt.png"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          new FadeTransition(
            opacity: _fadeInAnimation,
            child: new Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: new Text(
                "INGREDIENTS",
                style: new TextStyle(
                  color: selectedTheme.textTheme.title.color,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
          new FadeTransition(
            opacity: _sizeInAnimation,
            child: new SizeTransition(
              sizeFactor: _sizeInAnimation,
              child: new Center(
                child: new Text(
                  "2 Cups all-purpose flour\n"
                      "3/4 teaspoon salt\n"
                      "1 cup vegetable shortening\n"
                      "1 egg\n"
                      "2 tablespoons of cold water\n"
                      "1 tablespoon of cinnamon",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: selectedTheme.textTheme.body1.color,
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      height: 1.6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  dispose() {
    _slideInAnimationController.dispose();
    _fadeInAnimationController.dispose();
    _sizeInAnimationController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _configureAnimation();
    setState(() {
      tabController.index = _themeIndex;
      appBarTitle = "Classic Apple Pie";
      bottomButtonTitle = "Step 1: Make Crust";
    });
  }

  @override
  pressedNextButton() {}

  _configureAnimation() {
    _slideInAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kSlideInDuration),
      vsync: this,
    );
    _fadeInAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kFadeInDuration),
      vsync: this,
    );
    _sizeInAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kSizeInDuration),
      vsync: this,
    );
    _slideInLeftAnimation = _initSlideAnimation(
        from: const FractionalOffset(1.5, 0.0),
        to: const FractionalOffset(0.0, 0.0),
        curve: Curves.easeInOut,
        controller: _slideInAnimationController);
    _slideInRightAnimation = _initSlideAnimation(
        from: const FractionalOffset(-1.5, 0.0),
        to: const FractionalOffset(0.0, 0.0),
        curve: Curves.easeInOut,
        controller: _slideInAnimationController);
    _slideInUpAnimation = _initSlideAnimation(
        from: const FractionalOffset(0.0, 1.0),
        to: const FractionalOffset(0.0, 0.0),
        curve: Curves.decelerate,
        controller: _slideInAnimationController);
    _slideInDownAnimation = _initSlideAnimation(
        from: const FractionalOffset(0.0, -1.0),
        to: const FractionalOffset(0.0, 0.0),
        curve: Curves.decelerate,
        controller: _slideInAnimationController);
    _fadeInAnimation = _initAnimation(
        from: 0.0,
        to: 1.0,
        curve: Curves.linear,
        controller: _fadeInAnimationController);
    _sizeInAnimation = _initAnimation(
        from: 0.0,
        to: 1.0,
        curve: Curves.linear,
        controller: _sizeInAnimationController);
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

  _startAnimation() {
    _slideInAnimationController.forward();
    _fadeInAnimationController.forward();
    _sizeInAnimationController.forward();
  }
}
