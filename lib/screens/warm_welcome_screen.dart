// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class WarmWelcomeScreen extends StatefulWidget {
  @override
  _WarmWelcomeScreenState createState() => new _WarmWelcomeScreenState();
}

class _WarmWelcomeScreenState extends State<WarmWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: new Color(0xFFFFFFFF),
      child: new Center(
        child: new Text("Warm welcome goes here"),
      ),
    );
  }
}
