// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:posse_gallery/config/constants.dart';
import 'package:posse_gallery/models/category_item.dart';

class ItemScreen extends StatefulWidget {
  ItemScreen({this.item});

  final CategoryItem item;

  @override
  _ItemScreenState createState() => new _ItemScreenState(item: item);
}

class _ItemScreenState extends State<ItemScreen> with TickerProviderStateMixin {
  _ItemScreenState({this.item});

  final CategoryItem item;

  Widget _buildAppBar(String title) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    final topWidgets = <Widget>[
      new Positioned(
          top: 0.0, left: 0.0, right: 0.0,
          child: new Container(
            height: 4.0,
            color: new Color(0x11000000),
          )
      ),
      new Positioned(
        top: 0.0, bottom: 0.0, left: 5.0,
        child: new IconButton(
          icon: new Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      new Positioned.fill(
        left: 60.0, right: 60.0,
        child: new Center(
          child: new Text(
            title,
            style: new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ];
    if (item.showMoreButton) {
      topWidgets.add(
        new Positioned(
          right: 5.0, top: 0.0, bottom: 0.0,
          child: new IconButton(
            icon: new Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ),
      );
    }

    return new Padding(
      padding: new EdgeInsets.only(top: statusBarHeight),
      child: new ConstrainedBox(
        constraints: new BoxConstraints.expand(height: Constants.TopSectionHeight),
        child: new Stack(
          children: topWidgets,
        ),
      ),
    );
  }

  Widget _buildItemContent() {
    return new Expanded(
      child: new Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(3.0),
          color: Colors.white,
        ),
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        child: new ClipRRect(
          borderRadius: new BorderRadius.circular(3.0),
          child: item.widget,
        ),
      ),
    );
  }

  Widget _contentWidget() {
    return new Column(
      children: [
        _buildAppBar(item.title),
        _buildItemContent(),
      ],
    );
  }

  Widget build(BuildContext context) {
    Color color = item.color != Colors.white ? item.color : const Color(0xFF54C5F8);
    return new Material(
      color: color,
      child: _contentWidget(),
    );
  }
}
