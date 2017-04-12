// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:posse_gallery/config/constants.dart';

class WarmWelcomeScreen extends StatefulWidget {
  @override
  _WarmWelcomeScreenState createState() => new _WarmWelcomeScreenState();
}

class _WarmWelcomeScreenState extends State<WarmWelcomeScreen> with TickerProviderStateMixin {

  String title, subtitle, nextTitle, nextSubtitle;
  int item = 0;

  Animation<double> _firstFadeAnimation;
  Animation<double> _secondFadeAnimation;
  AnimationController _titleFadeAnimationController;

  final double kSwipeThreshold = 150.0;
  double swipeAmount = 0.0;

  _WarmWelcomeScreenState() {
    title = "Welcome to Flutter";
    subtitle = "Flutter is a mobile app SDK for building high-performance, high-fidelity, apps for iOS and Android.";
    nextTitle = "Something";
    nextSubtitle = "This is the next subtitle";
    _titleFadeAnimationController = new AnimationController(
      duration: new Duration(milliseconds: 1200),
      vsync: this,
    );
    _firstFadeAnimation = _initTitleAnimation(from: 1.0, to: 0.0, curve: Curves.easeOut);
    _secondFadeAnimation = _initTitleAnimation(from: 0.0, to: 1.0, curve: Curves.easeIn);
  }

  Animation<double> _initTitleAnimation({@required double from, @required double to, @required Curve curve}) {
    final CurvedAnimation animation = new CurvedAnimation(
      parent: _titleFadeAnimationController,
      curve: curve,
    );
    return new Tween<double>(begin: from, end: to).animate(animation);
  }

  Widget backgroundView() {
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

  Widget titleSection({@required String title, @required String subtitle}) {
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

  Widget bottomSection() {
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
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: new Color(0xFFFFFFFF),
      child: new GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (swipeAmount < kSwipeThreshold) {
            print(details.delta.dx);
            bool movingNext = details.delta.dx <= 0;
            swipeAmount += details.delta.distance.abs();
            bool didSwipe = (swipeAmount >= kSwipeThreshold);
            if (didSwipe) {
              // TODO - parallax background
              // TODO - animate content?
              // debug
              item += movingNext ? 1 : -1;
              setState(() {
                nextTitle = "item $item";
                nextSubtitle = "this thing $item ...";
              });
              // animate the title
              _titleFadeAnimationController.forward().whenComplete(() {
                print("finished animation");
                _titleFadeAnimationController.value = 0.0;
                setState(() {
                  title = "item $item";
                  subtitle = "this thing $item ...";
                });
              });
            }
          }
        },
        onHorizontalDragEnd: (details) {
          swipeAmount = 0.0;
        },
        child: new Stack(
          children: [
            new Positioned.fill(
              child: backgroundView(),
            ),
            new Positioned(
              left: 30.0, right: 30.0, top: 80.0, bottom: 0.0,
              child: new Stack(
                children: [
                  new FadeTransition(
                    opacity: _firstFadeAnimation,
                    child: titleSection(title: title, subtitle: subtitle),
                  ),
                  new FadeTransition(
                    opacity: _secondFadeAnimation,
                    child: titleSection(title: nextTitle, subtitle: nextSubtitle),
                  ),
                  // TODO - what do we wrap this in?
                  new Center(
                    child: new Container(
                      width: 300.0,
                      height: 300.0,
                      color: new Color(0xFFFF0000),
                    ),
                  ),
                  // TODO - what do we wrap this in?
                  new Center(
                    child: new Container(
                      width: 300.0,
                      height: 300.0,
                      color: new Color(0xFF0000FF),
                    ),
                  ),
                ],
              ),
            ),
            bottomSection(),
          ],
        ),
      ),
    );
  }
}
