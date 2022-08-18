import 'dart:developer';

import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:uts_reservat/api/restClient.dart';
import 'package:uts_reservat/helpers/serverError.dart';
import 'package:uts_reservat/models/placeModel.dart';
import 'package:uts_reservat/res/colors.dart';
import 'package:uts_reservat/res/dimens.dart';
import 'package:uts_reservat/sessions/sessionManager.dart';
import 'package:uts_reservat/utils/constantsUtil.dart';
import 'package:uts_reservat/utils/util.dart';
import 'package:uts_reservat/widgets/appBar.dart';
import 'package:uts_reservat/widgets/card.dart';
import 'package:uts_reservat/widgets/others.dart';

class PlacesPage extends StatefulWidget {
  @override
  createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  static Dio _dio = Dio();
  RestClient _apiClient = RestClient(_dio);
  final SessionManager _prefs = SessionManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Mis lugares'),
      body: FutureBuilder<List<PlaceModel>>(
          future: _getPlaces(),
          builder: (context, snapshot) {
            inspect(snapshot.data);
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              return _setView(snapshot.data!);
            } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
              return withoutItems(message: 'Sin informacion para mostrar');
            } else if (snapshot.hasError) {
              ServerError(context: context, error: snapshot.error as DioError);
              return Container(width: double.infinity, height: double.infinity);
            }
            return customLoading();
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: white,
          ),
          backgroundColor: darkCerulean,
          onPressed: () => {
           //Navigator.pushNamed(context, placeCreationRoute)
            Navigator.pushReplacementNamed(context, placeCreationRoute)
            }),
    );
  }

  Future<List<PlaceModel>> _getPlaces() {
    return _apiClient.getOwnerPlaces(token: _prefs.token, ownerId: _prefs.ownerId);
  }

  Padding _setView(List<PlaceModel> places) {
    return Padding(
      padding: EdgeInsets.all(padding_16),
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            //height: MediaQuery.of(context).size.height * .07,
            child: 
        Expanded(child: _setPlaces(places))
      )]));
      //child: SingleChildScrollView(child: Column(children: [_setPlaces(places)])));
  }

  Widget _setPlaces(List<PlaceModel> places) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: places.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return _itemPlace(context, places, index);
        });
  }

  Widget _itemPlace(BuildContext context, List<PlaceModel> places, int index) {
    return customCard(
        context: context,
        image: getTypeImage(places[index].category!.name!),
        textTag: places[index].category!.name!,
        title: places[index].name!,
        subtitle: places[index].price!,
        onClick: () => Navigator.pushNamed(context, placeDetailOwnerRoute, arguments: places[index].id));
  }
}
