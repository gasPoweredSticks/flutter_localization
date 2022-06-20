import 'package:flutter/material.dart';

class AppLocale extends StatefulWidget {
  const AppLocale({
    Key? key,
    required this.locale,
    required this.child,
  }) : super(key: key);
  final Widget child;
  final Locale locale;

  @override
  State<AppLocale> createState() => AppLocaleState();

  static AppLocaleInherited of(BuildContext context) {
    final AppLocaleInherited? result =
        context.dependOnInheritedWidgetOfExactType<AppLocaleInherited>();
    assert(result != null, "No AppLocale found");
    return result!;
  }

  static void change(BuildContext context, Locale locale) {
    final state =
        (context.dependOnInheritedWidgetOfExactType<AppLocaleInherited>())!
            .data;
    state.change(locale);
  }
}

class AppLocaleState extends State<AppLocale> {
  late Locale locale;

  @override
  void initState() {
    super.initState();
    locale = widget.locale;
  }

  void change(Locale locale) {
    setState(() {
      this.locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppLocaleInherited(
      data: this,
      locale: locale,
      child: widget.child,
    );
  }
}

class AppLocaleInherited extends InheritedWidget {
  final Locale locale;
  final AppLocaleState data;

  const AppLocaleInherited({
    Key? key,
    required this.locale,
    required Widget child,
    required this.data,
  }) : super(child: child, key: key);

  @override
  bool updateShouldNotify(AppLocaleInherited prev) => locale != prev.locale;
}
