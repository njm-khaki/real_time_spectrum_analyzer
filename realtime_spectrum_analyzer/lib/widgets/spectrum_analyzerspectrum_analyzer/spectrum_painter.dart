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

    for (int i = 0; i < data.length; i++) {
      if (i == 0) {
        continue;
      }

      /// リストの最大値と最小値を取得
      final double _max = data.reduce(max);
      final double _min = data.reduce(min);

      final Offset _from = _dataMapping(
        size: _size,
        x: (i - 1) / data.length,
        y: _mappingRate(
          value: data[i - 1],
          max: _max,
          min: _min,
        ),
      );

      final Offset _to = _dataMapping(
        size: _size,
        x: i / data.length,
        y: _mappingRate(
          value: data[i],
          max: _max,
          min: _min,
        ),
      );

      _paintLine(
        canvas: _canvas,
        color: Colors.black,
        from: _from,
        to: _to,
      );
    }
  }

  void _paintLine({
    @required Canvas canvas,
    @required Color color,
    @required Offset to,
    Offset from = Offset.zero,
  }) =>
      canvas.drawLine(
        from,
        to,
        Paint()..color = color,
      );

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
      Offset(size.width * x, size.height - size.height * y);
}
