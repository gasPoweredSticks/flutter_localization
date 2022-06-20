import 'package:flutter/material.dart';

class AppLocale extends ChangeNotifier {
  AppLocale({
    required this.locale,
  }) : super();

  Locale locale;

  void change(Locale locale) {
    this.locale = locale;
    notifyListeners();
  }
}
