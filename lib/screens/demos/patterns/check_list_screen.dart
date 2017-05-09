// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:posse_gallery/models/checklist.dart';
import 'package:posse_gallery/models/checklist_item.dart';

class PatternsList extends StatefulWidget {
  @override
  _PatternsListState createState() => new _PatternsListState();
}

class _PatternsListState extends State<PatternsList>
    with TickerProviderStateMixin {
  final TextEditingController _controller = new TextEditingController();

  final Checklist _checklist = new Checklist(
    items: [
      new ChecklistItem(title: "Drink a gallon of water", isSelected: false),
      new ChecklistItem(title: "Read a novel", isSelected: false),
      new ChecklistItem(title: "Learn a new language", isSelected: false),
      new ChecklistItem(title: "Visit a new place", isSelected: false),
    ]
  );
  List<Widget> _cells;
  Animation<double> _cellSizeInAnimation;
  AnimationController _animateInController;

  static const int _kAnimateInDuration = 700;

  _PatternsListState() {
    _configureAnimation();
  }

  void _configureAnimation() {
    _animateInController = new AnimationController(
      duration: const Duration(milliseconds: _kAnimateInDuration),
      vsync: this,
    );
    _cellSizeInAnimation = _initAnimation(
        from: 0.0,
        to: 1.0,
        curve: Curves.easeIn,
        controller: _animateInController);
  }

  Animation<double> _initAnimation(
      {double from, double to, Curve curve, AnimationController controller}) {
    final CurvedAnimation animation = new CurvedAnimation(
      parent: controller,
      curve: curve,
    );
    return new Tween<double>(begin: from, end: to).animate(animation);
  }

  List<Widget> _loadItems() {
    List<Widget> cells = [];
    for (int i = 0; i < _checklist.items().length; i++) {
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
        child: new Stack(
          children: [
            new Positioned(
              left: 0.0,
              top: 0.0,
              right: 10.0,
              bottom: 0.0,
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Checkbox(
                    value: _checklist[i].isSelected,
                    onChanged: (bool value) {
                      setState(() {
                        _checklist[i].isSelected = value;
                      });
                    },
                  ),
                  new Expanded(
                    child: new Text(
                      _checklist[i].title,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            new Material(
              color: const Color(0x00FFFFFF),
              child: new InkWell(
                highlightColor: Colors.grey.withAlpha(30),
                splashColor: Colors.grey.withAlpha(20),
                onTap: (() {
                  print("tapped");
                }),
              ),
            ),
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
                    _checklist.addItem(item, index: 0);
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
