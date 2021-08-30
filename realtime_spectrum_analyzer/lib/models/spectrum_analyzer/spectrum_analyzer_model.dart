/// スペクトルアナライザーのモデルクラス
class SpectrumAnalyzerModel {
  bool _showWave = true;

  List<double> _wave = [];

  List<double> _spectrum = [];

  bool get showWave => _showWave;

  set showWave(bool showWave) => _showWave = showWave;

  List<double> get wave => _wave;

  set wave(List<double> wave) => _wave = wave;

  List<double> get spectrum => _spectrum;

  set spectrum(List<double> spectrum) => _spectrum = spectrum;
}
