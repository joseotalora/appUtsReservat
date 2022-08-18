import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uts_reservat/api/restClient.dart';
import 'package:uts_reservat/helpers/serverError.dart';
import 'package:uts_reservat/models/placeModel.dart';
import 'package:uts_reservat/sessions/sessionManager.dart';
import 'package:uts_reservat/utils/util.dart';
import 'package:uts_reservat/utils/constantsUtil.dart';

class PlaceProvider extends ChangeNotifier {
  static Dio _dio = Dio();
  RestClient _apiClient = RestClient(_dio);
  List<PlaceModel>? startPlaces;
  List<PlaceModel>? places;
  List<PlaceModel>? placesSortBy;
  final SessionManager _prefs = SessionManager();
  LatLng? location;
  PlaceModel? dataNewPlace;
  bool uploadFile = true;

  void addedLocation(LatLng position) {
    location = position;
    notifyListeners();
  }

  void removePosition() {
    location = null;
    notifyListeners();
  }

  Future<List<PlaceModel>> getPlaces() async {
    if (this.places != null) {
      return this.places!;
    }

    this.places = await _apiClient.getPlaces();
    this.startPlaces = places;
    //this.placesSortBy.addAll(this.places);
    notifyListeners();
    return this.places!;
  }

  List<PlaceModel> filterPlaces(String filter) {
    if (filter != 'ALL') {
      placesSortBy = startPlaces!
          .where((element) => element.category!.name == filter)
          .toList();
      places = placesSortBy;
    } else {
      places = startPlaces;
    }

    notifyListeners();
    return places!;
  }

  //Future<void>? newPlace({required context, required PlaceModel placeModel}) async {
  /*Future<PlaceModel> newPlace_OLD({required context, required PlaceModel placeModel}) async {

    this.newDataPlace = null;
    
    var result = await _apiClient
        .newPlace(
          token: _prefs.token,
          placeModel: placeModel,
        )
        .whenComplete(() => {Navigator.of(context).pop()})
        .then((value) => {
          this.newDataPlace = value,
      showToast(message: 'Lugar creado exitosamente'),
      Navigator.pushReplacementNamed(context, placesHomeRoute)
    }).catchError((error) {
      ServerError(context: context, error: error);
    });

    notifyListeners();
    return newDataPlace!;
    
  }*/

  Future<PlaceModel> newPlace(
      {required context, required PlaceModel placeModel}) async {
    this.dataNewPlace = await _apiClient.newPlace(
      token: _prefs.token,
      placeModel: placeModel,
    );
    notifyListeners();
    return this.dataNewPlace!;
  }

  Future uploadImageFile(
      {required String token,
      required int placeId,
      required File image}) async {
    return await _apiClient.uploadImage(
        token: token, placeId: placeId, image: image);
    //return this.uploadFile;
  }
}
