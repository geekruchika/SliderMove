import 'package:flutter/material.dart';
// import 'package:flutter/physics.dart';
import 'dart:math';

typedef OnValue = Function(double);

const BOX_COLOR = Colors.grey;

class SlideAnimation extends StatelessWidget {
  final OnValue onValue;
  SlideAnimation({this.onValue});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: 200,
      decoration: new BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        // border: new Border(
        //     top: new BorderSide(width: 1, color: Colors.black),
        //     bottom: new BorderSide(width: 1, color: Colors.black))
      ),
      child: Padding(
        child: PhysicsBox(
          boxPosition: 0.4,
          onValueUpdate: onValue,
        ),
        padding: EdgeInsets.only(
          top: 20.0,
          bottom: 20.0,
        ),
      ),
    ));
  }
}

class PhysicsBox extends StatefulWidget {
  final boxPosition;
  final OnValue onValueUpdate;

  PhysicsBox({this.boxPosition = 0.0, this.onValueUpdate});

  @override
  BoxState createState() => BoxState();
}

class BoxState extends State<PhysicsBox> with TickerProviderStateMixin {
  double boxPosition;
  double boxPositionOnStart;
  Offset start;
  Offset point;
  double drag = 0;
  bool showBanner = false;
  AnimationController controller;
  // ScrollSpringSimulation simulation;
  double slidePercent = 0.0;
  int bannerText = 0;
  static const FULL_TRANSITION_PX = 300.0;

  @override
  void initState() {
    super.initState();
    boxPosition = widget.boxPosition;

    // simulation = ScrollSpringSimulation(
    //   SpringDescription(
    //     mass: 1.0,
    //     stiffness: 1.0,
    //     damping: 1.0,
    //   ),
    //   0.0,
    //   1.0,
    //   0.0,
    // );

    // controller = AnimationController(vsync: this)
    //   ..addListener(() {
    //     print('${simulation.x(controller.value)}');
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return (new Stack(
      children: <Widget>[
        new Positioned(
            bottom: 80,
            left: drag,
            child: new Container(
                padding: new EdgeInsets.only(
                    top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
                margin: new EdgeInsets.only(bottom: 5),
                decoration: new BoxDecoration(
                    color: !showBanner
                        ? Color.fromRGBO(255, 255, 255, 1)
                        : Color.fromRGBO(0, 0, 0, 1),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(4.0))),
                child: new Row(
                  children: <Widget>[
                    new Text(
                      bannerText.toString(),
                      style: new TextStyle(
                          fontSize: 25,
                          color: showBanner
                              ? Color.fromRGBO(255, 255, 255, 1)
                              : Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    new Text(
                      " kg",
                      style: new TextStyle(color: Colors.grey),
                    ),
                  ],
                ))),
        new Container(
          margin: EdgeInsets.only(top: 60.0),
          // color: Colors.red,
          height: 60,
          child:
              new Stack(alignment: Alignment.bottomCenter, children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                // onPanStart: startDrag,
                // onPanUpdate: onDrag,
                // onPanEnd: endDrag,
                child: CustomPaint(
                  painter: BoxPainter(
                    color: BOX_COLOR,
                    boxPosition: boxPosition,
                    boxPositionOnStart: boxPositionOnStart ?? boxPosition,
                    touchPoint: point,
                  ),
                  child: Container(),
                ),
              ),
            ),
            new Positioned(
                top: 45,
                left: drag,
                child: GestureDetector(
                  onPanStart: startDrag,
                  onPanUpdate: onDrag,
                  onPanEnd: endDrag,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                  ),
                )),
          ]),
        )
      ],
    ));
  }

  void startDrag(DragStartDetails details) {
    start = (context.findRenderObject() as RenderBox)
        .globalToLocal(details.globalPosition);
    setState(() {
      showBanner = false;
    });
    boxPositionOnStart = boxPosition;
  }

  void onDrag(DragUpdateDetails details) {
    var newPosition = details.globalPosition.dx;
    setState(() {
      drag = newPosition - 40;
      showBanner = true;
      slidePercent = (drag / FULL_TRANSITION_PX).abs().clamp(0.0, 1.0);
      print(slidePercent);
      var newValue = 160 * slidePercent;
      bannerText = newValue.floor();
      widget.onValueUpdate(newValue);

      point = (context.findRenderObject() as RenderBox)
          .globalToLocal(details.globalPosition);

      var dragVec = (start.dx - point.dx);
      if (dragVec < 0) dragVec = -dragVec;
      final normDragVec = (dragVec / context.size.height).clamp(-1.0, 1.0);
      boxPosition = (boxPositionOnStart + normDragVec).clamp(0.0, 1.0);
    });
  }

  void endDrag(DragEndDetails details) {
    setState(() {
      showBanner = false;
      start = null;
      point = null;
      boxPosition = boxPositionOnStart;
      boxPositionOnStart = null;
    });
  }
}

class BoxPainter extends CustomPainter {
  final double boxPosition;
  final double boxPositionOnStart;
  final Color color;
  final Offset touchPoint;
  final Paint boxPaint;
  final Paint dropPaint;

  BoxPainter({
    this.boxPosition = 0.0,
    this.boxPositionOnStart = 0.0,
    this.color = Colors.grey,
    this.touchPoint,
  })  : boxPaint = Paint(),
        dropPaint = Paint() {
    boxPaint.color = this.color;
    boxPaint.style = PaintingStyle.fill;
    dropPaint.color = Colors.grey;
    dropPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    // print(size);
    // print(boxPosition);
    final boxValueY = size.height - (size.height * boxPosition);
    final prevBoxValueY = size.height - (size.height * boxPositionOnStart);
    final midPointY = ((boxValueY - prevBoxValueY) * 1.2 + prevBoxValueY)
        .clamp(0.0, size.height);

    Point left, mid, right;
    left = Point(-100.0, prevBoxValueY);
    right = Point(size.width + 50.0, prevBoxValueY);

    if (null != touchPoint) {
      mid = Point(touchPoint.dx, midPointY);
    } else {
      mid = Point(size.width / 2, midPointY);
    }

    final path = Path();
    // path.moveTo(300, 100);
    // path.quadraticBezierTo(50.0, 10, 100, 100);
    // path.close();
    path.moveTo(mid.x, mid.y);
    path.quadraticBezierTo(
      mid.x - 100.0,
      mid.y,
      left.x,
      left.y,
    );
    path.lineTo(0.0, size.height);
    path.moveTo(mid.x, mid.y);
    path.quadraticBezierTo(
      mid.x + 100.0,
      mid.y,
      right.x,
      right.y,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    canvas.drawPath(path, boxPaint);

    // canvas.drawCircle(Offset(right.x, right.y), 10.0, dropPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
