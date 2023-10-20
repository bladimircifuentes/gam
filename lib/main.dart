import 'package:flutter/material.dart';
import 'package:gam/profile/providers/profile_provider.dart';
import 'package:gam/routes/routes.dart';
import 'package:provider/provider.dart';

import 'package:gam/subscription/providers/subscription_provider.dart';
import 'package:gam/theme/app_theme.dart';


void main() {

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
      ChangeNotifierProvider(create: (_) => ProfileProvider()),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GAM',
      initialRoute: 'loading',
      routes: appRoutes,
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
