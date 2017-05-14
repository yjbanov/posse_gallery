import 'package:flutter/material.dart';

class DebugOptionsScreen extends StatelessWidget {

  Widget _debugToggleRow(String text, ValueChanged<bool> onToggled) {
    return new ConstrainedBox(
      constraints: new BoxConstraints.expand(height: 60.0),
      child: new Row(
        children: [
          new Checkbox(value: false, onChanged: onToggled),
          new Padding(
            padding: new EdgeInsets.only(left: 12.0),
            child: new Text(text),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Column(
        children: <Widget>[
          new AppBar(),
          new ListView(
            children: [
              _debugToggleRow("Show performance overlay.", null),
              _debugToggleRow("Show checkerboarding of raster cache images.", null),
            ],
          ),
        ],
      )
    );
  }
}