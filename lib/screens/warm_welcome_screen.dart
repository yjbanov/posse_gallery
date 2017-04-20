// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:posse_gallery/config/constants.dart';
import 'package:posse_gallery/managers/welcome_manager.dart';
import 'package:posse_gallery/models/welcome_step.dart';
import 'package:posse_gallery/screens/main_screen.dart';

class WarmWelcomeScreen extends StatefulWidget {
  @override
  _WarmWelcomeScreenState createState() => new _WarmWelcomeScreenState();
}

class _WarmWelcomeScreenState extends State<WarmWelcomeScreen>
    with TickerProviderStateMixin {
  String _title, _subtitle, _nextTitle, _nextSubtitle;

  Animation<double> _fadeOutAnimation;
  Animation<double> _fadeInAnimation;
  Animation<double> _scaleOutAnimation;
  Animation<double> _scaleInAnimation;

  AnimationController _animateOutController;
  AnimationController _animateInController;

  List<WelcomeStep> _steps;
  int _currentStep = 0;
  double _bgOffset = 0.0;

  bool movingNext = true;

  static const double _kSwipeThreshold = 150.0;
  static const int _kAnimateOutDuration = 600;
  static const int _kAnimateInDuration = 800;
  static const int _kParallaxAnimationDuration = 1050;
  double _swipeAmount = 0.0;

  _WarmWelcomeScreenState() {
    _steps = new WelcomeManager().steps();
    if (_steps[_currentStep] != null) {
      _title = _steps[_currentStep].title;
      _subtitle = _steps[_currentStep].subtitle;
    }
    if (_steps[_currentStep + 1] != null) {
      _nextTitle = _steps[_currentStep + 1].title;
      _nextSubtitle = _steps[_currentStep + 1].subtitle;
    }
    _configureAnimation();
  }

  void _configureAnimation() {
    _animateOutController = new AnimationController(
      duration: const Duration(milliseconds: _kAnimateOutDuration),
      vsync: this,
    );
    _animateInController = new AnimationController(
      duration: const Duration(milliseconds: _kAnimateInDuration),
      vsync: this,
    );
    _fadeOutAnimation =
        _initOutAnimation(from: 1.0, to: 0.0, curve: Curves.linear);
    _fadeInAnimation =
        _initInAnimation(from: 0.0, to: 1.0, curve: Curves.easeOut);
    _scaleOutAnimation =
        _initOutAnimation(from: 1.0, to: 0.0, curve: Curves.linear);
    _scaleInAnimation =
        _initInAnimation(from: 0.0, to: 1.0, curve: Curves.easeOut);
  }

  Animation<double> _initOutAnimation(
      {@required double from, @required double to, @required Curve curve}) {
    final CurvedAnimation animation = new CurvedAnimation(
      parent: _animateOutController,
      curve: curve,
    );
    return new Tween<double>(begin: from, end: to).animate(animation);
  }

  Animation<double> _initInAnimation(
      {@required double from, @required double to, @required Curve curve}) {
    final CurvedAnimation animation = new CurvedAnimation(
      parent: _animateInController,
      curve: curve,
    );
    return new Tween<double>(begin: from, end: to).animate(animation);
  }

  Widget _buildBackgroundView() {
    int parallaxAnimationDuration = _kParallaxAnimationDuration;
    return new Stack(
      children: [
        new DecoratedBox(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                const Color(0xFFD7D7D7),
                const Color(0xFFFAFAFA),
                const Color(0xFFFFFFFF),
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              stops: [0.0, 0.35, 1.0],
            ),
          ),
        ),
        new AnimatedPositioned(
          top: 0.0,
          bottom: 0.0,
          left: _bgOffset,
          duration: new Duration(milliseconds: _kParallaxAnimationDuration),
          curve: Curves.easeOut,
          child: new Image(
            height: MediaQuery.of(context).size.height,
            image: new AssetImage("assets/images/bg_flutter_welcome.png"),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleSection(
      {@required String title, @required String subtitle}) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        new Text(
          title,
          style: new TextStyle(
            fontSize: 22.0,
            color: const Color(Constants.ColorPrimary),
            letterSpacing: 0.25,
          ),
          textAlign: TextAlign.center,
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: new Text(
            subtitle,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 13.0,
              color: const Color(0xFF222222),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSection() {
    return new Align(
      alignment: FractionalOffset.bottomCenter,
      child: new Container(
        width: 180.0,
        height: 46.0,
        margin: const EdgeInsets.only(bottom: 40.0),
        child: new RaisedButton(
          color: const Color(Constants.ColorPrimary),
          child: new Text(
            "START EXPLORING",
            style: new TextStyle(
              color: const Color(0xFFFFFFFF),
              fontSize: 12.0,
            ),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              new PageRouteBuilder<Null>(
                settings: const RouteSettings(name: "/main"),
                pageBuilder: (BuildContext context, Animation<double> _,
                    Animation<double> __) {
                  return new MainScreen();
                },
                transitionsBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child,
                ) {
                  return new ScaleTransition(scale: animation, child: child);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAnimatedContentView({int nextStep, bool movingNext}) {
    String nextTitle = _title;
    String nextSubtitle = _subtitle;
    if (movingNext && _steps[nextStep] != null) {
      nextTitle = _nextTitle;
      nextSubtitle = _nextSubtitle;
    }
    double imageSize = MediaQuery.of(context).size.width * 0.85;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      imageSize = MediaQuery.of(context).size.height * 0.25;
    }
    int previousStep = nextStep;
    if (nextStep != 0) {
      previousStep = movingNext ? nextStep - 1 : nextStep + 1;
    } else if (!movingNext) {
      previousStep += 1;
    }
    return new Positioned(
      left: 30.0,
      right: 30.0,
      top: 55.0,
      bottom: 0.0,
      child: new Stack(
        children: [
          new FadeTransition(
            opacity: _fadeOutAnimation,
            child: new Column(
              children: [
                _buildTitleSection(title: _title, subtitle: _subtitle),
                new Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: new Center(
                    child: new ScaleTransition(
                      scale: _scaleOutAnimation,
                      child: new Image(
                        width: imageSize,
                        height: imageSize,
                        image: new AssetImage(_steps[previousStep].imageUri),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new FadeTransition(
            opacity: _fadeInAnimation,
            child: new Column(
              children: [
                _buildTitleSection(title: nextTitle, subtitle: nextSubtitle),
                new Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: new Center(
                    child: new ScaleTransition(
                      scale: _scaleInAnimation,
                      child: new Image(
                        width: imageSize,
                        height: imageSize,
                        image: new AssetImage(_steps[nextStep].imageUri),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGestureDetector() {
    int nextStep = _currentStep;
    return new GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (_swipeAmount < _kSwipeThreshold) {
          movingNext = details.delta.dx <= 0;
          _swipeAmount += details.delta.distance.abs();
          bool didSwipe = (_swipeAmount >= _kSwipeThreshold);
          bool hasReachedBounds = true;
          if ((movingNext && _currentStep + 1 < _steps.length) ||
              (!movingNext && _currentStep - 1 >= 0)) {
            hasReachedBounds = false;
          }
          if (didSwipe && !hasReachedBounds) {
            _animateOutController.value = 0.0;
            _animateInController.value = 0.0;
            nextStep += movingNext ? 1 : -1;
            setState(() {
              if (nextStep >= 0 && nextStep < _steps.length) {
                _nextTitle = _steps[nextStep].title;
                _nextSubtitle = _steps[nextStep].subtitle;
              }
              if (movingNext && _currentStep + 1 < _steps.length) {
                _currentStep += 1;
                _bgOffset -= MediaQuery.of(context).size.width / 5;
              } else if (!movingNext && _currentStep - 1 >= 0) {
                _currentStep -= 1;
                _bgOffset += MediaQuery.of(context).size.width / 5;
              }
              if (_currentStep >= 0 && _currentStep < _steps.length) {
                _title = _steps[_currentStep].title;
                _subtitle = _steps[_currentStep].subtitle;
              }
            });
            _animateOutController.forward().whenComplete(() {});
            _animateInController.forward().whenComplete(() {});
          }
        }
      },
      onHorizontalDragEnd: (details) {
        _swipeAmount = 0.0;
      },
      child: new Stack(
        children: [
          new Positioned.fill(
            child: _buildBackgroundView(),
          ),
          _buildAnimatedContentView(nextStep: nextStep, movingNext: movingNext),
          _buildBottomSection(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: const Color(0xFFFFFFFF),
      child: _buildGestureDetector(),
    );
  }
}
