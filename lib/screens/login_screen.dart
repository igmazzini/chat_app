

import 'package:chat_app/helpers/show_alert.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/labels.dart';
import '../widgets/logo.dart';

class LoginScreen extends StatelessWidget {
   
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Logo(title: 'Messenger',),
                _Form(),
                Labels(targetRoute: 'register',textButton: 'Crea una ahora!', textLabel: '¿No tienes cuenta?',),
                Text('Terminos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class _Form extends StatefulWidget {
  const _Form({ Key? key }) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    
    final authService = Provider.of<AuthService>(context);
    

    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 25),
      margin: const EdgeInsets.only( top: 40,),
      child:Column(
        children: [
          CustomInput(textController: emailController,textType: TextInputType.emailAddress,hintText: 'Email',prefixIcon: Icons.email_outlined,),
          const SizedBox(height: 20,),
          CustomInput(textController: passwordController, textType: TextInputType.visiblePassword,hintText: 'Password',prefixIcon: Icons.lock_outline,obscureText: true,),
          const SizedBox(height: 20,),
          CustomButton(onPressed: (authService.authenticating) ? null : () async{
           
            FocusScope.of(context).unfocus();

            final resp = await authService.login(emailController.text.trim(), passwordController.text.trim());

            (resp['ok']) 

              ? Navigator.pushReplacementNamed(context, 'users') 
              
              : showAlert(context, 'Login error', resp['msg']);
            
           
          },
          textButton: 'Ingresar'),
        ],
      )
    );
  }


 
}


