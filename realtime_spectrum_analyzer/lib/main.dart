import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(
        title: 'realtime_spectrum_analyzer',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _length = 4096;
  List<double> _data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generateRandData();
  }

  void _generateRandData() {
    setState(() {
      _data = List<double>.filled(_length, 0.0)
          .map((double _value) => math.Random().nextDouble())
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CustomPaint(
          size: Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.width / 2
          ),
          painter: SpectrumPainter(
            data: _data,
            color: Theme.of(context).primaryColor.withOpacity(0.2),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateRandData,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SpectrumPainter extends CustomPainter {
  final List<double> data;
  final Color color;

  SpectrumPainter({
    required List<double> this.data,
    required Color this.color
  }) : super();


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  @override
  void paint(Canvas _canvas, Size _size) {
    final Paint _red = Paint()
      ..color = color;

    final Rect _plotFrame = Rect.fromLTWH(
        0,
        0,
        _size.width,
        _size.height,
    );
    _canvas.drawRect(_plotFrame, _red);

    for (int i = 0; i < data.length; i++) {
      if (i == 0) {
        continue;
      }

      final Offset _from = _dataMapping(
        size: _size,
        x: (i - 1) / data.length,
        y: data[i - 1],
      );

      final Offset _to = _dataMapping(
        size: _size,
        x: i / data.length,
        y: data[i],
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
    required Canvas canvas,
    required Color color,
    required Offset to,
    Offset from = Offset.zero,
  }) => canvas.drawLine(
        from,
        to,
        Paint()..color = color,
    );

  /// 表示領域に対する比率から座標を求める
  Offset _dataMapping({
    required Size size,
    required double x,
    required double y,
  }) => Offset(
    size.width * x,
    size.height * y
  );

}
