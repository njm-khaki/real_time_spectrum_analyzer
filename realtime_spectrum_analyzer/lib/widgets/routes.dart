import 'importer.dart';

import 'spectrum_analyzerspectrum_analyzer/spectrum_analyzerspectrum_analyzer.dart';

/// ルーティング定義
class Routes {
  static const spectrumAnalyzer = '/spectrumAnalyzer';

  static Map<String, WidgetBuilder> get routes => {
    spectrumAnalyzer: (context) => SpectrumAnalyzer(),
  };
}