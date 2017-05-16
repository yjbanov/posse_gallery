// ignore: invalid_constant
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
  bool _isInitialScreen = false;

  WarmWelcomeScreen({
    bool isInitialScreen,
  })
      : _isInitialScreen = isInitialScreen;

  @override
  _WarmWelcomeScreenState createState() =>
      new _WarmWelcomeScreenState(isInitialScreen: _isInitialScreen);
}

class _WarmWelcomeScreenState extends State<WarmWelcomeScreen>
    with TickerProviderStateMixin {
  static const int _kAnimateOutDuration = 400;
  static const int _kAnimateInDuration = 600;
  static const int _kParallaxAnimationDuration = 400;
  static const int _kWidgetScaleInDuration = 200;
  static const int _kImageSlideUpDuration = 500;
  static const int _kSlideInDuration = 600;

  String _title, _subtitle, _nextTitle, _nextSubtitle;

  bool _isInitialScreen = true;

  Animation<double> _fadeOutAnimation;
  Animation<double> _fadeInAnimation;

  Animation<double> _scaleOutAnimation;
  Animation<double> _scaleInAnimation;
  Animation<FractionalOffset> _textSlideInLeftAnimation;
  Animation<FractionalOffset> _textSlideInRightAnimation;
  Animation<FractionalOffset> _textSlideOutLeftAnimation;
  Animation<FractionalOffset> _textSlideOutRightAnimation;
  Animation<double> _widgetScaleInAnimation1;
  Animation<double> _widgetScaleInAnimation2;
  Animation<double> _widgetScaleInAnimation3;
  Animation<double> _widgetScaleInAnimation4;
  Animation<double> _widgetScaleInAnimation5;
  Animation<double> _widgetScaleInAnimation6;
  Animation<double> _widgetScaleInAnimation7;
  Animation<double> _widgetScaleInAnimation8;
  Animation<double> _widgetScaleInAnimation9;

  AnimationController _animateOutController;
  AnimationController _animateInController;
  AnimationController _slideInAnimationController;
  AnimationController _slideOutAnimationController;
  AnimationController _imageSlideUpAnimationController;
  AnimationController _widgetScaleInController1;
  AnimationController _widgetScaleInController2;
  AnimationController _widgetScaleInController3;
  AnimationController _widgetScaleInController4;
  AnimationController _widgetScaleInController5;
  AnimationController _widgetScaleInController6;
  AnimationController _widgetScaleInController7;
  AnimationController _widgetScaleInController8;
  AnimationController _widgetScaleInController9;

  TabController _tabController;

  List<WelcomeStep> _steps;
  int _currentStep = 0;
  int _nextStep = 1;
  double _bgOffset = -150.0;
  bool movingNext = true;

  double _swipeAmount = 0.0;

  _WarmWelcomeScreenState({
    bool isInitialScreen,
  })
      : _isInitialScreen = isInitialScreen;

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: _buildGestureDetector(),
    );
  }

  Widget _contentWidget(int nextStep) {
    return new Stack(
      children: [
        new Positioned.fill(
          child: _buildBackgroundView(),
        ),
        _buildAnimatedContentView(nextStep: nextStep, movingNext: movingNext),
        new Positioned(
          left: 0.0,
          right: 0.0,
          bottom: MediaQuery.of(context).size.height * 0.16,
          child: new Center(
            child: new TabPageSelector(controller: _tabController),
          ),
        ),
        _buildBottomSection(),
      ],
    );
  }

  @override
  dispose() {
    _animateOutController.dispose();
    _animateInController.dispose();
    _slideInAnimationController.dispose();
    _slideOutAnimationController.dispose();
    _widgetScaleInController1.dispose();
    _widgetScaleInController2.dispose();
    _widgetScaleInController3.dispose();
    _widgetScaleInController4.dispose();
    _widgetScaleInController5.dispose();
    _widgetScaleInController6.dispose();
    _widgetScaleInController7.dispose();
    _widgetScaleInController8.dispose();
    _widgetScaleInController9.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _tabController = new TabController(initialIndex: 0, length: 4, vsync: this);
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

  Widget _buildBackgroundView() {
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
          curve: const Interval(0.25, 1.0, curve: Curves.easeOut),
          child: new Image(
            height: MediaQuery.of(context).size.height,
            image: new AssetImage("assets/backgrounds/bg_flutter_welcome.png"),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedContentView({int nextStep, bool movingNext}) {
    double imageSize = MediaQuery.of(context).size.width * 0.85;
    int previousStep = nextStep;
    if (nextStep != 0) {
      previousStep = movingNext ? nextStep - 1 : nextStep + 1;
    } else if (!movingNext) {
      previousStep += 1;
    }
    AssetImage previousImage;
    if (previousStep == 3) {
      previousImage = new AssetImage(_steps[previousStep].imageUris[5]);
    } else {
      previousImage = new AssetImage(_steps[previousStep].imageUris[0]);
    }
    Animation<FractionalOffset> slideInAnimation =
        movingNext ? _textSlideInLeftAnimation : _textSlideInRightAnimation;
    Animation<FractionalOffset> slideOutAnimation =
        movingNext ? _textSlideOutRightAnimation : _textSlideOutLeftAnimation;
    return new Positioned(
      left: 30.0,
      right: 30.0,
      top: 54.0,
      bottom: 0.0,
      child: new Stack(
        children: [
          new Column(
            children: [
              new SlideTransition(
                position: slideOutAnimation,
                child: _buildTitleSection(
                  title: _title,
                  subtitle: _subtitle,
                ),
              ),
              new ScaleTransition(
                scale: _scaleOutAnimation,
                child: _buildBody(nextStep: previousStep, imageSize: imageSize),
              ),
            ],
          ),
          new SlideTransition(
            position: slideInAnimation,
            child: new Column(
              children: [
                _buildTitleSection(
                  title: _nextTitle,
                  subtitle: _nextSubtitle,
                ),
                new ScaleTransition(
                  scale: _scaleInAnimation,
                  child: _buildBody(nextStep: nextStep, imageSize: imageSize),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBody({@required int nextStep, @required double imageSize}) {
    if (nextStep == 2) {
      return new Stack(
        children: [
          new Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: new Center(
              child: new Image(
                width: imageSize,
                height: imageSize,
                image: new AssetImage(_steps[nextStep].imageUris[0]),
              ),
            ),
          ),
          new Positioned(
            top: 40.0,
            right: 10.0,
            child: new ScaleTransition(
              scale: _widgetScaleInAnimation1,
              child: new Image(
                height: 70.0,
                image: new AssetImage(_steps[nextStep].imageUris[1]),
              ),
            ),
          ),
          new Positioned(
            top: 100.0,
            left: 10.0,
            child: new ScaleTransition(
              scale: _widgetScaleInAnimation2,
              child: new Image(
                height: 55.0,
                image: new AssetImage(_steps[nextStep].imageUris[2]),
              ),
            ),
          ),
          new Positioned(
            bottom: 75.0,
            right: 30.0,
            child: new ScaleTransition(
              scale: _widgetScaleInAnimation3,
              child: new Image(
                height: 35.0,
                image: new AssetImage(_steps[nextStep].imageUris[3]),
              ),
            ),
          ),
          new Positioned(
            bottom: 15.0,
            left: 60.0,
            child: new ScaleTransition(
              scale: _widgetScaleInAnimation4,
              child: new Image(
                height: 35.0,
                image: new AssetImage(_steps[nextStep].imageUris[4]),
              ),
            ),
          ),
        ],
      );
    } else if (nextStep == 3) {
      return new Stack(
        children: [
          new Positioned(
            top: 35.0,
            left: 20.0,
            child: new ScaleTransition(
              scale: _widgetScaleInAnimation5,
              child: new Opacity(
                opacity: 0.3,
                child: new Image(
                  height: 35.0,
                  image: new AssetImage(_steps[nextStep].imageUris[3]),
                ),
              ),
            ),
          ),
          new Positioned(
            top: 35.0,
            right: 25.0,
            child: new ScaleTransition(
              scale: _widgetScaleInAnimation6,
              child: new Opacity(
                opacity: 0.3,
                child: new Image(
                  height: 60.0,
                  image: new AssetImage(_steps[nextStep].imageUris[1]),
                ),
              ),
            ),
          ),
          new Positioned(
            top: 135.0,
            right: 35.0,
            child: new ScaleTransition(
              scale: _widgetScaleInAnimation7,
              child: new Opacity(
                opacity: 0.3,
                child: new Image(
                  height: 35.0,
                  image: new AssetImage(_steps[nextStep].imageUris[2]),
                ),
              ),
            ),
          ),
          new Positioned(
            bottom: 0.0,
            left: 18.0,
            child: new ScaleTransition(
              scale: _widgetScaleInAnimation8,
              child: new Opacity(
                opacity: 0.3,
                child: new Image(
                  height: 55.0,
                  image: new AssetImage(_steps[nextStep].imageUris[0]),
                ),
              ),
            ),
          ),
          new Positioned(
            bottom: 0.0,
            right: 15.0,
            child: new ScaleTransition(
              scale: _widgetScaleInAnimation9,
              child: new Opacity(
                opacity: 0.3,
                child: new Image(
                  height: 65.0,
                  image: new AssetImage(_steps[nextStep].imageUris[4]),
                ),
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: new Center(
              child: new Image(
                width: imageSize * 0.85,
                height: imageSize * 0.85,
                image: new AssetImage(_steps[nextStep].imageUris[5]),
              ),
            ),
          ),
        ],
      );
    } else {
      return new Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: new Center(
          child: new FadeTransition(
            opacity: _fadeInAnimation,
            child: new Image(
              width: imageSize,
              height: imageSize,
              image: new AssetImage(_steps[nextStep].imageUris[0]),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildBottomSection() {
    return new Align(
      alignment: FractionalOffset.bottomCenter,
      child: new Container(
        width: 180.0,
        height: 46.0,
        margin: const EdgeInsets.only(bottom: 38.0),
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
            if (_isInitialScreen) {
              Navigator.pushReplacement(
                context,
                new PageRouteBuilder<Null>(
                  settings: const RouteSettings(name: "/main"),
                  pageBuilder: (BuildContext context, Animation<double> _,
                      Animation<double> __) {
                    return new MainScreen();
                  },
                ),
              );
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
    );
  }

  Widget _buildGestureDetector() {
    return new GestureDetector(
      onHorizontalDragUpdate: (details) {
        _swipeAmount += -details.delta.dx;
        double interpolationValue =
            _swipeAmount / MediaQuery.of(context).size.width;
//        print(interpolationValue);
        movingNext = interpolationValue >= 0;
        if (movingNext && _currentStep == _steps.length - 1 ||
            !movingNext && _currentStep == 0) {
          _swipeAmount = 0.0;
          return;
        }

        if (!movingNext) {
          interpolationValue = -interpolationValue;
        }
        interpolationValue = interpolationValue.clamp(0.0, 1.0);

        _animateOutController.value = interpolationValue;
        _slideInAnimationController.value = interpolationValue;
        _slideOutAnimationController.value = interpolationValue;
        _imageSlideUpAnimationController.value = interpolationValue;
        _animateInController.value = interpolationValue;

        int previousNextStep = _nextStep;
        _nextStep = movingNext ? _currentStep + 1 : _currentStep - 1;
        if (interpolationValue >= 1.0 || previousNextStep != _nextStep) {
          setState(() {
            if (interpolationValue >= 1.0) {
              _currentStep = _nextStep;
            }
            if (interpolationValue == 1.0) {
              _startSecondaryWidgetAnimation();
            }
            _swipeAmount = 0.0;
            _nextTitle = _steps[_nextStep].title;
            _nextSubtitle = _steps[_nextStep].subtitle;
            _title = _steps[_currentStep].title;
            _subtitle = _steps[_currentStep].subtitle;
          });
        }
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        double interpolationValue =
            (_swipeAmount / MediaQuery.of(context).size.width);
        _swipeAmount = 0.0;
        if (interpolationValue <= 0.0 && _currentStep == 0) {
          return;
        }
        if (interpolationValue >= 0.0 && _currentStep == _steps.length - 1) {
          return;
        }
        interpolationValue = interpolationValue.abs();
//        print(interpolationValue);
        if (interpolationValue < 0.05) {
          _reverseAnimation();
          _startSecondaryWidgetAnimation();
        } else {
          _startAnimation();
//          if (movingNext && _currentStep + 1 < _steps.length) {
//            _bgOffset -= MediaQuery.of(context).size.width / 5;
//          } else if (!movingNext && _currentStep - 1 >= 0) {
//            _bgOffset += MediaQuery.of(context).size.width / 5;
//          }
          _currentStep += movingNext ? 1 : -1;
          _tabController.animateTo(_currentStep);
        }
      },
      child: _contentWidget(_nextStep),
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
              letterSpacing: 0.25,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  _configureAnimation() {
    _animateOutController = new AnimationController(
      duration: const Duration(milliseconds: _kAnimateOutDuration),
      vsync: this,
    );
    _animateInController = new AnimationController(
      duration: const Duration(milliseconds: _kAnimateInDuration),
      vsync: this,
    );
    _slideInAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kSlideInDuration),
      vsync: this,
    );
    _slideOutAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kSlideInDuration),
      vsync: this,
    );
    _imageSlideUpAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kImageSlideUpDuration),
      vsync: this,
    );
    _widgetScaleInController1 = new AnimationController(
      duration: const Duration(milliseconds: _kWidgetScaleInDuration),
      vsync: this,
    );
    _widgetScaleInController2 = new AnimationController(
      duration: const Duration(milliseconds: _kWidgetScaleInDuration),
      vsync: this,
    );
    _widgetScaleInController3 = new AnimationController(
      duration: const Duration(milliseconds: _kWidgetScaleInDuration),
      vsync: this,
    );
    _widgetScaleInController4 = new AnimationController(
      duration: const Duration(milliseconds: _kWidgetScaleInDuration),
      vsync: this,
    );
    _widgetScaleInController5 = new AnimationController(
      duration: const Duration(milliseconds: _kWidgetScaleInDuration),
      vsync: this,
    );
    _widgetScaleInController6 = new AnimationController(
      duration: const Duration(milliseconds: _kWidgetScaleInDuration),
      vsync: this,
    );
    _widgetScaleInController7 = new AnimationController(
      duration: const Duration(milliseconds: _kWidgetScaleInDuration),
      vsync: this,
    );
    _widgetScaleInController8 = new AnimationController(
      duration: const Duration(milliseconds: _kWidgetScaleInDuration),
      vsync: this,
    );
    _widgetScaleInController9 = new AnimationController(
      duration: const Duration(milliseconds: _kWidgetScaleInDuration),
      vsync: this,
    );
    _fadeOutAnimation = _initAnimation(
        from: 1.0,
        to: 1.0,
        curve: Curves.linear,
        controller: _animateOutController);
    _fadeInAnimation = _initAnimation(
        from: 1.0,
        to: 1.0,
        curve: Curves.easeOut,
        controller: _animateInController);
    _scaleOutAnimation = _initAnimation(
        from: 1.0,
        to: 0.0,
        curve: Curves.easeOut,
        controller: _animateOutController);
    _scaleInAnimation = _initAnimation(
        from: 0.1,
        to: 1.0,
        curve: Curves.linear,
        controller: _animateInController);
    _textSlideInLeftAnimation = _initSlideAnimation(
        from: const FractionalOffset(1.3, 0.0),
        to: const FractionalOffset(0.0, 0.0),
        curve: Curves.easeInOut,
        controller: _slideInAnimationController);
    _textSlideInRightAnimation = _initSlideAnimation(
        from: const FractionalOffset(-1.3, 0.0),
        to: const FractionalOffset(0.0, 0.0),
        curve: Curves.easeInOut,
        controller: _slideInAnimationController);
    _textSlideOutLeftAnimation = _initSlideAnimation(
        from: const FractionalOffset(0.0, 0.0),
        to: const FractionalOffset(1.3, 0.0),
        curve: Curves.easeInOut,
        controller: _slideOutAnimationController);
    _textSlideOutRightAnimation = _initSlideAnimation(
        from: const FractionalOffset(0.0, 0.0),
        to: const FractionalOffset(-1.3, 0.0),
        curve: Curves.easeInOut,
        controller: _slideOutAnimationController);
    _widgetScaleInAnimation1 = _initAnimation(
        from: 0.01,
        to: 1.0,
        curve: Curves.decelerate,
        controller: _widgetScaleInController1);
    _widgetScaleInAnimation2 = _initAnimation(
        from: 0.01,
        to: 1.0,
        curve: Curves.decelerate,
        controller: _widgetScaleInController2);
    _widgetScaleInAnimation3 = _initAnimation(
        from: 0.01,
        to: 1.0,
        curve: Curves.decelerate,
        controller: _widgetScaleInController3);
    _widgetScaleInAnimation4 = _initAnimation(
        from: 0.01,
        to: 1.0,
        curve: Curves.decelerate,
        controller: _widgetScaleInController4);
    _widgetScaleInAnimation5 = _initAnimation(
        from: 0.01,
        to: 1.0,
        curve: Curves.decelerate,
        controller: _widgetScaleInController5);
    _widgetScaleInAnimation6 = _initAnimation(
        from: 0.01,
        to: 1.0,
        curve: Curves.decelerate,
        controller: _widgetScaleInController6);
    _widgetScaleInAnimation7 = _initAnimation(
        from: 0.01,
        to: 1.0,
        curve: Curves.decelerate,
        controller: _widgetScaleInController7);
    _widgetScaleInAnimation8 = _initAnimation(
        from: 0.01,
        to: 1.0,
        curve: Curves.decelerate,
        controller: _widgetScaleInController8);
    _widgetScaleInAnimation9 = _initAnimation(
        from: 0.01,
        to: 1.0,
        curve: Curves.decelerate,
        controller: _widgetScaleInController9);
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

  _reverseAnimation() {
    _animateOutController.reverse();
    _slideOutAnimationController.reverse();
    _slideInAnimationController.reverse();
    _imageSlideUpAnimationController.reverse();
    _animateInController.reverse();
  }

  _startAnimation() {
    _reverseSecondaryWidgetAnimations();
    _animateOutController.forward();
    _slideInAnimationController.forward();
    _slideOutAnimationController.forward();
    _imageSlideUpAnimationController.forward();
//    print("start");
    _animateInController.forward().whenComplete(() {
      _startSecondaryWidgetAnimation();
    });
  }

  _reverseSecondaryWidgetAnimations() {
    if (_currentStep == 2) {
      _widgetScaleInController1.reverse();
      _widgetScaleInController2.reverse();
      _widgetScaleInController3.reverse();
      _widgetScaleInController4.reverse();
    } else if (_currentStep == 3) {
      _widgetScaleInController5.reverse();
      _widgetScaleInController6.reverse();
      _widgetScaleInController7.reverse();
      _widgetScaleInController8.reverse();
      _widgetScaleInController9.reverse();
    }
  }

  _startSecondaryWidgetAnimation() {
//    print("secondary");
    if (_currentStep == 2) {
      _widgetScaleInController3.forward().whenComplete(() {
        _widgetScaleInController4.forward().whenComplete(() {
          _widgetScaleInController1.forward().whenComplete(() {
            _widgetScaleInController2.forward().whenComplete(() {});
          });
        });
      });
    } else if (_currentStep == 3) {
      _widgetScaleInController5.forward().whenComplete(() {
        _widgetScaleInController6.forward().whenComplete(() {
          _widgetScaleInController7.forward().whenComplete(() {
            _widgetScaleInController8.forward().whenComplete(() {
              _widgetScaleInController9.forward().whenComplete(() {});
            });
          });
        });
      });
    }
  }
}
