import 'package:flutter/material.dart';
import 'package:uts_reservat/res/colors.dart';
import 'package:uts_reservat/res/dimens.dart';
import 'package:uts_reservat/res/styles.dart';

Widget customButton(
    {required BuildContext context,
    required String text,
    required void Function() onClick,
    Color? backgroundColor}) {
  return Center(
    child: ElevatedButton(
      style: buttonStyle(
          backgroundColor:
              backgroundColor == null ? darkCerulean : backgroundColor,
          corners: corner_10),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: size_50,
        child: Center(
          child: Text(text,
              style: textStyleNormal(color: white, fontSize: text_18)),
        ),
      ),
      onPressed: onClick,
    ),
  );
}

Widget customButtomCamera(
    {required double width,
    required double height,
    required void Function() onClick}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        border: Border.all(color: irisBlue),
        borderRadius: BorderRadius.all(Radius.circular(corner_20))),
    child: InkWell(
        child: Center(
      child: Icon(
        Icons.camera_alt,
        color: irisBlue,
      ),
    )),
  );
}
