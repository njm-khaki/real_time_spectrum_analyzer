import './../importer.dart';

import 'spectrum_painter.dart';

class SpectrumCanvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<double> _spectrum =
        Provider.of<SpectrumAnalyzerViewModel>(context).spectrum;

    return CustomPaint(
      size: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.width / 3,
      ),
      painter: SpectrumPainter(
        data: _spectrum,
        color: Theme.of(context).primaryColor.withOpacity(0.2),
      ),
    );
  }
}
