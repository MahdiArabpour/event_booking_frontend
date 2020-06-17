import 'package:flutter/material.dart';

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({Color color = Colors.white, @required double strokeWidth, @required lineWidth})
      : _painter = _CirclePainter(color, strokeWidth, lineWidth);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double strokeWidth;
  final double lineWidth;

  _CirclePainter(Color color, this.strokeWidth, this.lineWidth)
      : _paint = Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset leftOffset =
        offset + Offset(cfg.size.width / 2 - lineWidth / 2, cfg.size.height - (strokeWidth / 2) - 5);
    final Offset rightOffset =
        offset + Offset(cfg.size.width / 2 + lineWidth / 2, cfg.size.height - (strokeWidth / 2) - 5);
    canvas.drawCircle(leftOffset, strokeWidth / 2, _paint);
    canvas.drawLine(leftOffset, rightOffset, _paint);
    canvas.drawCircle(rightOffset, strokeWidth / 2, _paint);
  }
}
