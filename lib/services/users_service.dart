import 'dart:convert';

import 'package:chat_app/models/user.dart';
import 'package:chat_app/models/users_response.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../global/enviroment.dart';

class UsersService {

  Future<List<User>> getUsers() async{
    try {

      final token = await AuthService.getToken();

      final url = Uri.parse('${Enviroment.apiUrl}/users'); 

      final resp = await http.get(url, headers: {'Content-type':'application/json','x-token':token});

      final userResponse = UsersResponse.fromJson(jsonDecode(resp.body));

      return userResponse.users;

      
    } catch (e) {

      return [];
    }
  }
  
}