import 'package:flutter/material.dart';
import 'package:posse_gallery/models/app_section.dart';
import 'package:posse_gallery/models/section_feature.dart';

class SectionScreen extends StatefulWidget {
  SectionScreen({
    AppSection appSection,
  })
      : _appSection = appSection;

  final AppSection _appSection;

  @override
  _SectionScreenState createState() =>
      new _SectionScreenState(appSection: _appSection);
}

class _SectionScreenState extends State<SectionScreen>
    with SingleTickerProviderStateMixin {
  _SectionScreenState({
    AppSection appSection,
  })
      : _appSection = new AppSection(
          title: "CUSTOMIZED DESIGN",
          subtitle: "BRAND FIRST EXPERIENCES",
          leftShapeColor: new Color(0xFF19AAEE),
          centerShapeColor: new Color(0xFF00A2EE),
          rightShapeColor: new Color(0xFF1AA3E4),
          sectionColors: [
            new Color(0xFF19AAEE),
            new Color(0x009FEA),
            new Color(0x0084EA),
            Colors.white
          ],
          sectionFeatures: [
            new SectionFeature(
                title: "CUSTOMIZED BRAND DESIGN", iconUrl: "a.png"),
            new SectionFeature(title: "ASSETS & THEMES", iconUrl: "a.png"),
            new SectionFeature(title: "PAINTING", iconUrl: "a.png"),
            new SectionFeature(title: "COMPONENTS", iconUrl: "a.png"),
          ],
        );

  AppSection _appSection;
  List<Widget> _cells;

  @override
  void initState() {
    super.initState();
    setState(() {
      _cells = _loadFeatures();
    });
  }

  List<Widget> _loadFeatures() {
    List<Widget> cells = [];
    for (SectionFeature feature in _appSection.sectionFeatures) {
      final cellContainer = new Container(
        color: Colors.blue,
        height: 163.0,
        child: new Stack(
          children: [
            new Positioned(
              left: 12.0,
              top: 32.0,
              child: new Image(
                image: new AssetImage("assets/icons/ic_back_arrow.png"),
                fit: BoxFit.cover,
              ),
            ),
            new Positioned(
              right: 12.0,
              top: 32.0,
              child: new Text("FEATURE TITLE"),
            ),
          ],
        ),
      );
      cells.add(cellContainer);
    }
    return cells;
  }

  Widget _appBarWidget() {
    Image searchIcon = new Image(
      image: new AssetImage("assets/icons/ic_search.png"),
      fit: BoxFit.cover,
    );
    return new Container(
      height: 64.0,
      child: new DecoratedBox(
        decoration: new BoxDecoration(),
        child: new Stack(
          children: [
            new Positioned(
              left: 12.0,
              top: 32.0,
              child: new Image(
                image: new AssetImage("assets/icons/ic_flutter_logo.png"),
                fit: BoxFit.cover,
              ),
            ),
            new Positioned(
              left: 52.0,
              top: 35.0,
              child: new Text(
                "Flutter Gallery",
                style: new TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                  color: new Color(0xFF29B6F6),
                ),
              ),
            ),
            new Positioned(
              right: 0.0,
              top: 23.0,
              child: new IconButton(
                padding: EdgeInsets.zero,
                icon: searchIcon,
                onPressed: () {
                  Navigator.of(context).pushNamed('/search');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contentWidget() {
    return new Stack(
      children: [
        new Positioned(
          child: new Column(
            children: [
              _appBarWidget(),
              new Expanded(
                child: new Container(
                  color: new Color(0x00FFFFFF),
                  child: new Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: new ListView(
                      children: _cells,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: new Center(
        child: _contentWidget(),
      ),
    );
  }
}
