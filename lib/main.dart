import 'package:advicer_app/application/pages/advice/advice_page.dart';
import 'package:advicer_app/theme.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'application/core/services/theme_service.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return MaterialApp(
          themeMode:
              themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const AdvicePageWrapperProvider(),
        );
      },
    );
  }
}
