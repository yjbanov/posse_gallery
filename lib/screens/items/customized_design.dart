// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:posse_gallery/screens/items/customized_design_detail.dart';

class CustomizedDesign extends StatefulWidget {
  @override
  _CustomizedDesignState createState() => new _CustomizedDesignState();
}

class _CustomizedDesignState extends State<CustomizedDesign> {
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

  Widget _buildBackButton() {
    TargetPlatform platform = Theme.of(context).platform;
    final IconData backIcon = platform == TargetPlatform.android
        ? Icons.arrow_back
        : Icons.arrow_back_ios;
    return new Container(
      height: 70.0,
      width: 70.0,
      child: new Material(
        color: const Color(0x00FFFFFF),
        child: new IconButton(
          icon: new Icon(backIcon, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return new Stack(
      children: [
        new Image(
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.fitHeight,
          image: new AssetImage(
            "assets/images/custom_hero.png",
          ),
        ),
        new Positioned.fill(
          child: new Center(
            child: _buildTextBody(),
          ),
        ),
        new Positioned(
          left: -7.0,
          top: 13.0,
          child: _buildBackButton(),
        ),
        _buildBottomBar(),
      ],
    );
  }

  _buildBottomBar() {
    return new Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: new Container(
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
                icon: new ImageIcon(
                  new AssetImage("assets/icons/ic_custom_circle_arrow.png"),
                ),
                onPressed: (() {
                  Navigator.push(
                    context,
                    new MaterialPageRoute<Null>(
                      fullscreenDialog: true,
                      settings: new RouteSettings(),
                      builder: (BuildContext context) {
                        return new CustomizedDesignDetail();
                      },
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextBody() {
    final firstText = new Text(
      "EASILY TRACK YOUR ACTIVITY",
      textAlign: TextAlign.center,
      style: new TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 40.0,
        fontWeight: FontWeight.w900,
        color: Colors.white,
      ),
    );
    final secondText = new Text(
      "ACTIVITY",
      style: new TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 40.0,
        fontWeight: FontWeight.w900,
        color: const Color(0xFFF6F309),
      ),
    );
    final combinedText = firstText;
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        new Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: combinedText,
        ),
        new Container(
          height: 3.0,
          width: 66.0,
          color: Colors.white,
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 50.0, right: 50.0),
          child: new Text(
            "Keep your phone with you while running, cycling, or walking to get stats on your activity.",
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ),
      ],
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
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildBody(),
      ],
    );
  }
}
