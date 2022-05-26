import 'dart:convert';

import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/register_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {

  late User user;
  bool _authenticating = false;
  final  _storage = const FlutterSecureStorage();



  bool get authenticating => _authenticating;

  set  authenticating( bool val )  {
      _authenticating = val;
      notifyListeners();
  }


  static Future<String> getToken() async {

    const  storage = FlutterSecureStorage();

    final token = await storage.read(key: 'token');

    return token!;
  } 

  
  
  Future<Map<String,dynamic>> login( String email, String password ) async {


    authenticating = true;

    final data = {
      'email':email,
      'password':password
    };

  
    final url = Uri.parse('${Enviroment.apiUrl}/login'); 
    final resp = await http.post(url,body:jsonEncode(data), headers: {'Content-type':'application/json'}); 
   
    authenticating = false;

    if(resp.statusCode == 200){

      final loginResponse = LoginResponse.fromJson(jsonDecode(resp.body));  

      if(loginResponse.ok){

          user = loginResponse.user!;  

          saveToken(loginResponse.token!);       

          return {
            'ok':true,
            'msg':'logged',
          };

      }else{

        return {
          'ok':false,
          'msg':loginResponse.msg,
        };

      }
    }else{

       return {
          'ok':false,
          'msg':'Authentication error',
        };

    }  
    
  }



  Future<Map<String,dynamic>> register(String name, String email, String password ) async {


    authenticating = true;

    final data = {
      'name':name,
      'email':email,
      'password':password
    };

  
    final url = Uri.parse('${Enviroment.apiUrl}/login/new'); 
    final resp = await http.post(url,body:jsonEncode(data), headers: {'Content-type':'application/json'}); 
   
    authenticating = false;

    if(resp.statusCode == 200){

      final registerResponse = RegisterResponse.fromJson(jsonDecode(resp.body));  

      if(registerResponse.ok){

          user = registerResponse.user!;  

          saveToken(registerResponse.token!);       

          return {
            'ok':true,
            'msg':registerResponse.msg,
          };

      }else{

        return {
          'ok':false,
          'msg':registerResponse.msg,
        };

      }
    } else if(resp.statusCode == 400){

        final registerResponse = RegisterResponse.fromJson(jsonDecode(resp.body)); 
        
         return {
            'ok':false,
            'msg':registerResponse.msg,
          };

    }else{

       return {
          'ok':false,
          'msg':'Register error',
        };

    }  
    
  }

  Future<bool> isLoggedIn() async {
    
    final token = await _storage.read(key: 'token');

    if(token != null){

      final url = Uri.parse('${Enviroment.apiUrl}/login/renew'); 

      final resp = await http.get(url, headers: {'Content-type':'application/json','x-token':token}); 

      if(resp.statusCode == 200){

        final loginResponse = LoginResponse.fromJson(jsonDecode(resp.body));  

        if(loginResponse.ok){

          user = loginResponse.user!;  

          saveToken(loginResponse.token!);       

          return true;  

      

        }else{
          
          logout(); 
          return false;

        }      

      }else{

        logout();  
        return false;

      }

    }else{

      return false;
    }

  }


  Future saveToken( String token) async{

    return await _storage.write(key: 'token', value: token);

  }

  Future logout() async{

    return await _storage.delete(key: 'token');

  }

   
}