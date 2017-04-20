// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:posse_gallery/models/checklist_item.dart';

class PatternsList extends StatefulWidget {
  @override
  _PatternsListState createState() => new _PatternsListState();
}

class _PatternsListState extends State<PatternsList> {
  final TextEditingController _controller = new TextEditingController();
  List<ChecklistItem> _demoData = [
    new ChecklistItem(title: "Drink a gallon of water", isSelected: false),
    new ChecklistItem(title: "Read a novel", isSelected: false),
    new ChecklistItem(title: "Learn a new language", isSelected: false),
    new ChecklistItem(title: "Visit a new place", isSelected: false),
  ];
  List<Widget> _cells;

  List<Widget> _loadItems() {
    List<Widget> cells = [];
    for (int i = 0; i < _demoData.length; i++) {
      final cellContainer = new Container(
        decoration: new BoxDecoration(
          border: new Border(
            bottom: new BorderSide(
              color: const Color(0xFFF4F4F4),
              width: 1.0,
            ),
          ),
        ),
        height: 60.0,
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Checkbox(
              value: _demoData[i].isSelected,
              onChanged: (bool value) {
                setState(() {
                  _demoData[i].isSelected = value;
                });
              },
            ),
            new Text(_demoData[i].title),
          ],
        ),
      );
      cells.add(cellContainer);
    }
    _cells = cells;
    return _cells;
  }

  Widget _buildInputField() {
    return new Container(
      color: const Color(0xFFF7F7F7),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          new IconButton(
            icon: new Icon(
              Icons.add,
              color: Colors.blue,
            ),
            onPressed: () {
              if (_controller.text.length > 0) {
                ChecklistItem item =
                new ChecklistItem(title: _controller.text, isSelected: false);
                setState(() {
                  _demoData.insert(0, item);
                  _controller.clear();
                });
              };
            },
          ),
          new Expanded(
            child: new TextField(
              controller: _controller,
              decoration: new InputDecoration(
                hintText: 'Add new goal',
                hideDivider: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return new Expanded(
      child: new ListView(
        children: _cells,
      ),
    );
  }

  Widget _contentWidget() {
    return new Column(
      children: [
        _buildInputField(),
        _buildListView(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _cells = _loadItems();
    return new Material(
      color: const Color(0xFFFFFFFF),
      child: _contentWidget(),
    );
  }
}
