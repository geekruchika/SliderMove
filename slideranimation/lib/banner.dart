import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:slideranimation/contactlist.dart';

class BannerScreen extends StatefulWidget {
  BannerScreen({
    Key key,
  }) : super(key: key);

  @override
  _BannerScreenState createState() => new _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen>
    with TickerProviderStateMixin {
  AnimationController _tickController;
  Animation<double> dimension;
  @override
  void initState() {
    super.initState();
    _tickController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    dimension = new Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      new CurvedAnimation(
        parent: _tickController,
        curve: Curves.bounceOut,
      ),
    );
    dimension.addListener(() {
      setState(() {
        // if (_tickController.isCompleted) _tickController.reverse();
      });
    });
    _tickController.forward();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    return new Scaffold(
        body: new Opacity(
            opacity: dimension.value,
            child: new Container(
                color: Color.fromRGBO(255, 255, 255, 1),
                padding: new EdgeInsets.all(50.0),
                alignment: Alignment.center,
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Opacity(
                        opacity: dimension.value,
                        child: new Hero(
                          tag: "icon",
                          child: new Icon(Icons.check),
                        ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.only(top: 20, bottom: 20),
                        child: new Text(
                          "You're all set",
                          style: new TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      new Text(
                        "You can now start to use the app ",
                        style: new TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(160, 160, 160, 1),
                            fontWeight: FontWeight.w400),
                      ),
                      new Text(
                        "with all the features.",
                        style: new TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(160, 160, 160, 1),
                            fontWeight: FontWeight.w400),
                      ),
                      new Padding(
                        padding: new EdgeInsets.only(
                          top: 50,
                        ),
                        child: new FlatButton(
                            onPressed: () {
                              Navigator.of(context).push(new PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    new ContactScreen(),
                              ));
                            },
                            child: new Text(
                              "Continue",
                              style: new TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(153, 153, 255, 1),
                                  fontWeight: FontWeight.w500),
                            )),
                      )
                    ]))));
  }
}
