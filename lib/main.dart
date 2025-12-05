import 'package:flutter/material.dart';
import 'app/app_router.dart';
import 'app/service_locator.dart';
import 'app/winglet_provider.dart';
import 'features/winglets/services/data_service.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dataService = getIt<DataService>();

    return WingletProvider(
      dataService: dataService,
      child: MaterialApp.router(
        title: 'prac8',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        routerConfig: appRouter,
      ),
    );
  }
}
