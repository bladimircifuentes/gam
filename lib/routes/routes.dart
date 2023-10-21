import 'package:flutter/material.dart';
import 'package:gam/chat/pages/chat_page.dart';
import 'package:gam/chat/pages/list_contact_page.dart';
import 'package:gam/common/home_page.dart';
import 'package:gam/login/pages/pages.dart';
import 'package:gam/profile/pages/pages.dart';
import 'package:gam/profile/pages/profile_page.dart';
import 'package:gam/settings/pages/pages.dart';
import 'package:gam/subscription/pages/pages.dart';



final Map<String,Widget Function(BuildContext)> appRoutes = {
  'loading': (_) => const LoadingPage(),
  'subscripcion' : (_) => const SubscriptionPage(),
  'login' :(_) => const LoginPage(), 
  'home' : (_) => const HomePage(),
  'teacher' : (_) => const TeacherPage(),
  'student' : (_) => const StudentPage(),
  'profile': (_) => const ProfilePage(),
  'contacts': (_) => const ListContactPage(),
  'chat': (_) => const ChatPage(),
  'settings': (_) => const SettingsPage(),
  'forgotten_password': (_) => const ForgottenPasswordPage(),
  'change_password' : (_) => const ChangePasswordPage(),
};