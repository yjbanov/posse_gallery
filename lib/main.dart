// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:posse_gallery/config/app_settings.dart';
import 'package:posse_gallery/config/application.dart';
import 'package:posse_gallery/config/constants.dart';
import 'package:posse_gallery/managers/route_manager.dart';
import 'package:posse_gallery/screens/main_screen.dart';
import 'package:posse_gallery/screens/warm_welcome_screen.dart';

void main() {
  runApp(new GalleryApp());
}

class GalleryApp extends StatefulWidget {
  @override
  _GalleryAppState createState() => new _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {
  Widget mainWidget;

  _GalleryAppState() {
    mainWidget = loadingWidget();
    configureApp().then((Widget configuredWidget) {
      setState(() {
        mainWidget = configuredWidget;
      });
    });
  }

  Widget loadingWidget() {
    return new Material();
  }

  Future<Widget> configureApp() async {
    // ready the global app settings reference
    Application.settings = await new PersistedAppSettings().load();
    return configureUI();
  }

  Widget configureUI() {
    bool hasSeenWelcome = Application.settings
        .boolValue(Constants.ConfigKeySeenWelcome, defaultValue: false);
    Widget launchScreen =
        !hasSeenWelcome ? new WarmWelcomeScreen() : new MainScreen();
    return new MaterialApp(
      title: 'Flutter Gallery',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: launchScreen,
      routes: new RouteManager().routes(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return mainWidget;
  }
}
