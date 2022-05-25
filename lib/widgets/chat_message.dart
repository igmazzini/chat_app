import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  final String text;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({ 
    Key? key,
    required this.text,
    required this.uid,
    required this.animationController 
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(        
        sizeFactor: CurvedAnimation(parent: animationController,curve: Curves.easeInOut),
        child: Container(
          child:  (uid == '123') ? _myMessage() : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage(){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(right: 8,bottom: 8, left: 30),
        padding: const EdgeInsets.all(10),
        child: Text(text, style: const TextStyle(color: Colors.black54),),
        decoration:  BoxDecoration(
          color: const Color.fromARGB(104, 77, 159, 246),
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }

  Widget _notMyMessage(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 8,bottom: 8, right: 30),
        padding: const EdgeInsets.all(10),
        child: Text(text, style: const TextStyle(color: Colors.black54),),
        decoration:  BoxDecoration(
          color: const Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }
}