// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
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
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return new Container(
      height: 76.0,
      padding: new EdgeInsets.only(left: 8.0, top: statusBarHeight, right: 8.0),
      child: new Center(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new IconButton(
              icon: new Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new Expanded(
              child: new Text(
                title,
                style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            new IconButton(
              icon: new Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: null,
            ),
          ],
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
