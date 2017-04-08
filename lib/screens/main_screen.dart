// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => new _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  _MainScreenState() {
    _cells = _loadSections();
  }

  List<Widget> _cells;

  final List<String> sectionList = [
    "Customized Design".toUpperCase(),
    "Layout & Positioning".toUpperCase(),
    "Animation & UI Motion".toUpperCase(),
    "UI Patterns".toUpperCase(),
    "Plug Ins".toUpperCase(),
    "Design Components".toUpperCase(),
  ];

  @override
  void initState() {
    super.initState();

    _configureUI();
  }

  void _configureUI() {}

  List<Widget> _loadSections() {
    List<Widget> sectionCells = [];

    int sectionNumber = 1;
    for (String sectionTitle in sectionList) {
      final sectionContainer = new Container(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
        height: 156.0,
        child: new Card(
          color: new Color(0xFF53D2F7),
          child: new Center(
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Text(
                  "$sectionNumber",
                  style: new TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 7.0),
                  child: new Text(
                    sectionTitle,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      sectionCells.add(sectionContainer);
      sectionNumber += 1;
    }
    return sectionCells;
  }

  Widget _contentWidget() {
    return new Column(
      children: [
        new Container(
          height: 64.0,
          child: new DecoratedBox(
            decoration: new BoxDecoration(
              backgroundColor: Colors.white,
            ),
            child: new Stack(
              children: [
                new Positioned(
                  left: 12.0,
                  top: 32.0,
                  child: new Image(
                    image: new AssetImage("assets/icons/ic_flutter_logo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                new Positioned(
                  left: 52.0,
                  top: 35.0,
                  child: new Text(
                    "Flutter Gallery",
                    style: new TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                      color: new Color(0xFF29B6F6),
                    ),
                  ),
                ),
                new Positioned(
                  right: 12.0,
                  top: 36.0,
                  child: new Image(
                    image: new AssetImage("assets/icons/ic_search.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
        new Expanded(
          child: new Container(
            color: Colors.white,
            child: new Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: new ListView(
                children: _cells,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Center(
        child: _contentWidget(),
      ),
    );
  }
}
