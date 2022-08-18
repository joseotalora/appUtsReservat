import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uts_reservat/api/restClient.dart';
import 'package:uts_reservat/helpers/serverError.dart';
import 'package:uts_reservat/models/placeModel.dart';
import 'package:uts_reservat/res/colors.dart';
import 'package:uts_reservat/res/dimens.dart';
import 'package:uts_reservat/res/styles.dart';
import 'package:uts_reservat/sessions/sessionManager.dart';
import 'package:uts_reservat/utils/constantsUtil.dart';
import 'package:uts_reservat/widgets/appBar.dart';
import 'package:uts_reservat/widgets/button.dart';
import 'package:uts_reservat/widgets/card.dart';
import 'package:uts_reservat/widgets/image.dart';
import 'package:uts_reservat/widgets/others.dart';

class PlaceDetailOwnerPage extends StatefulWidget {
  final int placeId;

  @override
  createState() => _PlaceDetailOwnerPageState();

  PlaceDetailOwnerPage(this.placeId);
}

class _PlaceDetailOwnerPageState extends State<PlaceDetailOwnerPage> {
  static Dio _dio = Dio();
  RestClient _apiClient = RestClient(_dio);
  final SessionManager _prefs = SessionManager();
  Future<PlaceModel>? _future;
  int? _placeId;
  Completer<GoogleMapController> _googleMapController = Completer();

  @override
  void initState() {
    super.initState();
    _placeId = widget.placeId;
    _future = _getPlaceDetail() as Future<PlaceModel>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: 'Detalle de lugar'),
        body: FutureBuilder<PlaceModel>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return _setView(context, snapshot.data!);
              } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
                return withoutItems(message: 'Sin informacion para mostrar');
              } else if (snapshot.hasError) {
                ServerError(context: context, error: snapshot.error as DioError);
                return Container(width: double.infinity, height: double.infinity);
              }
              return customLoading();
            }));
  }

  Future _getPlaceDetail() {
    return _apiClient.getPlaceDetail(placeId: _placeId!);
  }

  Set<Marker> _addMarker(PlaceModel placeModel) {
    Set<Marker> marker = Set();
    marker.add(Marker(
      markerId: MarkerId('${placeModel.id}'),
      infoWindow: InfoWindow(title: '${placeModel.name}', snippet: '${placeModel.description}'),
      position: LatLng(double.parse(placeModel.latitude!), double.parse(placeModel.longitude!)),
    ));
    return marker;
  }

  Widget _setView(BuildContext context, PlaceModel placeModel) {
    return SingleChildScrollView(
        child: Column(children: [
      customCardMap(
          width: MediaQuery.of(context).size.width,
          height: size_200,
          googleMapController: _googleMapController,
          cameraPosition: CameraPosition(
              target: LatLng(double.parse(placeModel.latitude!), double.parse(placeModel.longitude!)), zoom: 16),
          markers: _addMarker(placeModel),
          onClick: (position) => null),
      Padding(
          padding: EdgeInsets.all(padding_20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              placeModel.name!,
              style: textStyleSemiBold(color: blackcurrant, fontSize: text_18),
            ),
            SizedBox(height: size_20),
            Text('\u0024${placeModel.price}', style: textStyleSemiBold(color: blackcurrant, fontSize: text_16)),
            SizedBox(height: size_20),
            Text(
              'Descripción',
              style: textStyleSemiBold(color: blackcurrant, fontSize: text_16),
            ),
            SizedBox(height: size_10),
            Text(
              placeModel.description!,
              style: textStyleNormal(color: blackcurrant, fontSize: text_16),
            ),
            SizedBox(height: size_20),
            Text(
              'Galeria',
              style: textStyleSemiBold(color: blackcurrant, fontSize: text_16),
            ),
            SizedBox(height: size_20),
            Container(height: MediaQuery.of(context).size.height * 0.20, child: Container(child: _galeria(placeModel))),
            SizedBox(height: size_40),
            customButton(
                context: context,
                text: 'Ver Reservaciones',
                backgroundColor: brandyPuch,
                onClick: () => Navigator.pushNamed(context, reservationsRoute, arguments: placeModel.id))
          ]))
    ]));
  }

  Widget _galeria(PlaceModel placeModel) {
    log('------------------ Detalle Item');
    inspect(placeModel);
    return ListView.builder(
        shrinkWrap: true,
        itemCount: placeModel.images!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _itemImage(context, placeModel, index);
        });
  }

  Widget _itemImage(BuildContext context, PlaceModel place, int index) {
   
    return customImage(
        context: context,
        corner: corner_20,
        width: size_180,
        height: size_100,
        shape: BoxShape.rectangle,
        urlImage: URL_STORAGE + place.images![index].name.toString() + PARAMS_STORAGE + place.images![index].name.toString()
        );
  }
}
