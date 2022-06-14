import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Localization';

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: _title,
      home: LanguageSelector(title: _title),
    );
  }
}

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key, required this.title}) : super(key: key);

  final String title;

  // This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Select Language'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('English'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
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
    return CupertinoPageScaffold(
      child: Center(
        child: CupertinoButton(
          onPressed: () => _showActionSheet(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text('Language', style: TextStyle(color: Colors.black87)),
              Text('English', style: TextStyle(color: Colors.black87))
            ],
          ),
        ),
      ),
    );
  }
}
