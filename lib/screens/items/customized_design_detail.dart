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
            child: new IconButton(
              color: Colors.white,
              icon: new RotatedBox(
                quarterTurns: 2,
                child: new ImageIcon(
                  new AssetImage("assets/icons/ic_custom_circle_arrow.png"),
                ),
              ),
              onPressed: (() {
                print("tapped");
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
          new Image(
            image: new AssetImage("assets/images/custom_path.png"),
          ),
          new Positioned(
            left: 0.0,
            bottom: 20.0,
            right: 0.0,
            child: _buildPathStatsRow(),
          ),
        ],
      ),
    );
  }

  _buildPathStatsRow() {
    TextStyle statsTextStyle = new TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w900,
      fontStyle: FontStyle.italic,
      color: Colors.white,
    );
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new Icon(Icons.timer),
            new Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: new Text(
                "00:26:13",
                style: statsTextStyle,
              ),
            ),
          ],
        ),
        new Row(
          children: [
            new Icon(Icons.access_time),
            new Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: new Text(
                "7'13\"",
                style: statsTextStyle,
              ),
            )
          ],
        ),
        new Row(
          children: [
            new Icon(Icons.landscape),
            new Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: new Text(
                "120ft",
                style: statsTextStyle,
              ),
            ),
          ],
        ),
        new Row(
          children: [
            new Icon(Icons.favorite),
            new Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: new Text(
                "97bpm",
                style: statsTextStyle,
              ),
            ),
          ],
        ),
      ],
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
      height: MediaQuery.of(context).size.height * 0.34,
      color: const Color(0xFFF6FB09),
      child: new Column(
        children: [
          new Row(
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
          new Column(
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
        ],
      ),
    );
  }

  Widget _contentWidget() {
    return new Column(
      children: [
        _buildAppBar(),
        _buildPathContent(),
        _buildStatsBox(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _platformTextAlignment =
        Theme.of(context).platform == TargetPlatform.android
            ? TextAlign.left
            : TextAlign.center;
    return new Material(
      color: const Color(0xFFFFFFFF),
      child: _contentWidget(),
    );
  }
}
