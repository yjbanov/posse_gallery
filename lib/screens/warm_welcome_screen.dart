import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:posse_gallery/config/constants.dart';
import 'package:posse_gallery/managers/welcome_manager.dart';
import 'package:posse_gallery/screens/main_screen.dart';


class SecondaryWidgetHolder {

  SecondaryWidgetHolder({this.top, this.right, this.bottom, this.left,
    @required this.child});

  double top;
  double right;
  double bottom;
  double left;
  Widget child;
}

class WarmWelcomeScreen extends StatefulWidget {
  WarmWelcomeScreen({Key key, this.isInitialScreen = true}) : super(key: key);

  final bool
  isInitialScreen; // is the screen being displayed as a demo item or not?

  @override
  _WarmWelcomeScreenState createState() =>
      new _WarmWelcomeScreenState(isInitialScreen: isInitialScreen);
}

class _WarmWelcomeScreenState extends State<WarmWelcomeScreen>
    with TickerProviderStateMixin {
  _WarmWelcomeScreenState({this.isInitialScreen});

  static const int _kParallaxAnimationDuration = 400;
  bool isInitialScreen =
  true; // is the screen being displayed as a demo item or not?

  var _steps = new WelcomeManager().steps();
  TabController _tabController;
  int _currentPage = 0; // for page indicator
  double _bgOffset = 0.0;

  // animations
  List<AnimationController> _inAnimationControllers = <AnimationController>[];
  List<AnimationController> _outAnimationControllers = <AnimationController>[];
  Map<int, AnimationController> _secondaryAnimationControllers =
  <int, AnimationController>{};

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
    )
        .animate(outScaleAnimation);
    Animation<double> slideAnimation = new CurvedAnimation(
      parent: outAnimationController,
      curve: Curves.easeOut,
    );
    final outSlideTween = new Tween(
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 0.0),
    )
        .animate(slideAnimation);
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
    )
        .animate(inScaleAnimation);
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

  _contentWidget({Widget contentChild, String title, String subtitle,
    bool hasSecondary = false, int pageIndex}) {
    var contentStackChildren = <Widget>[];
    contentStackChildren.add(contentChild);
    if (hasSecondary) {
      contentStackChildren.addAll(_secondaryWidgets(pageIndex));
    }


    var stackChildren = <Widget>[
      new Positioned.fill(
        child: _buildBackgroundView(),
      ),
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
            child: new Container(
              width: 300.0, height: 300.0,
              child: new Stack(
                children: contentStackChildren,
              ),
            )
        ),
      ),
    ];


    return new Stack(
      children: stackChildren,
    );
  }

  _secondaryWidgets(int index) {
    var holders = <SecondaryWidgetHolder>[];
    var widgets = <Widget>[];

    if (index == 2) {
      AnimationController controller = new AnimationController(
        duration: new Duration(milliseconds: 750),
        vsync: this,
      );
      _secondaryAnimationControllers[index] = controller;


      var begins = <double>[0.0, 0.55, 0.25, 0.75];
      var ends = <double>[0.5, 1.0, 0.75, 1.0];
      var scaleAnimations = <int, Animation<double>>{};
      for (int a = 0; a < 4; a++) {
        Animation<double> scaleAnimation = new CurvedAnimation(
          parent: controller,
          curve: new Interval(begins[a], ends[a], curve: Curves.easeIn),
        );
        final scaleTween = new Tween(
          begin: 0.0,
          end: 1.0,
        ).animate(scaleAnimation);
        scaleAnimations[a] = scaleTween;
      }


      holders = <SecondaryWidgetHolder>[
        new SecondaryWidgetHolder(
          top: 40.0, left: 10.0,
          child: new ScaleTransition(
            scale: scaleAnimations[0],
            child: new Image(
              height: 40.0, image: new AssetImage(_steps[index].imageUris[1]),
            ),
          ),
        ),
        new SecondaryWidgetHolder(
          top: 100.0, right: 10.0,
          child: new ScaleTransition(
            scale: scaleAnimations[1],
            child: new Image(
              height: 35.0, image: new AssetImage(_steps[index].imageUris[2]),
            ),
          ),
        ),
        new SecondaryWidgetHolder(
          bottom: 75.0, left: 30.0,
          child: new ScaleTransition(
            scale: scaleAnimations[2],
            child: new Image(
              height: 35.0, image: new AssetImage(_steps[index].imageUris[3]),
            ),
          ),
        ),
        new SecondaryWidgetHolder(
          bottom: 15.0, left: 60.0,
          child: new ScaleTransition(
            scale: scaleAnimations[3],
            child: new Image(
              height: 50.0, image: new AssetImage(_steps[index].imageUris[4]),
            ),
          ),
        ),
      ];
    } else if (index == 3) {
      final widget1 = new Positioned(
        top: 35.0,
        left: 20.0,
        child: new Image(
            height: 35.0, image: new AssetImage(_steps[3].imageUris[1])),
      );
      final widget2 = new Positioned(
        top: 35.0,
        right: 25.0,
        child: new Image(
            height: 60.0, image: new AssetImage(_steps[3].imageUris[2])),
      );
      final widget3 = new Positioned(
        top: 135.0,
        right: 35.0,
        child: new Image(
            height: 35.0, image: new AssetImage(_steps[3].imageUris[3])),
      );
      final widget4 = new Positioned(
        bottom: 0.0,
        left: 18.0,
        child: new Image(image: new AssetImage(_steps[3].imageUris[4])),
      );
      final widget5 = new Positioned(
        bottom: 0.0,
        left: 15.0,
        child: new Image(image: new AssetImage(_steps[3].imageUris[5])),
      );
    }

    for (int i = 0; i < holders.length; i++) {
      SecondaryWidgetHolder holder = holders[i];
      widgets.add(new Positioned(
        top: holder.top,
        right: holder.right,
        bottom: holder.bottom,
        left: holder.left,
        child: holder.child,
      ));
    }

    return widgets;
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
      children.add(
        _contentWidget(
          contentChild: new Image(
            width: 280.0,
            height: 280.0,
            fit: BoxFit.fitHeight,
            image: new AssetImage(_steps[i].imageUris[0]),
          ),
          title: _steps[i].title,
          subtitle: _steps[i].subtitle,
          hasSecondary: i == 2 || i == 3,
          pageIndex: i,
        ),
      );
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
              var nextPage = (_currentPage + moveDelta)
                  .clamp(0, _inAnimationControllers.length - 1);
              _currentPage = nextPage;
              _tabController.animateTo(_currentPage);
            }
            final offset = (metrics.pixels - (page * screenWidth))
                .clamp(0, double.MAX_FINITE);
            _outAnimationControllers[page].value = (offset / screenWidth);
            if (page < (_inAnimationControllers.length - 1)) {
              _inAnimationControllers[page + 1].value = (offset / screenWidth);
            }
          } else if (notification is ScrollEndNotification) {
            // TODO - do pop pop animations
            var secondaryAnimationController = _secondaryAnimationControllers[_currentPage];
            if (secondaryAnimationController != null) {
              secondaryAnimationController.forward();
            }
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

  Widget _buildBackgroundView() {
    return new Stack(
      children: [
        new DecoratedBox(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                const Color(0xFFD7D7D7),
                const Color(0xFFFAFAFA),
                const Color(0xFFFFFFFF),
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              stops: [0.0, 0.35, 1.0],
            ),
          ),
        ),
        new AnimatedPositioned(
          top: 0.0,
          bottom: 0.0,
          left: _bgOffset,
          duration: new Duration(milliseconds: _kParallaxAnimationDuration),
          curve: const Interval(0.25, 1.0, curve: Curves.easeOut),
          child: new Image(
            height: MediaQuery
                .of(context)
                .size
                .height,
            image: new AssetImage("assets/backgrounds/bg_flutter_welcome.png"),
          ),
        ),
      ],
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
