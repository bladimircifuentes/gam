import 'package:flutter/material.dart';

import 'package:gam/chat/services/auth_chat_service.dart';
import 'package:gam/chat/services/chat_service.dart';
import 'package:gam/chat/services/message_chat_service.dart';
import 'package:gam/chat/services/socket_chat_service.dart';
import 'package:gam/common/global/environment_provider.dart';
import 'package:gam/login/providers/providers.dart';
import 'package:gam/profile/providers/providers.dart';
import 'package:gam/routes/routes.dart';
import 'package:gam/settings/providers/providers.dart';
import 'package:gam/subscription/providers/providers.dart';
import 'package:gam/theme/app_theme.dart';
import 'package:provider/provider.dart';


void main() {

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => EnvironmentProvider()),
      ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ChangeNotifierProvider(create: (_) => AuthChatService()),
      ChangeNotifierProvider(create: (_) => SocketChatService()),
      ChangeNotifierProvider(create: (_) => ChatService()),
      ChangeNotifierProvider(create: (_) => MessageChatService()),
      ChangeNotifierProvider(create: (_) => PasswordProvider()),
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
