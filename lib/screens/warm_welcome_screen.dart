import 'package:flutter/material.dart';
import 'package:posse_gallery/config/constants.dart';
import 'package:posse_gallery/managers/welcome_manager.dart';
import 'package:posse_gallery/screens/main_screen.dart';

class WarmWelcomeScreen extends StatefulWidget {
  WarmWelcomeScreen({Key key, this.isInitialScreen = true}) : super(key: key);

  final bool isInitialScreen;  // is the screen being displayed as a demo item or not?

  @override
  _WarmWelcomeScreenState createState() => new _WarmWelcomeScreenState(
      isInitialScreen: isInitialScreen);
}

class _WarmWelcomeScreenState extends State<WarmWelcomeScreen> with TickerProviderStateMixin {

  _WarmWelcomeScreenState({this.isInitialScreen});

  bool isInitialScreen = true;  // is the screen being displayed as a demo item or not?

  var _steps = new WelcomeManager().steps();
  TabController _tabController;
  int _currentPage = 0; // for page indicator

  // animations
  List<AnimationController> _inAnimationControllers = <AnimationController>[];
  List<AnimationController> _outAnimationControllers = <AnimationController>[];

  _makeAnimatedContentWidget({Widget child}) {
    // out animation
    final outAnimationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    Animation<double> outScaleAnimation = new CurvedAnimation(
      parent: outAnimationController,
      curve: Curves.easeOut,
    );
    final outScaleTween = new Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(outScaleAnimation);
    Animation<double> slideAnimation = new CurvedAnimation(
      parent: outAnimationController,
      curve: Curves.easeOut,
    );
    final outSlideTween = new Tween(
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 0.0),
    ).animate(slideAnimation);
    _outAnimationControllers.add(outAnimationController);

    // in animation
    final inAnimationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    Animation<double> inScaleAnimation = new CurvedAnimation(
      parent: inAnimationController,
      curve: Curves.linear,
    );
    final inScaleTween = new Tween(
      begin: 0.6,
      end: 1.0,
    ).animate(inScaleAnimation);
    _inAnimationControllers.add(inAnimationController);

    // widgets
    var outAnimationWrapper = new SlideTransition(
      position: outSlideTween,
      child: new ScaleTransition(
        scale: outScaleTween,
        child: child,
      ),
    );
    var inAnimationWrapper = new ScaleTransition(
      scale: inScaleTween,
      child: outAnimationWrapper,
    );
    return inAnimationWrapper;
  }

  _contentWidget({Widget contentChild, String title, String subtitle}) {
    return new Stack(
      children: <Widget>[
        new Positioned.fill(
          top: 65.0,
          child: new Padding(
            padding: new EdgeInsets.only(left: 60.0, right: 60.0),
            child: new Column(
              children: <Widget>[
                new Text(
                  title,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 22.0,
                    color: const Color(Constants.ColorPrimary),
                    letterSpacing: 0.25,
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(subtitle, textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ),
        new Center(
          child: _makeAnimatedContentWidget(
            child: contentChild,
          ),
        ),
      ],
    );
  }

  _pageIndicator() {
    _tabController = new TabController(initialIndex: 0, length: 4, vsync: this);
    return new TabPageSelector(controller: _tabController);
  }

  _continueButton() {
    return new Container(
      width: 200.0,
      height: 54.0,
      child: new RaisedButton(
        color: const Color(Constants.ColorPrimary),
        child: new Text(
          "START EXPLORING",
          style: new TextStyle(
            color: const Color(0xFFFFFFFF),
            fontSize: 12.0,
          ),
        ),
        onPressed: _tappedContinue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (int i = 0; i < _steps.length; i++) {
      children.add(_contentWidget(
        contentChild: new Image(
          width: 280.0,
          height: 280.0,
          fit: BoxFit.fitHeight,
          image: new AssetImage(_steps[i].imageUris[0]),
        ),
        title: _steps[i].title,
        subtitle: _steps[i].subtitle,
      ));
    }

    int moveDelta = 0;
    double startPixels = 0.0;
    bool updatePage = true;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    _inAnimationControllers[0].value = 1.0;

    return new Material(
      color: new Color(0xFFFFFFFF),
      child: new NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollStartNotification) {
            final PageMetrics metrics = notification.metrics;
            moveDelta = 0;
            startPixels = metrics.pixels;
            updatePage = true;
          } else if (notification is ScrollUpdateNotification) {
            final PageMetrics metrics = notification.metrics;
            final int page = (metrics.pixels / screenWidth).floor();
            if (updatePage) {
              moveDelta = (metrics.pixels > startPixels ? 1 : -1);
              updatePage = false;
              var nextPage = (_currentPage + moveDelta).clamp(0, _inAnimationControllers.length - 1);
              _currentPage = nextPage;
              _tabController.animateTo(_currentPage);
            }
            final offset = (metrics.pixels - (page * screenWidth)).clamp(0, double.MAX_FINITE);
            _outAnimationControllers[page].value = (offset / screenWidth);
            if (page < (_inAnimationControllers.length - 1)) {
              _inAnimationControllers[page + 1].value = (offset / screenWidth);
            }


          } else if (notification is ScrollEndNotification) {
            // TODO - do pop pop animations
            final PageMetrics metrics = notification.metrics;

          }
          return false;
        },
        child: new Stack(
          children: <Widget>[
            new Positioned.fill(
              child: new PageView(
                children: children,
              ),
            ),
            new Align(
              alignment: FractionalOffset.bottomCenter,
              child: new Padding(
                padding: new EdgeInsets.only(bottom: 45.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.only(bottom: 20.0),
                      child: _pageIndicator(),
                    ),
                    _continueButton()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // actions
  void _tappedContinue() {
    if (isInitialScreen) {
      Navigator.pushReplacement(
        context,
        new PageRouteBuilder<Null>(
          settings: const RouteSettings(name: "/main"),
          pageBuilder: (BuildContext context, Animation<double> _,
              Animation<double> __) {
            return new MainScreen();
          },
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

}