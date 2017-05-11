// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:posse_gallery/models/checklist.dart';
import 'package:posse_gallery/models/checklist_item.dart';
import 'package:posse_gallery/models/category_item.dart';
import 'package:posse_gallery/screens/item_screen.dart';

class PatternsListDetail extends StatefulWidget {
  @override
  _PatternsListDetailState createState() => new _PatternsListDetailState();
}

class _PatternsListDetailState extends State<PatternsListDetail> {

  final TextEditingController _controller = new TextEditingController();

  Widget _contentWidget() {
    return new Column(
      children: [
        _buildInputField(),
//        _buildListView(),
      ],
    );
  }

  Widget _buildInputField() {
    return new Container(
      color: const Color(0xFFF7F7F7),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          new Material(
            child: new IconButton(
              icon: new Icon(
                Icons.add,
                color: const Color(0xFF54C5F8),
              ),
              onPressed: () {
                if (_controller.text.length > 0) {
                  ChecklistItem item = new ChecklistItem(
                      title: _controller.text, isSelected: false);
                  setState(() {
                    _controller.clear();
                  });
                }
              },
            ),
          ),
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: new TextField(
                controller: _controller,
                decoration: new InputDecoration(
                  hintText: 'Enter your note',
                  hideDivider: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: const Color(0xFFFFFFFF),
      child: _contentWidget(),
    );
  }

}