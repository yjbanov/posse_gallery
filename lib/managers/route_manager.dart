// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:posse_gallery/managers/category_manager.dart';
import 'package:posse_gallery/models/app_category.dart';
import 'package:posse_gallery/screens/category_screen.dart';
import 'package:posse_gallery/screens/item_screen.dart';
import 'package:posse_gallery/screens/main_screen.dart';
import 'package:posse_gallery/screens/search_screen.dart';

class RouteManager {
  RouteManager() {
    _routes = _routesMap;
    _categories = new CategoryManager().categories();
  }

  static Map<String, WidgetBuilder> _routes;
  static List<AppCategory> _categories;

  Map<String, WidgetBuilder> routes() {
    return _routes;
  }

  static AppCategory retrieveCategory(String routeName) {
    for (AppCategory category in _categories) {
      if (category.routeName == routeName) {
        return category;
      }
    }
    return null;
  }

  final Map<String, WidgetBuilder> _routesMap = {
    '/main': (BuildContext context) => new MainScreen(),
    '/search': (BuildContext context) => new SearchScreen(),
    '/category': (BuildContext context) => new CategoryScreen(),
    '/category/customized_design': (BuildContext context) =>
        new CategoryScreen(category: retrieveCategory("customized_design")),
    '/category/layout_positioning': (BuildContext context) =>
        new CategoryScreen(category: retrieveCategory("layout_positioning")),
    '/category/animation': (BuildContext context) =>
        new CategoryScreen(category: retrieveCategory("animation")),
    '/category/patterns': (BuildContext context) =>
        new CategoryScreen(category: retrieveCategory("patterns")),
    '/category/plug_ins': (BuildContext context) =>
        new CategoryScreen(category: retrieveCategory("plug_ins")),
    '/category/design_components': (BuildContext context) =>
        new CategoryScreen(category: retrieveCategory("design_components")),
    '/item': (BuildContext context) => new ItemScreen(),
  };
}
