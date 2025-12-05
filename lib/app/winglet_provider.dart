import 'package:flutter/material.dart';
import '../features/winglets/services/data_service.dart';

class WingletProvider extends InheritedWidget {
  final DataService dataService;

  const WingletProvider({
    super.key,
    required this.dataService,
    required super.child,
  });

  static WingletProvider of(BuildContext context) {
    final WingletProvider? result =
    context.dependOnInheritedWidgetOfExactType<WingletProvider>();
    assert(result != null, 'WingletProvider not found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(WingletProvider oldWidget) =>
      dataService != oldWidget.dataService;
}
