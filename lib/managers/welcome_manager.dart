// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:posse_gallery/models/welcome_step.dart';

class WelcomeManager {
  WelcomeManager() {
    _steps = _stepsList;
  }

  static List<WelcomeStep> _steps;

  List<WelcomeStep> steps() {
    return _steps;
  }

  final List<WelcomeStep> _stepsList = [
    new WelcomeStep(
      title: "Welcome to Flutter",
      subtitle:
          "Flutter is a mobile app SDK for building high-performance, high-fidelity, apps for iOS and Android.",
      imageUri: "assets/images/welcome_phones.png",
    ),
    new WelcomeStep(
      title: "Why use Flutter?",
      subtitle: "Be highly productive by doing more with less code.",
      imageUri: "assets/images/welcome_recipe.png",
    ),
    new WelcomeStep(
      title: "Everything's a Widget",
      subtitle: "Widgets are the basic building blocks of every Flutter app.",
      imageUri: "assets/images/welcome_widget_collection.png",
    ),
    new WelcomeStep(
      title: "Explore Flutter!",
      subtitle:
          "Now that you’re familiar with the basic structure and principles of the Flutter framework, explore what it can do.",
      imageUri: "assets/images/welcome_explore_flutter.png",
    ),
  ];
}
