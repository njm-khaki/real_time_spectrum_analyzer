import 'dart:math';

import 'package:audio_streamer/audio_streamer.dart';
import 'package:fft/fft.dart';

// import 'package:fft/fft.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import './../../models/spectrum_analyzer/spectrum_analyzer_model.dart';

/// スペクトルアナライザーのViewModel
class SpectrumAnalyzerViewModel with ChangeNotifier {
  /// スペクトルアナライザーのモデルクラス
  SpectrumAnalyzerModel _analyzer = SpectrumAnalyzerModel();

  /// 録音用
  AudioStreamer _streamer = AudioStreamer();

  /// 波形情報を取得
  List<double> get spectrum => _analyzer.spectrum;

  List<double> get wave => _analyzer.wave;

  bool get showWave => _analyzer.showWave;

  void chageShowWave() {
    _analyzer.showWave = !_analyzer.showWave;
    notifyListeners();
  }

  void start() async {
    try {
      _streamer.start(_onAudio, _handleError);
    } catch (error) {}
  }

  void _onAudio(List<double> _buffer) {
    _analyzer.wave = _zeroPadding(buffer: _buffer);
    notifyListeners();

    /// 窓関数とサンプルデータ生成(窓関数の適用)
    final _window = Window(WindowType.HAMMING);
    final _sample = _window.apply(_analyzer.wave);

    /// FFTの適用
    final _fft = FFT().Transform(_sample);

    /// スペクトルを格納用
    List<double> _spectrum = [];

    for (int i = 0; i < _analyzer.wave.length / 2; i++) {
      // パワースペクトルを単位(dB)に変換する
      // 参考 : https://marui.hatenablog.com/entry/2019/12/20/071400
      final _power = (_fft[i] * _fft[i].conjugate).real / _analyzer.wave.length;
      _spectrum.add(-10 * (log(_power) / log(10)));
    }

    _analyzer.spectrum = _spectrum;
    notifyListeners();
  }

  void _handleError(PlatformException _error) {}

  /// 2のn乗になるようにゼロパディングする
  List<double> _zeroPadding({
    @required List<double> buffer,
  }) {
    final _base = (log(buffer.length) / log(2)) + 1;
    final _windowWidth = pow(2, _base.floor()).toInt();
    final _remainder = _windowWidth - buffer.length;
    return _remainder.isEven
    ? [
    ...List<double>.filled(_remainder ~/ 2, 0),
    ...buffer,
    ...List<double>.filled(_remainder ~/ 2, 0),
    ]
        : [
    ...List<double>.filled(_remainder ~/ 2, 0),
    ...buffer,
    ...List<double>.filled((_remainder ~/ 2) + 1, 0),
    ];
  }
}
