import 'package:flutter/material.dart';

class DetailsText extends StatelessWidget{
  final String head;
  final String value;
  const DetailsText({super.key, required this.head, required this.value});

  @override  
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: RichText(
          text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
              TextSpan(text: head, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              TextSpan(text: value, style: const TextStyle(fontSize: 15,fontWeight: FontWeight.normal)),
          ],
          ),
      ),
      ),
    );
  }
}