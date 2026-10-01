import 'package:material_ui/material_ui.dart';

import 'l10n/generated/app_localizations.dart';
import 'routing/router.dart';
import 'ui/core/themes/themes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      // locale: Locale(appSettings.languageCode),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // themeMode: appSettings.theme,
      routerConfig: router(),
    );
  }
}
