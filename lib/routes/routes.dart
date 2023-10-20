import 'package:flutter/material.dart';
import 'package:gam/common/home_page.dart';
import 'package:gam/login/pages/pages.dart';
import 'package:gam/profile/pages/pages.dart';
import 'package:gam/subscription/pages/pages.dart';



final Map<String,Widget Function(BuildContext)> appRoutes = {
  'loading': (_) => const LoadingPage(),
  'subscripcion' : (_) => const SubscriptionPage(),
  'login' :(_) => const LoginPage(), 
  'home' : (_) => const HomePage(),
  'teacher' : (_) => const TeacherPage(),
  'student' : (_) => const StudentPage(),
};