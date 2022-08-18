import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uts_reservat/res/colors.dart';
import 'package:uts_reservat/res/dimens.dart';
import 'package:uts_reservat/utils/util.dart';

Widget customImage(
    {required BuildContext context,
    double? width,
    double? height,
    BoxShape? shape,
    String? urlImage,
    double? corner}) {
  return Container(
    margin: EdgeInsets.only(right: 10),
    width: width,
    height: height,
    decoration: BoxDecoration(
      shape: shape!,
      image: DecorationImage(
        colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(opacity_70), BlendMode.dstATop),
        image: NetworkImage(urlImage!), //NetworkImage(convertUrl(urlImage!)) 
        /* urlImage != null ? urlImage != '' ? NetworkImage(convertUrl(urlImage))
                : AssetImage('lib/images/without_image.png')
            : AssetImage('lib/images/without_image.png'),*/
        fit: BoxFit.fill,
      ),
      borderRadius: BorderRadius.circular(corner!),
    ),
  );
}

Widget customImageFile(
    {required BuildContext context,
    double? width,
    double? height,
    BoxShape? shape,
    File? file,
    double? corner,
    void Function()? onClick}) {
  return Center(
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(corner!)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            file != null
                ? Image.file(file,
                    fit: BoxFit.fill, width: width, height: height)
                : Image.asset('lib/images/without_image.png',
                    fit: BoxFit.fill, width: width, height: height),
            Visibility(
              visible: file == null ? true : false,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: darkCerulean,
                child: Icon(
                  Icons.camera_alt,
                  color: white,
                  size: size_15,
                ),
                onPressed: onClick,
              ),
            )
          ],
        )),
  );
}
