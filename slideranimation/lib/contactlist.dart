import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class ContactScreen extends StatefulWidget {
  ContactScreen({
    Key key,
  }) : super(key: key);

  @override
  _ContactScreenState createState() => new _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with TickerProviderStateMixin {
  ScrollController controller;
  AnimationController _loaderController;
  Animation<double> dimension;
  Animation<double> opacity;
  AnimationController _tickController;
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
    _loaderController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);
    controller =
        new ScrollController(initialScrollOffset: 10.0, keepScrollOffset: true);
    controller.addListener(() {
      print(controller.offset);
      if (controller.offset == 0.0) {
        // print(controller.offset);
        _loaderController.forward();
      }
    });
    dimension = new Tween<double>(
      begin: 0.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(
        parent: _loaderController,
        curve: Curves.bounceOut,
      ),
    );
    dimension.addListener(() {
      setState(() {
        if (_loaderController.isCompleted) _loaderController.reverse();
      });
    });
  }

  @override
  void dispose() {
    _loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // timeDilation = 0.5;

    Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
        body: new ListView(
      shrinkWrap: true,
      controller: controller,
      children: <Widget>[
        new Opacity(
            opacity: opacity.value,
            child: new Container(
                color: Color.fromRGBO(255, 255, 255, 1),
                padding: new EdgeInsets.all(15.0 * opacity.value),
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                          //  color: Colors.black,
                          height: 80 + dimension.value,
                          child: new Opacity(
                            opacity: _loaderController.value,
                            child: new Container(
                              width: dimension.value / 4,
                              height: dimension.value / 4,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black),
                            ),
                          )),
                      new Container(
                        width: screenSize.width - 30,
                        padding: new EdgeInsets.all(30.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Padding(
                              padding: new EdgeInsets.only(
                                  bottom: 10 * opacity.value),
                              child: new Text(
                                "Hello Laura,",
                                style: new TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            new Text(
                              "you have 2 new \nimportant emails today",
                              style: new TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      new List(),
                      new List(),
                      new List(),
                      new List(),
                      new List()
                    ])))
      ],
    ));
  }
}

class List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.symmetric(vertical: 20),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(right: 10),
            child: new Image(
              width: 20,
              height: 20,
              image: new NetworkImage(
                  //  "http://qige87.com/data/out/73/wp-image-144183272.png",
                  "https://avatarfiles.alphacoders.com/671/67133.jpg"),
            ),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                "Marc Webb",
                style: new TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              new Padding(
                  padding: new EdgeInsets.symmetric(vertical: 5),
                  child: new Row(
                    children: <Widget>[
                      new Text(
                        "Dashboard design",
                        style: new TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      new Container(
                        width: 8,
                        height: 8,
                        margin: new EdgeInsets.only(left: 10),
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                      ),
                    ],
                  )),
              new Text(
                "Hi Laura, I like your works, and looking for so",
                style: new TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          new Text(
            "20 min ago",
            style: new TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
    ;
  }
}
