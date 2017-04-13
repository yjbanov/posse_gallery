// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:posse_gallery/config/constants.dart';
import 'package:posse_gallery/managers/welcome_manager.dart';
import 'package:posse_gallery/models/welcome_step.dart';

class WarmWelcomeScreen extends StatefulWidget {
  @override
  _WarmWelcomeScreenState createState() => new _WarmWelcomeScreenState();
}

class _WarmWelcomeScreenState extends State<WarmWelcomeScreen>
    with TickerProviderStateMixin {
  String _title, _subtitle, _nextTitle, _nextSubtitle;

  Animation<double> _firstFadeAnimation;
  Animation<double> _secondFadeAnimation;
  AnimationController _titleFadeAnimationController;

  List<WelcomeStep> _steps;
  int _currentStep = 0;

  static const double _kSwipeThreshold = 150.0;
  static const int _kAnimationDuration = 1000;
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
    _titleFadeAnimationController = new AnimationController(
      duration: new Duration(milliseconds: _kAnimationDuration),
      vsync: this,
    );
    _firstFadeAnimation =
        _initTitleAnimation(from: 1.0, to: 0.0, curve: Curves.easeOut);
    _secondFadeAnimation =
        _initTitleAnimation(from: 0.0, to: 1.0, curve: Curves.easeIn);
  }

  Animation<double> _initTitleAnimation(
      {@required double from, @required double to, @required Curve curve}) {
    final CurvedAnimation animation = new CurvedAnimation(
      parent: _titleFadeAnimationController,
      curve: curve,
    );
    return new Tween<double>(begin: from, end: to).animate(animation);
  }

  Widget _buildBackgroundView() {
    return new Stack(
      children: [
        new DecoratedBox(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                new Color(0xFFD7D7D7),
                new Color(0xFFFAFAFA),
                new Color(0xFFFFFFFF),
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              stops: [0.0, 0.35, 1.0],
            ),
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
            color: new Color(Constants.ColorPrimary),
            letterSpacing: 0.25,
          ),
          textAlign: TextAlign.center,
        ),
        new Padding(
          padding: new EdgeInsets.only(top: 25.0),
          child: new Text(
            subtitle,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 13.0,
              color: new Color(0xFF222222),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBottomSection() {
    return new Align(
      alignment: FractionalOffset.bottomCenter,
      child: new Container(
        width: 180.0,
        height: 46.0,
        margin: new EdgeInsets.only(bottom: 50.0),
        child: new RaisedButton(
          color: new Color(Constants.ColorPrimary),
          child: new Text(
            "START EXPLORING",
            style: new TextStyle(
              color: new Color(0xFFFFFFFF),
              fontSize: 12.0,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/main');
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
    return new Positioned(
      left: 30.0,
      right: 30.0,
      top: 55.0,
      bottom: 0.0,
      child: new Stack(
        children: [
          new FadeTransition(
            opacity: _firstFadeAnimation,
            child: new Column(
              children: [
                _buildTitleSection(title: _title, subtitle: _subtitle),
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: new Center(
                    child: new Image(
                      width: 240.0,
                      height: 240.0,
                      image: new AssetImage(_steps[_currentStep].imageUri),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new FadeTransition(
            opacity: _secondFadeAnimation,
            child: new Column(
              children: [
                _buildTitleSection(title: nextTitle, subtitle: nextSubtitle),
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: new Center(
                    child: new Image(
                      width: 240.0,
                      height: 240.0,
                      image: new AssetImage(_steps[nextStep].imageUri),
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
    bool movingNext = false;
    return new GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (_swipeAmount < _kSwipeThreshold) {
//          print(details.delta.dx);
          movingNext = details.delta.dx <= 0;
          _swipeAmount += details.delta.distance.abs();
          bool didSwipe = (_swipeAmount >= _kSwipeThreshold);
          if (didSwipe) {
            // TODO - parallax background
            // TODO - animate content?
            nextStep += movingNext ? 1 : -1;
            setState(() {
              if (nextStep >= 0 && nextStep < _steps.length) {
                _nextTitle = _steps[nextStep].title;
                _nextSubtitle = _steps[nextStep].subtitle;
              }
            });
            // animate the title
            _titleFadeAnimationController.forward().whenComplete(() {
//              print("finished animation");
              _titleFadeAnimationController.value = 0.0;
              if (movingNext && _currentStep + 1 < _steps.length) {
                _currentStep += 1;
              } else if (!movingNext && _currentStep - 1 >= 0) {
                _currentStep -= 1;
              }
              setState(() {
                if (_currentStep >= 0 && _currentStep < _steps.length) {
                  _title = _steps[_currentStep].title;
                  _subtitle = _steps[_currentStep].subtitle;
                }
              });
            });
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
      color: new Color(0xFFFFFFFF),
      child: _buildGestureDetector(),
    );
  }
}
