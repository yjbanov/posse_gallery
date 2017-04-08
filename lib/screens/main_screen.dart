// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:posse_gallery/models/app_section.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => new _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  _MainScreenState() {
    _cells = _loadSections();
  }

  List<Widget> _cells;

  final List<AppSection> _sectionList = [
    new AppSection(
        title: "CUSTOMIZED DESIGN",
        leftShapeColor: new Color(0xFF19AAEE),
        centerShapeColor: new Color(0xFF00A2EE),
        rightShapeColor: new Color(0xFF1AA3E4)),
    new AppSection(
        title: "LAYOUT & POSITIONING",
        leftShapeColor: new Color(0xFF5BDBFF),
        centerShapeColor: new Color(0xFF45D2F9),
        rightShapeColor: new Color(0xFF53D2F7)),
    new AppSection(
        title: "ANIMATION & UI MOTION",
        leftShapeColor: new Color(0xFF38D3CD),
        centerShapeColor: new Color(0xFF25C3BC),
        rightShapeColor: new Color(0xFF3BBCB7)),
    new AppSection(
        title: "UI PATTERNS",
        leftShapeColor: new Color(0xFFF9B640),
        centerShapeColor: new Color(0xFFFFAC18),
        rightShapeColor: new Color(0xFFFFB02C)),
    new AppSection(
        title: "PLUG INS",
        leftShapeColor: new Color(0xFFFD734E),
        centerShapeColor: new Color(0xFFFF6941),
        rightShapeColor: new Color(0xFFFA724E)),
    new AppSection(
        title: "DESIGN COMPONENTS",
        leftShapeColor: new Color(0xFFAFD84C),
        centerShapeColor: new Color(0xFFA1CB39),
        rightShapeColor: new Color(0xFFA3CA4B)),
  ];

  List<Widget> _loadSections() {
    List<Widget> sectionCells = [];
    int sectionIndex = 1;
    for (AppSection section in _sectionList) {
      final sectionContainer = new Container(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
        height: 156.0,
        child: new Card(
          child: new Stack(
            children: [
              new Positioned(
                left: 0.0,
                right: 0.0,
                top: 0.0,
                bottom: 0.0,
                child: new Container(color: section.centerShapeColor),
              ),
              new Positioned(
                right: 0.0,
                top: -45.0,
                child: new Image(
                  height: 200.0,
                  width: 200.0,
                  color: section.rightShapeColor,
                  image: new AssetImage("assets/images/section_cell_right.png"),
                  fit: BoxFit.cover,
                ),
              ),
              new Positioned(
                left: 0.0,
                top: -40.0,
                child: new Image(
                  height: 250.0,
                  width: 210.0,
                  color: section.leftShapeColor,
                  image: new AssetImage("assets/images/section_cell_left.png"),
                  fit: BoxFit.cover,
                ),
              ),
              _sectionTextWidget(section: section, sectionIndex: sectionIndex),
              new Material(
                color: new Color(0x00FFFFFF),
                child: new InkWell(
                  highlightColor: Colors.white.withAlpha(30),
                  splashColor: Colors.white.withAlpha(20),
                  onTap: () {
                    print("tapped cell");
                  },
                ),
              ),
            ],
          ),
        ),
      );
      sectionCells.add(sectionContainer);
      sectionIndex += 1;
    }
    return sectionCells;
  }

  Widget _sectionTextWidget({section: AppSection, sectionIndex: int}) {
    return new Center(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Text(
            "$sectionIndex",
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 10.0,
              color: Colors.white,
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 7.0),
            child: new Text(
              section.title,
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.7,
                height: 1.3,
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBarWidget() {
    Image searchIcon = new Image(
      image: new AssetImage("assets/icons/ic_search.png"),
      fit: BoxFit.cover,
    );
    return new Container(
      height: 64.0,
      child: new DecoratedBox(
        decoration: new BoxDecoration(),
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
              right: 0.0,
              top: 23.0,
              child: new Material(
                color: new Color(0x00FFFFFF),
                child: new IconButton(
                  padding: EdgeInsets.zero,
                  icon: searchIcon,
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contentWidget() {
    return new Stack(
      children: [
        new Positioned(
          top: 0.0,
          right: 0.0,
          child: new Image(
            image: new AssetImage("assets/images/bg_main_screen.png"),
          ),
        ),
        new Positioned(
          child: new Column(
            children: [
              _appBarWidget(),
              new Expanded(
                child: new Container(
                  color: new Color(0x00FFFFFF),
                  child: new Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: new ListView(
                      children: _cells,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: new Center(
        child: _contentWidget(),
      ),
    );
  }
}
