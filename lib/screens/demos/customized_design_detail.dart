// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class CustomizedDesignDetail extends StatefulWidget {

  @override
  _CustomizedDesignDetailDemoState createState() =>
      new _CustomizedDesignDetailDemoState();
}

class _CustomizedDesignDetailDemoState extends State<CustomizedDesignDetail>
    with TickerProviderStateMixin {
  TextAlign _platformTextAlignment;

  @override
  Widget build(BuildContext context) {
    _platformTextAlignment =
        Theme.of(context).platform == TargetPlatform.android
            ? TextAlign.left
            : TextAlign.center;
    return _contentWidget();
  }

  _buildGestureDetector() {
    return new GestureDetector(
      onVerticalDragUpdate: (details) {
        print(details);
      },
      child: new Material(
        color: const Color(0xFFFFFFFF),
        child: _contentWidget(),
      ),
    );
  }

  animateTransition(DragUpdateDetails details) {
    print(details);
  }

  _buildAppBar() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
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
            child: new IconButton(
              color: Colors.white,
              icon: new RotatedBox(
                quarterTurns: 2,
                child: new ImageIcon(
                  new AssetImage("assets/icons/ic_custom_circle_arrow.png"),
                ),
              ),
              onPressed: (() {
//                Navigator.of(context).pop();
              }),
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
          new Positioned(
            right: 18.0,
            top: 35.0,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Text(
                  "3.5mi",
                  textAlign: TextAlign.left,
                  style: new TextStyle(
                    color: const Color(0xFFF6FB09),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                new Text(
                  "974 calories",
                  textAlign: TextAlign.left,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          new Positioned(
            left: 5.0,
            right: 5.0,
            top: 20.0,
            child: new Image(
              image: new AssetImage("assets/images/custom_path.png"),
            ),
          ),
          new Positioned(
            left: 14.0,
            bottom: 60.0,
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
          new Positioned(
            right: 10.0,
            bottom: 60.0,
            child: new Icon(Icons.event, color: const Color(0xFF02CEA1)),
          ),
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
          new Row(
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
          new Row(
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
          new Row(
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
          new Row(
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
    return new Container(
      height: MediaQuery.of(context).size.height * 0.4,
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
                      "158",
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
                      "9,365FT",
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
                  "643.6",
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

  Widget _contentWidget() {
    return new Stack(
      children: [
        _buildAppBar(),
        new Positioned(
          left: 0.0,
          right: 0.0,
          top: 70.0,
          bottom: MediaQuery.of(context).size.height * 0.4,
          child: _buildPathContent(),
        ),
        new Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: _buildStatsBox(),
        ),
      ],
    );
  }
}
