// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class CustomizedDesign extends StatefulWidget {
  @override
  _CustomizedDesignState createState() => new _CustomizedDesignState();
}

class _CustomizedDesignState extends State<CustomizedDesign> {
  Widget _buildAppBar() {
    return new Container(
      height: 56.0,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new IconButton(
            icon: new Icon(Icons.menu, color: Colors.black38),
            onPressed: null,
          ),
          new Expanded(
            child: new Text(
              "MY RECIPE BOOK",
              style: new TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w700,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          new IconButton(
            icon: new Icon(
              Icons.search,
              color: Colors.black38,
            ),
            onPressed: null,
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return new Expanded(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Stack(
            children: [
              new Positioned(
                child: new Image(
                  image: new AssetImage("assets/images/brand_product.png"),
                ),
              ),
              new Positioned(
                bottom: 0.0,
                child: new Image(
                  image: new AssetImage("assets/images/brand_profile.png"),
                ),
              ),
            ],
          ),
          new Text("Classic Apple Pie",
              style: new TextStyle(
                color: const Color(0xFF62AF30),
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              )),
          new Text("By Jenny Flay",
              style: new TextStyle(
                color: const Color(0xFFC7C7C7),
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
              )),
          new Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: new Center(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Column(
                    children: [
                      new Text(
                        "120",
                        style: new TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFF4A4A4A),
                        ),
                      ),
                      new Text(
                        "Mins",
                        style: new TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFF4A4A4A),
                        ),
                      )
                    ],
                  ),
                  new Image(
                    image: new AssetImage("assets/images/brand_stars.png"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return new Container(
      height: 76.0,
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
      child: new Row(
        children: [
          new Expanded(
            child: new FlatButton(
              color: const Color(0xFF5FAD2C),
              child: new Text(
                "View Recipe",
                style: new TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentWidget() {
    return new Column(
      children: [
        _buildAppBar(),
        _buildBody(),
        _buildBottomButton(),
      ],
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
