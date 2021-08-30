import 'dart:math';

import './../importer.dart';

class SpectrumPainter extends CustomPainter {
  final List<double> data;
  final Color color;

  SpectrumPainter({
    @required List<double> this.data,
    @required Color this.color,
  }) : super();

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  void paint(Canvas _canvas, Size _size) {
    final Paint _background = Paint()..color = color;

    final Rect _plotFrame = Rect.fromLTWH(
      0,
      0,
      _size.width,
      _size.height,
    );
    _canvas.drawRect(_plotFrame, _background);

    final _path = Path()
      ..addPolygon(
        _createPolygon(
          size: _size,
          data: data,
        ),
        false,
      );

    _canvas.drawPath(
        _path,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
    );
  }

  List<Offset> _createPolygon({
    @required Size size,
    @required List<double> data,
  }) =>
      data
          .asMap()
          .entries
          .map(
            (_item) => _dataMapping(
              size: size,
              x: _item.key / data.length,
              y: _mappingRate(
                value: _item.value,
                max: data.reduce(max),
                min: data.reduce(min),
              ),
            ),
          )
          .toList();

  double _mappingRate({
    @required double value,
    @required double max,
    double min = 0,
  }) =>
      (value - min) / (max - min);

  /// 表示領域に対する比率から座標を求める
  Offset _dataMapping({
    @required Size size,
    @required double x,
    @required double y,
  }) =>
      Offset(size.width * x, size.height * y);
}
