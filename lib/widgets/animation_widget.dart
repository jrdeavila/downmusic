import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationWidget extends StatefulWidget {
  final Size size;
  final double yOffset;
  final Color color;

  const AnimationWidget(
      {Key? key,
      required this.size,
      required this.yOffset,
      required this.color})
      : super(key: key);

  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  List<Offset> wavePoints = [];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000))
      ..addListener(() {
        wavePoints.clear();
        final double speed = _controller.value * 1080;
        final double fullSphere = _controller.value * math.pi * 2;
        final double normalizer = math.cos(fullSphere);
        final double width = math.pi / 270;
        const double height = 20.0;

        for (int i = 0; i <= widget.size.width.toInt(); ++i) {
          double calc = math.sin((speed - i) * width);
          wavePoints.add(Offset(
            i.toDouble(),
            (calc * height * normalizer) + widget.yOffset,
          ));
        }
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return ClipPath(
            clipper: ClipperWidget(
              points: wavePoints,
            ),
            child: Container(
              width: widget.size.width,
              height: widget.size.height,
              color: widget.color,
            ),
          );
        });
  }
}

class ClipperWidget extends CustomClipper<Path> {
  final List<Offset> points;

  const ClipperWidget({
    required this.points,
  });

  @override
  getClip(Size size) {
    final Path path = Path();
    path.addPolygon(points, false);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
