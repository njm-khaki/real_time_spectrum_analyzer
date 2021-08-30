import './../importer.dart';

import 'spectrum_painter.dart';

class WaveCanves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// 波形の描画フラグ
    final _show = Provider.of<SpectrumAnalyzerViewModel>(context).showWave;

    if (!_show) return null;

    /// 波形データ
    final List<double> _wave =
        Provider.of<SpectrumAnalyzerViewModel>(context).wave;

    return CustomPaint(
      size: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.width / 3,
      ),
      painter: SpectrumPainter(
        data: _wave,
        color: Theme.of(context).primaryColor.withOpacity(0.2),
      ),
    );
  }
}
