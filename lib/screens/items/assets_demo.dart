// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:posse_gallery/screens/items/assets_demo_detail.dart';

class AssetsDemo extends StatefulWidget {
  @override
  _AssetsDemoState createState() => new _AssetsDemoState();
}

class _AssetsDemoState extends State<AssetsDemo> {
  Widget _buildAppBar() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return new Container(
      height: 56.0,
      padding: new EdgeInsets.only(top: statusBarHeight),
      child: new Row(
        children: [
          new IconButton(
            icon: new Icon(Icons.arrow_back, color: const Color(0xFF4A4A4A)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new Expanded(
            child: new Text(
              "My Recipe Book",
              style: new TextStyle(
                color: const Color(0xFF4A4A4A),
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          new IconButton(
            icon: new Icon(
              Icons.more_vert,
              color: const Color(0xFF4A4A4A),
            ),
            onPressed: null,
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return new Expanded(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: new Image(
              image: new AssetImage("assets/images/assets_demo_pie.png"),
            ),
          ),
          new Text(
            "Classic Apple Pie",
            style: new TextStyle(
              color: const Color(0xFF4A4A4A),
              fontSize: 22.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
            child: new Image(
              image: new AssetImage("assets/images/brand_profile.png"),
            ),
          ),
          new Text(
            "By Jenny Flay",
            style: new TextStyle(
              color: const Color(0xFFAAAAAA),
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: new Center(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: new Image(
                      image: new AssetImage("assets/images/brand_stars.png"),
                    ),
                  ),
                  new Text(
                    "120",
                    style: new TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF4A4A4A),
                    ),
                  ),
                  new Text(
                    "Mins",
                    style: new TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF4A4A4A),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return new Container(
      height: 50.0,
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
      child: new Row(
        children: [
          new Expanded(
            child: new FlatButton(
              color: const Color(0xFF5FAD2C),
              child: new Text(
                "View Recipe",
                style: new TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  new PageRouteBuilder<Null>(
                    settings: new RouteSettings(),
                    pageBuilder: (BuildContext context, Animation<double> _,
                        Animation<double> __) {
                      return new AssetsDetailDemo();
                    },
                    transitionsBuilder: (
                      BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child,
                    ) {
                      return new FadeTransition(
                          opacity: animation, child: child);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentWidget() {
    return new Column(
      children: [
        _buildAppBar(),
        _buildBody(),
        _buildBottomButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: const Color(0xFFFFFFFF),
      child: _contentWidget(),
    );
  }
}
