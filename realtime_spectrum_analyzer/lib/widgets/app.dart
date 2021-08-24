import 'package:realtime_spectrum_analyzer/view_models/spectrum_analyzer/spectrum_analyzer_view_model.dart';

import 'importer.dart';

/// アプリ本体
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) {
        final _analyzer = SpectrumAnalyzerViewModel();
        _analyzer.start();
        return _analyzer;
      })
    ],
    child: MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      initialRoute: Routes.spectrumAnalyzer,
      routes: Routes.routes,
    ),
  );
}