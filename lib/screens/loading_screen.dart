import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/users_screen.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
   
  const LoadingScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {

          return const Center(
           child: Text('Loading...'),
          );
        },
        
      ),
    );
  }

  Future checkLoginState( BuildContext context ) async{

    final authService = Provider.of<AuthService>(context, listen: false);

    final authenticated =  await authService.isLoggedIn();

    if(authenticated){
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const UsersScreen()
          ));
    }else{
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const LoginScreen()
          ));
    }

  }
}