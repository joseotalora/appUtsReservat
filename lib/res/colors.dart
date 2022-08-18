import 'package:flutter/material.dart';

//0xFF + color hexadecimal
MaterialColor white = MaterialColor(0xffFCFCFC, _getColorVariants(0xffFCFCFC));
MaterialColor shandyLady = MaterialColor(0xff9E9C9D, _getColorVariants(0xff9E9C9D));
MaterialColor charcoal = MaterialColor(0xff4A4545, _getColorVariants(0xff4A4545));
MaterialColor blackcurrant = MaterialColor(0xff0E0C11, _getColorVariants(0xff0E0C11));
MaterialColor brandyPuch = MaterialColor(0xffBF7B49, _getColorVariants(0xffBF7B49));
MaterialColor irisBlue = MaterialColor(0xff16B7CC, _getColorVariants(0xff16B7CC));
MaterialColor darkCerulean = MaterialColor(0xff0B4A75, _getColorVariants(0xff0B4A75));
MaterialColor laRioja = MaterialColor(0xffC8D200, _getColorVariants(0xffC8D200));
MaterialColor conifer = MaterialColor(0xffB1DF63, _getColorVariants(0xffB1DF63));
MaterialColor gossip = MaterialColor(0xff90C27B, _getColorVariants(0xff90C27B));

Map<int, Color> _getColorVariants(int color){
  Map<int, Color> colorVariants = {
    50:Color(color),
    100:Color(color),
    200:Color(color),
    300:Color(color),
    400:Color(color),
    500:Color(color),
    600:Color(color),
    700:Color(color),
    800:Color(color),
    900:Color(color),
  };
  return colorVariants;
}