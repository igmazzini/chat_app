import 'package:flutter/material.dart';

class Labels extends StatelessWidget {


  final String targetRoute; 
  final String textLabel; 
  final String textButton; 

  const Labels({Key? key, required this.targetRoute, required this.textButton, required this.textLabel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children:  [
          Text(textLabel, style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),),
          const SizedBox(height: 10,),
          TextButton(onPressed: (){
            Navigator.pushNamed(context, targetRoute);
          }, child:  Text(textButton, style: const TextStyle(fontWeight: FontWeight.bold),))
        ],
      ),
    );
  }
}