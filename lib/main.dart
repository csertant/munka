import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'config/dependencies.dart';
import 'ui/bootstrap/bootstrap.dart';

void main() {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  usePathUrlStrategy();
  runApp(MultiProvider(providers: stagingProviders, child: const Bootstrap()));
}
