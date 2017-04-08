// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  _SearchScreenState() {
    _cells = _loadResults();
  }

  List<Widget> _cells = [];
  bool _isSearching = false;
  final TextEditingController _searchQuery = new TextEditingController();

  List<Widget> _loadResults() {
    List<Widget> resultCells = [];
    for (int i = 0; i < 12; i++) {
      final resultContainer = new Container(
        padding: new EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
        height: 64.0,
        child: new Text("Search Result",
            style: new TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18.0,
              color: Colors.white,
            )),
      );
      resultCells.add(resultContainer);
    }
    return resultCells;
  }

  Widget _appBarWidget() {
    Image closeIcon = new Image(
      image: new AssetImage("assets/icons/ic_close.png"),
      fit: BoxFit.cover,
    );
    return new Container(
      padding: const EdgeInsets.only(left: 10.0),
      height: 64.0,
      child: new Align(
        alignment: FractionalOffset.bottomLeft,
        child: new Container(
          child: new IconButton(
            padding: EdgeInsets.zero,
            icon: closeIcon,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }

  Widget _inputWidget() {
    return new Container(
      padding: const EdgeInsets.only(left: 25.0, right: 26.0),
      height: 64.0,
      child: new TextField(
        decoration: new InputDecoration(
          hintText: "Search Flutter",
          hintStyle: new TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 24.0,
            color: new Color(0x80FFFFFF),
          ),
        ),
        style: new TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 24.0,
          color: Colors.white,
        ),
        onChanged: (String newValue) {
          setState(() {
            print("Search: $newValue");
          });
        },
      ),
    );
  }

  Widget _resultsViewWidget() {
    return new Expanded(
      child: new Container(
        child: new Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 10.0),
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
        _appBarWidget(),
        _inputWidget(),
        _resultsViewWidget(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: new Color(0xFF43C2FD),
      child: new Center(
        child: _contentWidget(),
      ),
    );
  }
}
