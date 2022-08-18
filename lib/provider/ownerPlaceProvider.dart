import 'package:flutter/material.dart';
import 'package:uts_reservat/api/restClient.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:uts_reservat/models/placeModel.dart';

class OwnerPlaceProvider extends ChangeNotifier{
  static Dio _dio = Dio();
  RestClient _apiClient = RestClient(_dio); 
  late List<PlaceModel> places;

  Future<List<PlaceModel>> getOwnerPlaces({required String token, required int ownerId}) async {
    if(this.places.isNotEmpty){
      return places;
    }

    this.places = await _apiClient.getOwnerPlaces(token: token, ownerId: ownerId);
    notifyListeners();
    return places;
  }
} 