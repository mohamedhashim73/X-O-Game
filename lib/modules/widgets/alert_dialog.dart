import 'package:awesome_dialog/awesome_dialog.dart';
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

void showAlertDialog({required BuildContext context,required String message,required Color messageColor}){
  showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: Colors.grey.shade200,
      contentPadding: const EdgeInsets.symmetric(vertical: 25,horizontal: 20),
      alignment: Alignment.center,
      contentTextStyle: TextStyle(color: messageColor,fontWeight: FontWeight.w600,fontSize: 19.5),
      content : Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          FittedBox(fit:BoxFit.scaleDown,child: Text(message))
        ],
      )
  )
  );
}

AwesomeDialog awesomeDialog(BuildContext context,String message,DialogType dialogType,Color messageColor,String dialogTitle){
  return AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.bottomSlide,
      title: dialogTitle,
      titleTextStyle: TextStyle(color: messageColor,fontWeight: FontWeight.bold,fontSize: 19),
      desc: message,
      descTextStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.black.withOpacity(0.5)),
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
  )..show();
}