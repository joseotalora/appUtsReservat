import 'package:flutter/material.dart';
import 'package:uts_reservat/res/colors.dart';
import 'package:uts_reservat/res/dimens.dart';
import 'package:uts_reservat/res/styles.dart';

Widget customDropDown(
    {required void Function(dynamic) onChanged,
    required List<DropdownMenuItem<dynamic>> items,
    @required dynamic value,
    required String hint}) {
  return Container(
      padding:
          EdgeInsets.symmetric(horizontal: padding_10, vertical: padding_5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(corner_5)),
          border: Border.all(
            color: laRioja,
            width: size_1,
          ),
          color: white),
      child: DropdownButtonHideUnderline(
          child: DropdownButton(
              hint: Text(hint,
                  style: textStyleNormal(
                    fontSize: text_18,
                    color: blackcurrant,
                  )),
              isExpanded: true,
              itemHeight: size_50,
              style: textStyleNormal(fontSize: text_18, color: blackcurrant),
              items: items,
              onChanged: onChanged,
              value: value)));
}
