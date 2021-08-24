import 'dart:math';

import 'package:realtime_spectrum_analyzer/widgets/spectrum_analyzerspectrum_analyzer/spectrum_canvas.dart';

import './../importer.dart';

import 'wave_canvas.dart';

class SpectrumAnalyzer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // WaveCanves(),
              SpectrumCanvas(),
            ],
          ),
        ),
      );
}
