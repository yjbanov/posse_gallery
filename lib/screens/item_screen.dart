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

class _ItemScreenState extends State<ItemScreen>
    with SingleTickerProviderStateMixin {
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

  Widget _contentWidget() {
    return new Column(
      children: [
        _buildAppBar("WIDGET"),
      ],
    );
  }

  Widget build(BuildContext context) {
    return new Material(
      color: const Color(0xFF19AAEE),
      child: _contentWidget(),
    );
  }
}
