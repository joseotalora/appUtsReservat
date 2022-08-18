import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uts_reservat/res/colors.dart';
import 'package:uts_reservat/res/dimens.dart';
import 'package:uts_reservat/res/styles.dart';
import 'package:uts_reservat/widgets/image.dart';

Card customCard(
    {required BuildContext context,
    required String image,
    required String title,
    required String subtitle,
    required void Function() onClick,
    required String textTag}) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(corner_20)),
      child: InkWell(
          borderRadius: BorderRadius.circular(corner_20),
          child: Stack(alignment: AlignmentDirectional.topEnd, children: [
            customCardTag(context: context, backgroundColor: gossip, text: textTag),
            Padding(
                padding: EdgeInsets.all(padding_16),
                child: Container(
                    child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  customImage(
                      context: context,
                      corner: corner_20,
                      width: size_120,
                      height: size_100,
                      shape: BoxShape.rectangle,
                      urlImage: image),
                  SizedBox(width: size_20),
                  Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(height: size_20),
                    Text(title,
                        style: textStyleBold(fontSize: text_20, color: blackcurrant),
                        maxLines: line_1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: size_10),
                    Text('\u0024$subtitle',
                        style: textStyleNormal(fontSize: text_18, color: charcoal),
                        maxLines: line_1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis)
                  ]))
                ])))
          ]),
          onTap: onClick));
}

Card customCardWithoutActions(
    {required BuildContext context,
    required String date,
    required String time,
    required String price,
    required String namePlace,
    required String name,
    required String phone,
    required String email,
    required void Function() actionPositive,
    required void Function() actionNegative,
    required String textTag,
    required Color backgroundTag,
    required bool actionsVisible}) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(corner_20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        customCardTag(context: context, backgroundColor: backgroundTag, text: textTag),
        SizedBox(width: size_10),
        Padding(
            padding: EdgeInsets.all(padding_16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(date,
                  style: textStyleBold(fontSize: text_20, color: blackcurrant),
                  maxLines: line_1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis),
              SizedBox(height: size_10),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(time,
                      style: textStyleBold(fontSize: text_20, color: blackcurrant),
                      maxLines: line_1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis),
                  Text('\u0024$price',
                      style: textStyleNormal(fontSize: text_20, color: blackcurrant),
                      maxLines: line_1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis),
                ]),
              ),
              SizedBox(height: size_10),
              Text(name,
                  style: textStyleSemiBold(fontSize: text_18, color: charcoal),
                  maxLines: line_1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis),
              SizedBox(height: size_10),
              Text(phone,
                  style: textStyleSemiBold(fontSize: text_18, color: charcoal),
                  maxLines: line_1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis),
              SizedBox(height: size_10),
              Text(email,
                  style: textStyleSemiBold(fontSize: text_18, color: charcoal),
                  maxLines: line_1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis),
              Visibility(
                visible: actionsVisible,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: padding_10, vertical: padding_5),
                          child: InkWell(
                            child: Text('Rechazar',
                                style: textStyleSemiBold(fontSize: text_20, color: brandyPuch),
                                maxLines: line_1,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis),
                            onTap: actionNegative,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: padding_10, vertical: padding_5),
                            child: InkWell(
                              child: Text('Aceptar',
                                  style: textStyleSemiBold(fontSize: text_20, color: gossip),
                                  maxLines: line_1,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis),
                              onTap: actionPositive,
                            ))
                      ]),
                ),
              ),
            ])),
      ]));
}

Container customCardTag({required BuildContext context, required Color backgroundColor, required String text}) {
  return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      decoration:
          BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.only(topRight: Radius.circular(corner_20))),
      child: Padding(
          padding: EdgeInsets.all(padding_10),
          child: Text(
            text,
            style: textStyleSemiBold(fontSize: text_14, color: white),
            maxLines: line_1,
            textAlign: TextAlign.center,
          )));
}

Container customCardMap(
    {required double width,
    required double height,
    required Completer<GoogleMapController> googleMapController,
    required CameraPosition cameraPosition,
    required Set<Marker>? markers,
    required Function(LatLng) onClick}) {
  return Container(
      width: width,
      height: height,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: cameraPosition,
        myLocationEnabled: true,
        onTap: onClick,
        markers: markers!,
        onMapCreated: (GoogleMapController controller) {
          if (!googleMapController.isCompleted) {
            googleMapController.complete(controller);
          }
        },
        myLocationButtonEnabled: true,
      ));
}

Card customCardWithCheck({required String text, required bool value, void Function(bool?)? onChanged}) {
  return Card(
    color: white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(corner_10)),
    child: Padding(
        padding: EdgeInsets.all(padding_10),
        child: CheckboxListTile(
            value: value,
            activeColor: darkCerulean,
            checkColor: white,
            onChanged: onChanged,
            title: Text(text, style: textStyleNormal(color: blackcurrant, fontSize: text_16)))),
  );
}
