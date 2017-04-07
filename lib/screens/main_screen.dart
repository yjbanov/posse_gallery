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

    for (String sectionTitle in sectionList) {
      final sectionContainer = new Container(
          child: new Center(
        child: new Column(
          children: [
            new Text("01"),
            new Text(sectionTitle),
          ],
        ),
      ));
      sectionCells.add(sectionContainer);
    }
    return sectionCells;
  }

  Widget _contentWidget() {
    return new Column(
      children: [
        new DecoratedBox(
          decoration: new BoxDecoration(
            backgroundColor: Colors.white,
          ),
          child: new Row(children: []),
        ),
        new Expanded(
          child: new Padding(
            padding: new EdgeInsets.only(top: 20.0),
            child: new ListView(
              children: _cells,
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
