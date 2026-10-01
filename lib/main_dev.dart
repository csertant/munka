import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'config/dependencies.dart';

void main() {
  usePathUrlStrategy();
  runApp(MultiProvider(providers: developmentProviders, child: const App()));
}
