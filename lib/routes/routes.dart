import 'package:flutter/material.dart';

import 'package:chat_app/sceens/chat_screen.dart';
import 'package:chat_app/sceens/users_screen.dart';
import '../sceens/loading_screen.dart';
import '../sceens/login_screen.dart';
import '../sceens/register_screen.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {

  
  'login': (_) => const LoginScreen(),
  'register': (_) => const RegisterScreen(),
  'loading': (_) => const LoadingScreen(),
  'users': (_) => const UsersScreen(),
  'chat': (_) => const ChatScreen(),

};