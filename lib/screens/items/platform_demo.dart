// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class PlatformDemo extends StatefulWidget {
  @override
  PlatformDemoState createState() => new PlatformDemoState();
}

class PlatformDemoState extends State<PlatformDemo>
    with TickerProviderStateMixin {

  TargetPlatform _targetPlatform;
  ThemeData _themeData;

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

  Widget _buildAppBar() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    TextAlign titleTextAlignment = _targetPlatform == TargetPlatform.android
        ? TextAlign.center
        : TextAlign.left;
    return new Container(
      height: 76.0,
      padding: new EdgeInsets.only(top: statusBarHeight),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new BackButton(),
          new Expanded(
            child: new Text(
              "Modern Furniture",
              style: new TextStyle(
                color: _themeData.textTheme.title.color,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
              textAlign: titleTextAlignment,
            ),
          ),
          new IconButton(
            icon: new Icon(
              Icons.more_vert,
              color: _themeData.iconTheme.color,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return new Expanded(
      child: new Column(
        children: [
          new Expanded(
            child: new Container(
              child: new Stack(
                alignment: FractionalOffset.bottomCenter,
                children: [
                  new Image(
                    image: new AssetImage(
                        "assets/images/images_platform_hero.png"),
                    fit: BoxFit.fitHeight,
                  ),
                  new Center(
                    child: new Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Text(
                          "FEATURED",
                          style: new TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: new Text(
                            "GEOMETRIC DINING CHAIR",
                            style: new TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Row(
            children: [
              new Container(
                child: new Stack(
                  children: [
                    new Image(
                      width: MediaQuery.of(context).size.width * 0.5,
                      image: new AssetImage(
                          "assets/images/images_platform_lamp.png"),
                    ),
                    new Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: new Text(
                        "THE\nWALL LAMP",
                        style: new TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                child: new Stack(
                  children: [
                    new Image(
                      width: MediaQuery.of(context).size.width * 0.5,
                      image: new AssetImage(
                          "assets/images/images_platform_table.png"),
                    ),
                    new Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: new Text(
                        "NATURAL\nSIDE TABLE",
                        style: new TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    double buttonBorderRadius =
        _targetPlatform == TargetPlatform.iOS ? 2.0 : 0.0;
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(buttonBorderRadius),
      ),
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
      child: new Row(
        children: [
          new Expanded(
            child: new FlatButton(
              color: _themeData.buttonColor,
              child: new Text(
                "ADD TO CART",
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

  _configureThemes() {
    _targetPlatform = TargetPlatform.iOS;
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
      children: [
        _buildAppBar(),
        _buildBody(),
//        _buildBottomButton(),
      ],
    );
  }
}
