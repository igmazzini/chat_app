
import 'dart:io';
import 'package:chat_app/models/messages_response.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
   
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {

  final textController = TextEditingController();
  final focusNode = FocusNode();
  late ChatService chatService;
  late SocketService socketService; 
  
  

  List<ChatMessage> messages = [];

  @override
  void initState() {
    
    super.initState();

    chatService  = Provider.of<ChatService>(context, listen: false);
    socketService  = Provider.of<SocketService>(context, listen: false);


    socketService.socket.on('user-message',_messageListener);

    _loadMessagesHistory( chatService.chatUser.uid );
  }


  void _messageListener( dynamic data ) {

    //print('User message '+data['msg']);

    ChatMessage message = ChatMessage(
      text: data['msg'],
      uid: chatService.chatUser.uid,
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds:300),
        )
    );

    messages.insert(0,message);
    message.animationController.forward();

    setState(() {
      
    });
    
  }


  @override
  void dispose() {
    //TODO: OFF Sockets

    for (ChatMessage message in messages) {
        message.animationController.dispose();
    }

    socketService.socket.off('user-message');

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    
    final chatUser = chatService.chatUser;

    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Column(
          children:  [
            CircleAvatar(
              maxRadius: 14,
              child: Text(chatUser.name.substring(0,2), style: const TextStyle(fontSize: 12),),
              backgroundColor: Colors.blue[200],
            ),
            const SizedBox(height: 5,),
            Text(chatUser.name, style: const TextStyle(color: Colors.black87, fontSize: 12),)
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, i) => messages[i],
                itemCount: messages.length,
                reverse: true,
                )
              
            ),
            const Divider(),
            Container(
             
              child: _inputChat(),
              decoration: const BoxDecoration(
                color: Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(child: TextField(
              controller: textController,
              onSubmitted: _handleSubmit,
              onChanged: (value){

                 setState(() {
                  
                  });

               
                
              },
              decoration: const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
              focusNode: focusNode,
            )
            ),
            Container(
              margin: const EdgeInsets.symmetric( horizontal: 4),
              child: (Platform.isIOS) 
               ? const CupertinoButton(child:  Text('Enviar'), onPressed: null,)
               : Container(
                 margin: const EdgeInsets.symmetric(horizontal: 4),
                 child: IconTheme(
                   data:IconThemeData(color: Colors.blue[300]),
                   child: IconButton(
                     icon: const Icon(Icons.send),
                     onPressed: textController.text.isEmpty ? null : (){ 

                       _handleSubmit(textController.text);

                       },                     
                     highlightColor: Colors.transparent,
                     splashColor: Colors.transparent,
                     ),
                 ),
               )       
            )
          ],
        )
        ),
    );
  }

  _handleSubmit( String text) {


    if(text.isEmpty)  return;


    final authService = Provider.of<AuthService>(context, listen: false);
   
    textController.clear();    
    focusNode.requestFocus();

    final newMesage = ChatMessage(
      text: text,
      uid: authService.user.uid,
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds:300),
        )
        );
    messages.insert(0,newMesage);
    newMesage.animationController.forward();

    setState(() {
      
    });

    socketService.socket.emit('user-message',{
      'from':authService.user.uid,
      'to':chatService.chatUser.uid,
      'msg':newMesage.text
    });

    
  }

  void _loadMessagesHistory(String uid) async{

    List<Message> messageHistory = await chatService.getMessages(uid);

    final history = messageHistory.map((m) => ChatMessage(
      text: m.msg,
      uid: m.from,
      animationController: AnimationController(
          vsync: this,
          duration: const Duration(milliseconds:0),
          )..forward()),
      );


    setState(() {
      messages.insertAll(0, history);
     });

  }

  
}