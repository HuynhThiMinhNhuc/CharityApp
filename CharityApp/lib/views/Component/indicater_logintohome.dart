import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class IndicatorDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x405AA469),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          //   child: Text(
          //     'Cùng nạp đầy năng lượng xanh với Meer',
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 30,
          //       fontFamily: 'DancingScript_Regular',
          //       decoration: TextDecoration.none,
          //       fontWeight: FontWeight.w100,
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          _AnimatedLiquidCustomProgressIndicator(),
        ],
      ),
    );
  }
}

class _AnimatedLiquidCustomProgressIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _AnimatedLiquidCustomProgressIndicatorState();
}

class _AnimatedLiquidCustomProgressIndicatorState
    extends State<_AnimatedLiquidCustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = _animationController.value * 100;
    return Center(
      child: LiquidCustomProgressIndicator(
        value: _animationController.value,
        direction: Axis.vertical,
        backgroundColor: Colors.white,
        valueColor: AlwaysStoppedAnimation(Colors.green),
        shapePath: _buildHeartPath(),
        center: Text(
          "${percentage.toStringAsFixed(0)}%",
          style: TextStyle(
            color: Colors.lightGreenAccent,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Path _buildHeartPath() {
    return Path()
      ..moveTo(55, 15)
      ..cubicTo(55, 12, 50, 0, 30, 0)
      ..cubicTo(0, 0, 0, 37.5, 0, 37.5)
      ..cubicTo(0, 55, 20, 77, 55, 95)
      ..cubicTo(90, 77, 110, 55, 110, 37.5)
      ..cubicTo(110, 37.5, 110, 0, 80, 0)
      ..cubicTo(65, 0, 55, 12, 55, 15)
      ..close();
  }
}
