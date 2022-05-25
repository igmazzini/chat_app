import 'package:flutter/material.dart';

import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/users_screen.dart';
import '../screens/loading_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {

  
  'login': (_) => const LoginScreen(),
  'register': (_) => const RegisterScreen(),
  'loading': (_) => const LoadingScreen(),
  'users': (_) => const UsersScreen(),
  'chat': (_) => const ChatScreen(),

};