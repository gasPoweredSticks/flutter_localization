import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'app_locale.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLocale(
      child: App(),
      locale: Locale('en'),
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
      locale: AppLocale.of(context).locale,
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
        title: const Text('Select Language'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                _direction = TextDirection.ltr;
              });
              AppLocale.change(context, Locale('en'));
              Navigator.pop(context);
            },
            child: const Text('English'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                _direction = TextDirection.rtl;
              });
              AppLocale.change(context, Locale('ar'));
              Navigator.pop(context);
            },
            child: const Text('عربي'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Language', style: TextStyle(color: Colors.black87)),
              Text('اللغة', style: TextStyle(color: Colors.black87)),
              Text(context.l10n.helloWorld,
                  style: TextStyle(color: Colors.black87)),
              Directionality(
                textDirection: _direction,
                child: Text(
                  'English',
                  textDirection: _direction,
                ),
              ),
              Directionality(
                textDirection: _direction,
                child: Text(
                  'هذه الكتابة بالعربي',
                  textDirection: _direction,
                ),
              ),
              TextField(
                textDirection: _direction,
                decoration: InputDecoration(labelText: 'Input'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
