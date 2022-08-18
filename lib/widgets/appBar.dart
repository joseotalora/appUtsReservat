import 'package:flutter/material.dart';
import 'package:uts_reservat/res/colors.dart';
import 'package:uts_reservat/res/dimens.dart';
import 'package:uts_reservat/res/styles.dart';

PreferredSizeWidget customAppBar({required String title}) {
  return AppBar(
      centerTitle: true,
      backgroundColor: conifer,
      iconTheme: IconThemeData(color: white),
      title: Text(title, style: textStyleBold(fontSize: text_18, color: white)));
}
