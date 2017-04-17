// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:posse_gallery/models/app_category.dart';
import 'package:posse_gallery/models/category_item.dart';

class CategoryManager {
  CategoryManager() {
    _categories = _categoryList;
  }

  static List<AppCategory> _categories;

  List<AppCategory> categories() {
    return _categories;
  }

  String indexOfCategory(AppCategory category) {
    for (int i = 0; i < _categories.length; i++) {
      AppCategory tempCategory = _categories[i];
      if (tempCategory.title == category.title) {
        int adjustedIndex = i + 1;
        return adjustedIndex.toString().padLeft(2, '0');
      }
    }
    return "";
  }

  final List<AppCategory> _categoryList = [
    new AppCategory(
      routeName: "customized_design",
      title: "CUSTOMIZED DESIGN",
      subtitle: "BRAND FIRST EXPERIENCES",
      leftShapeColor: const Color(0xFF19AAEE),
      centerShapeColor: const Color(0xFF00A2EE),
      rightShapeColor: const Color(0xFF1AA3E4),
      categoryColors: [
        const Color(0xFF30BDFF),
        const Color(0xFF009FEA),
        const Color(0xFF0084EA),
        Colors.white,
      ],
      categoryItems: [
        new CategoryItem(
            title: "CUSTOMIZED BRAND DESIGN",
            iconUri: "assets/icons/ic_customized_brand_design.png"),
        new CategoryItem(
            title: "ASSETS & THEMES",
            iconUri: "assets/icons/ic_customized_assets.png"),
        new CategoryItem(
            title: "PAINTING",
            iconUri: "assets/icons/ic_customized_painting.png"),
        new CategoryItem(
            title: "COMPONENTS", iconUri: "assets/icons/ic_components.png"),
      ],
    ),
    new AppCategory(
      routeName: "layout_positioning",
      title: "LAYOUT & POSITIONING",
      subtitle: "EASY TO COMPOSE",
      leftShapeColor: const Color(0xFF5BDBFF),
      centerShapeColor: const Color(0xFF45D2F9),
      rightShapeColor: const Color(0xFF53D2F7),
      categoryColors: [
        const Color(0xFF00BBFF),
        const Color(0xFF0086FF),
        const Color(0xFF382DFF),
        Colors.white,
      ],
      categoryItems: [
        new CategoryItem(
            title: "FLEX", iconUri: "assets/icons/ic_layout_flex.png"),
        new CategoryItem(
            title: "STACK", iconUri: "assets/icons/ic_layout_stack.png"),
        new CategoryItem(
            title: "SCROLL", iconUri: "assets/icons/ic_layout_scroll.png"),
        new CategoryItem(
            title: "COMPONENTS", iconUri: "assets/icons/ic_components.png"),
      ],
    ),
    new AppCategory(
      routeName: "animation",
      title: "ANIMATION & UI MOTION",
      subtitle: "MADE FOR MOTION",
      leftShapeColor: const Color(0xFF38D3CD),
      centerShapeColor: const Color(0xFF25C3BC),
      rightShapeColor: const Color(0xFF3BBCB7),
      categoryColors: [
        const Color(0xFF05BBC0),
        const Color(0xFF00A3A8),
        const Color(0xFF02898D),
        Colors.white,
      ],
      categoryItems: [
        new CategoryItem(
            title: "TWEENS", iconUri: "assets/icons/ic_animation_tweens.png"),
        new CategoryItem(
            title: "CHAINS/FRAME",
            iconUri: "assets/icons/ic_animation_chains.png"),
        new CategoryItem(
            title: "GESTURES",
            iconUri: "assets/icons/ic_animation_gestures.png"),
        new CategoryItem(
            title: "COMPONENTS", iconUri: "assets/icons/ic_components.png"),
      ],
    ),
    new AppCategory(
      routeName: "patterns",
      title: "UI PATTERNS",
      subtitle: "NATURAL AND PRODUCTIVE",
      leftShapeColor: const Color(0xFFF9B640),
      centerShapeColor: const Color(0xFFFFAC18),
      rightShapeColor: const Color(0xFFFFB02C),
      categoryColors: [
        const Color(0xFFFF8B00),
        const Color(0xFFFF6600),
        const Color(0xFFFF4A2D),
      ],
      categoryItems: [
        new CategoryItem(
            title: "MAKE A LIST", iconUri: "assets/icons/ic_patterns_list.png"),
        new CategoryItem(
            title: "WALKTHROUGH",
            iconUri: "assets/icons/ic_patterns_walkthrough.png"),
        new CategoryItem(
            title: "EDIT AN IMAGE",
            iconUri: "assets/icons/ic_pattern_edit_image.png"),
      ],
    ),
    new AppCategory(
      routeName: "plug_ins",
      title: "PLUG INS",
      subtitle: "UNIFIED BUILDING BLOCKS",
      leftShapeColor: const Color(0xFFFD734E),
      centerShapeColor: const Color(0xFFFF6941),
      rightShapeColor: const Color(0xFFFA724E),
      categoryColors: [
        const Color(0xFFFE5224),
        const Color(0xFFF13300),
        const Color(0xFFDE0202),
        const Color(0xFFBA0000),
      ],
      categoryItems: [
        new CategoryItem(
            title: "TAKE A PHOTO",
            iconUri: "assets/icons/ic_plug_in_photo.png"),
        new CategoryItem(
            title: "CURRENT LOCATION",
            iconUri: "assets/icons/ic_plug_in_location.png"),
        new CategoryItem(
            title: "DEVICE MOTION",
            iconUri: "assets/icons/ic_plug_in_motion.png"),
        new CategoryItem(
            title: "CUSTOM SERVICE PLUG-INS",
            iconUri: "assets/icons/ic_plug_in_service.png"),
      ],
    ),
    new AppCategory(
      routeName: "design_components",
      title: "DESIGN COMPONENTS",
      subtitle: "HIGH FIDELITY TOOLKIT",
      leftShapeColor: const Color(0xFFAFD84C),
      centerShapeColor: const Color(0xFFA1CB39),
      rightShapeColor: const Color(0xFFA3CA4B),
      categoryColors: [
        const Color(0xFF8ABC10),
        const Color(0xFF6AAD10),
      ],
      categoryItems: [
        new CategoryItem(
            title: "IOS CONTROLS",
            iconUri: "assets/icons/ic_design_components_controls.png"),
        new CategoryItem(
            title: "MATERIAL CONTROLS",
            iconUri: "assets/icons/ic_design_components_material.png"),
      ],
    ),
  ];
}
