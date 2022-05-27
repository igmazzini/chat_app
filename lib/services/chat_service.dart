import 'dart:convert';

import 'package:chat_app/models/messages_response.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global/enviroment.dart';

class ChatService with ChangeNotifier {


  late User chatUser;


  Future<List<Message>> getMessages( String uid ) async {

     try {

      final token = await AuthService.getToken();

      final url = Uri.parse('${Enviroment.apiUrl}/messages/$uid'); 

      final resp = await http.get(url, headers: {'Content-type':'application/json','x-token':token});

      final mesaagesResponse = MessagesResponse.fromJson(jsonDecode(resp.body));

      return mesaagesResponse.messages;

      
    } catch (e) {

      return [];
    }
  }
  
}