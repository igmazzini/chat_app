import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final Function()? onPressed;
  final String textButton;
  final Color primaryColor;

  const CustomButton({Key? key,  required this.onPressed, required this.textButton, this.primaryColor = Colors.blue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(  
            
            style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(              
               borderRadius:  BorderRadius.circular(30.0),
               ),
               padding: const EdgeInsets.symmetric(vertical: 15),
               textStyle: const TextStyle( fontWeight: FontWeight.w400, fontSize: 18),
               primary:primaryColor
              
            ),         
            onPressed: onPressed ,
            child:  Text(textButton),
            
          ),
    );
  }
}