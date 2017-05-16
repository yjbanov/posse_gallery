import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:posse_gallery/config/constants.dart';
import 'package:posse_gallery/managers/welcome_manager.dart';
import 'package:posse_gallery/models/welcome_step.dart';
import 'package:posse_gallery/screens/main_screen.dart';

class WarmWelcomeScreen2 extends StatefulWidget {
  @override
  _WarmWelcomeScreen2State createState() =>
      new _WarmWelcomeScreen2State();
}

class _WarmWelcomeScreen2State extends State<WarmWelcomeScreen2>
    with TickerProviderStateMixin {

  double panDelta = 200.0;

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: const Color(0xFFFFFFFF),
      child: new GestureDetector(

        onPanStart: (dragStartDetails) {
          print("Pan Start");
        },
        onPanUpdate: (dragUpdateDetails) {
          print("Pan Update");
          setState(() {
            panDelta += dragUpdateDetails.delta.dx;
            panDelta = panDelta.clamp(0.0, 200.0);
          });
          print(dragUpdateDetails.delta);
          print(dragUpdateDetails.globalPosition);
        },
        onPanDown: (dragDownDetails) {
          print("Pan Down");
        },
        onPanCancel: () {
          print("Pan Cancel");
        },
        onPanEnd: (dragEndDetails) {
          print("Pan End");
        },
        child: new Container(
          // todo (kg) - if i don't add this color, the gesture recognizer doesn't work unless I start on the square
          color: const Color(0x00000000),
          child: new Center(
            child: new Container(
              width: 200.0 * panDelta/200.0,
              height: 200.0 * panDelta/200.0,
              color: Colors.red.withOpacity(panDelta/200.0 * 1.0),
            ),
          ),
        ),
      ),
    );
  }

}