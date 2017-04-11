// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/painting.dart';
import 'package:posse_gallery/models/section_feature.dart';

class AppSection {
  AppSection(
      {this.title,
      this.subtitle,
      this.leftShapeColor,
      this.centerShapeColor,
      this.rightShapeColor,
      this.sectionColors,
      this.sectionFeatures});

  final String title;
  final String subtitle;
  final Color leftShapeColor;
  final Color centerShapeColor;
  final Color rightShapeColor;
  final List<Color> sectionColors;
  final List<SectionFeature> sectionFeatures;
}
