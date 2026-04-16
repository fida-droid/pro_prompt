import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'providers/prompt_provider.dart';
import 'screens/home_screen.dart';
import 'services/ad_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AdService().init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => PromptProvider()..loadPrompts(),
      child: const ProPromptApp(),
    ),
  );
}

class ProPromptApp extends StatelessWidget {
  const ProPromptApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PromptProvider>(context);
    return MaterialApp(
      title: 'Pro Prompt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: provider.isDarkMode ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: provider.locale.languageCode == 'ur' ? 'JameelNoori' : null,
      ),
      locale: provider.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ur'),
      ],
      home: const HomeScreen(),
    );
  }
}
