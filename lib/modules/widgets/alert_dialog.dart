import 'package:flutter/material.dart';

SnackBar snackBarContent({required String message,required Color backgroundColor}){
  return SnackBar(
    duration: const Duration(seconds: 1),
    margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    backgroundColor: backgroundColor,
    content: Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8)
      ),
      alignment: Alignment.center,
      child: FittedBox(fit:BoxFit.scaleDown,child: Text(message,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17.5),)),
    ),
  );
}