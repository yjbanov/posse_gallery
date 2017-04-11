// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
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
                    image: new AssetImage(item.iconUrl),
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
                  print("tapped cell");
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

  Widget _buildAppBar() {
    Image backIcon = new Image(
      image: new AssetImage("assets/icons/ic_back_arrow.png"),
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
              child: new IconButton(
                padding: EdgeInsets.zero,
                icon: backIcon,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            new Positioned(
              left: 52.0,
              top: 35.0,
              child: new Text(
                "",
                style: new TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                  color: new Color(0xFF29B6F6),
                ),
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
          padding: const EdgeInsets.only(top: 10.0),
          child: new ListView(
            children: _cells,
          ),
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
      color: Colors.white,
      child: new Center(
        child: _contentWidget(),
      ),
    );
  }
}
