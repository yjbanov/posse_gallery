// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:posse_gallery/models/app_category.dart';
import 'package:posse_gallery/models/category_item.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => new _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  _MainScreenState() {
    _cells = _loadCategories();
  }

  List<Widget> _cells;

  final List<AppCategory> _categoryList = [
    new AppCategory(
      title: "CUSTOMIZED DESIGN",
      subtitle: "BRAND FIRST EXPERIENCES",
      leftShapeColor: new Color(0xFF19AAEE),
      centerShapeColor: new Color(0xFF00A2EE),
      rightShapeColor: new Color(0xFF1AA3E4),
      categoryColors: [
        new Color(0xFF19AAEE),
        new Color(0x009FEA),
        new Color(0x0084EA),
        Colors.white
      ],
      categoryItems: [
        new CategoryItem(title: "CUSTOMIZED BRAND DESIGN", iconUrl: "a.png"),
        new CategoryItem(title: "ASSETS & THEMES", iconUrl: "a.png"),
        new CategoryItem(title: "PAINTING", iconUrl: "a.png"),
        new CategoryItem(title: "COMPONENTS", iconUrl: "a.png"),
      ],
    ),
    new AppCategory(
      title: "LAYOUT & POSITIONING",
      subtitle: "EASY TO COMPOSE",
      leftShapeColor: new Color(0xFF5BDBFF),
      centerShapeColor: new Color(0xFF45D2F9),
      rightShapeColor: new Color(0xFF53D2F7),
      categoryColors: [
        new Color(0xFF19AAEE),
        new Color(0x009FEA),
        new Color(0x0084EA),
        Colors.white
      ],
      categoryItems: [
        new CategoryItem(title: "FLEX", iconUrl: "a.png"),
        new CategoryItem(title: "STACK", iconUrl: "a.png"),
        new CategoryItem(title: "SCROLL", iconUrl: "a.png"),
        new CategoryItem(title: "COMPONENTS", iconUrl: "a.png"),
      ],
    ),
    new AppCategory(
      title: "ANIMATION & UI MOTION",
      subtitle: "MADE FOR MOTION",
      leftShapeColor: new Color(0xFF38D3CD),
      centerShapeColor: new Color(0xFF25C3BC),
      rightShapeColor: new Color(0xFF3BBCB7),
      categoryColors: [
        new Color(0xFF19AAEE),
        new Color(0x009FEA),
        new Color(0x0084EA),
        Colors.white
      ],
      categoryItems: [
        new CategoryItem(title: "TWEENS", iconUrl: "a.png"),
        new CategoryItem(title: "CHAINS/FRAME", iconUrl: "a.png"),
        new CategoryItem(title: "GESTURES", iconUrl: "a.png"),
        new CategoryItem(title: "COMPONENTS", iconUrl: "a.png"),
      ],
    ),
    new AppCategory(
      title: "UI PATTERNS",
      subtitle: "NATURAL AND PRODUCTIVE",
      leftShapeColor: new Color(0xFFF9B640),
      centerShapeColor: new Color(0xFFFFAC18),
      rightShapeColor: new Color(0xFFFFB02C),
      categoryColors: [
        new Color(0xFF19AAEE),
        new Color(0x009FEA),
        new Color(0x0084EA),
        Colors.white
      ],
      categoryItems: [
        new CategoryItem(title: "MAKE A LIST", iconUrl: "a.png"),
        new CategoryItem(title: "WALKTHROUGH", iconUrl: "a.png"),
        new CategoryItem(title: "EDIT AN IMAGE", iconUrl: "a.png"),
      ],
    ),
    new AppCategory(
      title: "PLUG INS",
      subtitle: "UNIFIED BUILDING BLOCKS",
      leftShapeColor: new Color(0xFFFD734E),
      centerShapeColor: new Color(0xFFFF6941),
      rightShapeColor: new Color(0xFFFA724E),
      categoryColors: [
        new Color(0xFF19AAEE),
        new Color(0x009FEA),
        new Color(0x0084EA),
        Colors.white
      ],
      categoryItems: [
        new CategoryItem(title: "TAKE A PHOTO", iconUrl: "a.png"),
        new CategoryItem(title: "CURRENT LOCATION", iconUrl: "a.png"),
        new CategoryItem(title: "DEVICE MOTION", iconUrl: "a.png"),
        new CategoryItem(title: "CUSTOM SERVICE PLUG-INS", iconUrl: "a.png"),
      ],
    ),
    new AppCategory(
      title: "DESIGN COMPONENTS",
      subtitle: "HIGH FIDELITY TOOLKIT",
      leftShapeColor: new Color(0xFFAFD84C),
      centerShapeColor: new Color(0xFFA1CB39),
      rightShapeColor: new Color(0xFFA3CA4B),
      categoryColors: [
        new Color(0xFF19AAEE),
        new Color(0x009FEA),
        new Color(0x0084EA),
        Colors.white
      ],
      categoryItems: [
        new CategoryItem(title: "IOS CONTROLS", iconUrl: "a.png"),
        new CategoryItem(title: "MATERIAL CONTROLS", iconUrl: "a.png"),
      ],
    ),
  ];

  List<Widget> _loadCategories() {
    List<Widget> categoryCells = [];
    int categoryIndex = 1;
    for (AppCategory category in _categoryList) {
      final categoryContainer = new Container(
        padding:
            const EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
        height: 156.0,
        child: new Card(
          child: new Stack(
            children: [
              new Positioned(
                left: 0.0,
                right: 0.0,
                top: 0.0,
                bottom: 0.0,
                child: new Container(color: category.centerShapeColor),
              ),
              new Positioned(
                right: 0.0,
                top: -45.0,
                child: new Image(
                  height: 200.0,
                  width: 200.0,
                  color: category.rightShapeColor,
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
                  color: category.leftShapeColor,
                  image: new AssetImage("assets/images/section_cell_left.png"),
                  fit: BoxFit.cover,
                ),
              ),
              _categoryTextWidget(category: category, categoryIndex: categoryIndex),
              new Material(
                color: new Color(0x00FFFFFF),
                child: new InkWell(
                  highlightColor: Colors.white.withAlpha(30),
                  splashColor: Colors.white.withAlpha(20),
                  onTap: () {
                    Navigator.of(context).pushNamed('/category');
                  },
                ),
              ),
            ],
          ),
        ),
      );
      categoryCells.add(categoryContainer);
      categoryIndex += 1;
    }
    return categoryCells;
  }

  Widget _categoryTextWidget({category: AppCategory, categoryIndex: int}) {
    return new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Text(
            "$categoryIndex",
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
              category.title,
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.6,
                height: 1.3,
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
  }

  Widget _buildAppBar() {
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
              child: new IconButton(
                padding: EdgeInsets.zero,
                icon: searchIcon,
                onPressed: () {
                  Navigator.of(context).pushNamed('/search');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return new Expanded(
        child: new Container(
            color: new Color(0x00FFFFFF),
            child: new Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: new ListView(
                    children: _cells,
                ),
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
              _buildAppBar(),
              _buildListView(),
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
