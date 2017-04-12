// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:posse_gallery/managers/category_manager.dart';
import 'package:posse_gallery/models/app_category.dart';
import 'package:posse_gallery/models/category_item.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({
    AppCategory appCategory,
  })
      : _appCategory = appCategory;

  final AppCategory _appCategory;

  @override
  _CategoryScreenState createState() =>
      new _CategoryScreenState(appCategory: _appCategory);
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  _CategoryScreenState({
    AppCategory appCategory,
  })
      : _appCategory = appCategory;

  AppCategory _appCategory;
  List<Widget> _cells;

  @override
  void initState() {
    super.initState();
    setState(() {
      _cells = _loadItems();
    });
  }

  List<Widget> _loadItems() {
    List<Widget> cells = [];
    for (int i = 0; i < _appCategory.categoryItems.length; i++) {
      CategoryItem item = _appCategory.categoryItems[i];
      Color color = _appCategory.categoryColors[i];
      Color textColor =
          item.title == "COMPONENTS" ? Colors.black : Colors.white;
      final cellContainer = new Container(
        color: color,
        height: 163.0,
        child: new Stack(
          children: [
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: new Image(
                    width: 50.0,
                    image: new AssetImage(item.iconUri),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 20.0),
                    child: new Text(
                      item.title,
                      style: new TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Material(
              color: new Color(0x00FFFFFF),
              child: new InkWell(
                highlightColor: Colors.white.withAlpha(30),
                splashColor: Colors.white.withAlpha(20),
                onTap: () {
                  Navigator.of(context).pushNamed('/item');
                },
              ),
            ),
          ],
        ),
      );
      cells.add(cellContainer);
    }
    return cells;
  }

  Widget _appBarCategoryView() {
    String categoryIndex = new CategoryManager().indexOfCategory(_appCategory);
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        new Center(
          child: new Text(
            categoryIndex,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 10.0,
              color: Colors.white,
            ),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(
              left: 30.0, right: 30.0, top: 15.0, bottom: 15.0),
          child: new Text(
            _appCategory.title,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
              height: 1.3,
              fontSize: 30.0,
              color: Colors.white,
            ),
          ),
        ),
        new Container(
          height: 3.0,
          width: 35.0,
          color: Colors.white,
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: new Text(
            _appCategory.subtitle,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
              height: 1.3,
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    Image backIcon = new Image(
      image: new AssetImage("assets/icons/ic_back_arrow.png"),
      fit: BoxFit.cover,
    );
    return new Container(
      height: 256.0,
      child: new Material(
        color: new Color(0x00FFFFFF),
        child: new DecoratedBox(
          decoration: new BoxDecoration(),
          child: new Stack(
            children: [
              new Positioned.fill(
                child: new Container(color: _appCategory.centerShapeColor),
              ),
              new Positioned(
                right: -20.0,
                bottom: -10.0,
                child: new Image(
                  height: 300.0,
                  width: 300.0,
                  color: _appCategory.rightShapeColor,
                  image: new AssetImage("assets/images/section_cell_right.png"),
                  fit: BoxFit.cover,
                ),
              ),
              new Positioned(
                left: 0.0,
                bottom: -40.0,
                child: new Image(
                  height: 300.0,
                  width: 350.0,
                  color: _appCategory.leftShapeColor,
                  image: new AssetImage("assets/images/section_cell_left.png"),
                  fit: BoxFit.cover,
                ),
              ),
              new Positioned(
                top: 20.0,
                child: new Container(
                  height: 70.0,
                  width: 70.0,
                  child: new Material(
                    color: new Color(0x00FFFFFF),
                    child: new IconButton(
                      padding: EdgeInsets.zero,
                      icon: backIcon,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              new Center(
                child: new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: _appBarCategoryView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return new Expanded(
      child: new Container(
        color: new Color(0x00FFFFFF),
        child: new ListView(
          children: _cells,
        ),
      ),
    );
  }

  Widget _contentWidget() {
    return new Column(
      children: [
        _buildAppBar(),
        _buildListView(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: _appCategory.centerShapeColor,
      child: new Center(
        child: _contentWidget(),
      ),
    );
  }
}
