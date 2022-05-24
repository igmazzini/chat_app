import 'package:flutter/material.dart';


class CustomInput extends StatelessWidget {

  final String hintText;
  final TextInputType textType;
  final IconData prefixIcon;
  final bool obscureText;
  final TextEditingController textController;

  const CustomInput({
    
    Key? key,
    required this.textController,
    this.hintText = '',
    this.textType = TextInputType.text,
    this.prefixIcon = Icons.email,
    this.obscureText = false,

    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
            padding: const EdgeInsets.only(top:5, bottom:5,left:5,right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color:Colors.black.withOpacity(0.05),
                  offset: const Offset(0,5),
                  blurRadius: 5
                )
              ]
            ),
            child:   TextField(
              controller: textController,
              autocorrect: false,
              keyboardType: textType,
              obscureText: obscureText,
              decoration: InputDecoration(
                prefixIcon: Icon(prefixIcon),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: hintText,
              ),
            )
            );
  }
}