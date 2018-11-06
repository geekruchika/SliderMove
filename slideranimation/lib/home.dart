import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:slideranimation/banner.dart';
import 'package:slideranimation/sliderAnimation.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Animation<double> opacity;
  AnimationController _tickController;
  double distance = 70.0;
  String text = "UnderWeight";
  double drag = 0;
  Offset dragStart;
  double slidePercent = 0.0;
  int bannerText = 0;
  static const FULL_TRANSITION_PX = 300.0;
  bool showBanner = false;
  @override
  void initState() {
    super.initState();
    _tickController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    opacity = new Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      new CurvedAnimation(
        parent: _tickController,
        curve: Curves.bounceOut,
      ),
    );
    opacity.addListener(() {
      setState(() {
        // if (_tickController.isCompleted) _tickController.reverse();
      });
    });
    _tickController.forward();
  }

  textVal(newValue) {
    print(newValue);
    setState(() {
      if (newValue > 0.0 && newValue < 50.0) text = "UnderWeight";
      if (newValue >= 50.0 && newValue <= 80.0) text = "Balanced";
      if (newValue > 80.0) text = "OverWeight";
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    timeDilation = 2.0;
    return new Scaffold(
      // appBar: new AppBar(),
      body: new Container(
        width: screenSize.width,
        height: screenSize.height,
        padding: new EdgeInsets.all(40.0),
        color: Color.fromRGBO(255, 255, 255, 1),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Icon(Icons.arrow_back),
            new Container(
              height: screenSize.height / 3 - 40 * opacity.value,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        "What is your",
                        style: new TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      new Padding(
                        padding: new EdgeInsets.only(top: 5),
                      ),
                      new Text(
                        "weight goal?",
                        style: new TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      new Padding(
                        padding: new EdgeInsets.only(top: 15),
                      ),
                      new Text(
                        text,
                        style: new TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(160, 160, 160, 1),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
                ],
              ),
            ),
            new Container(
              height: screenSize.height / 2 - 40,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    height: screenSize.height / 3.8,
                    child: new Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        // new Container(height: 30,width: 100,decoration: new BoxDecoration(
                        //   borderRadius: new BorderRadius.
                        // ),),
                        new SlideAnimation(
                          onValue: textVal,
                        ),
                        // new Container(
                        //   height: 3,
                        //   margin: new EdgeInsets.only(bottom: 5),
                        //   color: Color.fromRGBO(160, 160, 160, 1),
                        // ),
                        // new Positioned(
                        //     bottom: 90,
                        //     left: drag,
                        //     child: new Container(
                        //         padding: new EdgeInsets.only(
                        //             top: 10.0,
                        //             bottom: 10.0,
                        //             left: 15.0,
                        //             right: 15.0),
                        //         margin: new EdgeInsets.only(bottom: 5),
                        //         decoration: new BoxDecoration(
                        //             color: !showBanner
                        //                 ? Color.fromRGBO(255, 255, 255, 1)
                        //                 : Color.fromRGBO(0, 0, 0, 1),
                        //             borderRadius: new BorderRadius.all(
                        //                 new Radius.circular(4.0))),
                        //         child: new Row(
                        //           children: <Widget>[
                        //             new Text(
                        //               bannerText.toString(),
                        //               style: new TextStyle(
                        //                   fontSize: 25,
                        //                   color: showBanner
                        //                       ? Color.fromRGBO(255, 255, 255, 1)
                        //                       : Color.fromRGBO(0, 0, 0, 1)),
                        //             ),
                        //             new Text(
                        //               " kg",
                        //               style: new TextStyle(color: Colors.grey),
                        //             ),
                        //           ],
                        //         ))),
                        // new Positioned(
                        //   top: 90,
                        //   left: drag,
                        //   child: new GestureDetector(
                        //     onHorizontalDragStart: (DragStartDetails details) {
                        //       dragStart = details.globalPosition;
                        //       setState(() {
                        //         showBanner = true;
                        //       });
                        //     },
                        //     onHorizontalDragEnd: (DragEndDetails detail) {
                        //       //  print(detail);
                        //       setState(() {
                        //         showBanner = false;
                        //       });
                        //     },
                        //     onHorizontalDragUpdate: (DragUpdateDetails detail) {
                        //       //  print(detail);
                        //       var newPosition = detail.globalPosition.dx;
                        //       setState(() {
                        //         drag = newPosition - 40;
                        //         slidePercent = (drag / FULL_TRANSITION_PX)
                        //             .abs()
                        //             .clamp(0.0, 1.0);

                        //         var newValue = 160 * slidePercent;
                        //         bannerText = newValue.floor();
                        //         if (newValue > 40.0 && newValue < 60.0)
                        //           text = "UnderWeight";
                        //         if (newValue >= 60.0 && newValue <= 80.0)
                        //           text = "Balanced";
                        //         if (newValue > 80.0)
                        //           setState(() {
                        //             text = "OverWeight";
                        //           });
                        //       });
                        //       print(slidePercent);
                        //     },
                        //     child: new Container(
                        //       height: 15,
                        //       width: 15,
                        //       decoration: new BoxDecoration(
                        //           shape: BoxShape.circle, color: Colors.black),
                        //     ),
                        //   ),
                        // ),
                        // new Slider(r
                        //   activeColor: Colors.black,
                        //   inactiveColor: Colors.transparent,
                        //   max: 120.0,
                        //   min: 40.0,
                        //   value: distance,
                        //   onChangeStart: (double val) {
                        //     print("in");
                        //   },
                        //   onChangeEnd: (double val) {
                        //     print("out");
                        //   },
                        //   onChanged: (double newValue) {
                        //     setState(() {
                        //       distance = newValue;

                        //       if (newValue > 40.0 && newValue < 60.0)
                        //         text = "UnderWeight";
                        //       if (newValue >= 60.0 && newValue <= 80.0)
                        //         text = "Balanced";
                        //       if (newValue > 80.0)
                        //         setState(() {
                        //           text = "OverWeight";
                        //         });
                        //     });
                        //   },
                        // ),
                        new Positioned(
                          top: 150,
                          width: screenSize.width - 80,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[new Text("0"), new Text("120")],
                          ),
                        )
                      ],
                    ),
                  ),
                  new FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(new PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new BannerScreen(),
                        ));
                      },
                      child: new Container(
                        width: 150,
                        padding: new EdgeInsets.all(15.0),
                        decoration: new BoxDecoration(
                            color: Color.fromRGBO(239, 240, 241, 1),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(4.0))),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text("Continue"),
                            new Hero(
                              tag: "icon",
                              child: new Icon(Icons.arrow_forward),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
        // child: new Column(
        //   // mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     new Container(
        //       //   height: screenSize.height / 2,
        //       child: new Text(
        //         'You have pushed the button this many times:',
        //       ),
        //     ),
        //     new Container(
        //       // height: screenSize.height / 2,
        //       child: new Text(
        //         'You have pushed the button this many times:',
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
