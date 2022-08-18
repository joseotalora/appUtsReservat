
import 'package:flutter/material.dart';
import 'package:uts_reservat/res/colors.dart';
import 'package:uts_reservat/res/dimens.dart';

// ---------- Text styles ----------
TextStyle textStyleNormal({required Color color, required double fontSize, TextDecoration? textDecoration}){
  return TextStyle(
    decoration: textDecoration,
    fontSize: fontSize,
    color: color,
    fontFamily: 'OpenSans',
  );
}

TextStyle textStyleSemiBold({required Color color, required double fontSize}){
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w600
  );
}

TextStyle textStyleBold({required Color color, required double fontSize}){
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w800,
  );
}

// ---------- Button styles ----------
ButtonStyle buttonStyle ({required double corners, required Color backgroundColor}){
  return ButtonStyle(
    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(corners))),
    backgroundColor: MaterialStateProperty.all(backgroundColor),
    textStyle: MaterialStateProperty.all(
      textStyleNormal(
        fontSize: text_18, 
        color: white
      )
    ),
  );
}
