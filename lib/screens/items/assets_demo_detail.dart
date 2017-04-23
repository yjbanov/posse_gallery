// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class AssetsDetailDemo extends StatefulWidget {
  @override
  _AssetsDetailDemoState createState() => new _AssetsDetailDemoState();
}

class _AssetsDetailDemoState extends State<AssetsDetailDemo> {

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
              "Classic Apple Pie",
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
          new Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: new Text(
              "INGREDIENTS",
              style: new TextStyle(
                color: const Color(0xFFC7C7C7),
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 2.0,
              ),
            ),
          ),
          new Text(
            "2 Cups all-purpose flour\n"
                "3/4 teaspoon salt\n"
                "1 cup vegetable shortening\n"
                "1 egg\n"
                "2 tablespoons of cold water\n"
                "1 tablespoon of cinnamon",
            textAlign: TextAlign.center,
            style: new TextStyle(
                color: const Color(0xFF979797),
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                height: 1.6),
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
                "Step 1: Make Crust",
                style: new TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: () {},
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
