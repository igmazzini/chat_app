import 'dart:io';
import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
   
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {

  final textController = TextEditingController();
  final focusNode = FocusNode();

  List<ChatMessage> messages = [];


  @override
  void dispose() {
    //TODO: OFF Sockets

    for (ChatMessage message in messages) {
        message.animationController.dispose();
    }

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Column(
          children:  [
            CircleAvatar(
              maxRadius: 14,
              child: const Text('Ma', style: TextStyle(fontSize: 12),),
              backgroundColor: Colors.blue[200],
            ),
            const SizedBox(height: 5,),
            const Text('Maria', style: TextStyle(color: Colors.black87, fontSize: 12),)
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
   
    textController.clear();    
    focusNode.requestFocus();

    final newMesage = ChatMessage(
      text: text,
      uid: '123',
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds:300),
        )
        );
    messages.insert(0,newMesage);
    newMesage.animationController.forward();

    setState(() {
      
    });

    
  }
}