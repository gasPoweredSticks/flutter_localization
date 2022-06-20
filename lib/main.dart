import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'app_locale.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLocale>(
      create: (_) => AppLocale(locale: Locale('en')),
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  static const String _title = 'Localization';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      locale: context.watch<AppLocale>().locale,
      home: LanguageSelector(title: _title),
    );
  }
}

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  TextDirection _direction = TextDirection.rtl;

  // This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(context.l10n.selectLang),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                _direction = TextDirection.ltr;
              });
              
              context.read<AppLocale>().change(Locale('en'));
              
              Navigator.pop(context);
            },
            child: const Text('English'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                _direction = TextDirection.rtl;
              });
              context.read<AppLocale>().change(Locale('ar'));
              
              Navigator.pop(context);
            },
            child: const Text('عربي'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(context.l10n.cancel),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CupertinoButton(
          onPressed: () => _showActionSheet(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(context.l10n.langTitle,
                  style: TextStyle(color: Colors.black87)),
              Text(
                context.l10n.language,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
