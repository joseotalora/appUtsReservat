import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:uts_reservat/api/restClient.dart';
import 'package:uts_reservat/models/securityMeasuresModel.dart';

class SecurityMeasuresProvider extends ChangeNotifier {
  static Dio _dio = Dio();
  RestClient _apiClient = RestClient(_dio);
  List<SecurityMeasuresModel>? securityMeasures;

  Future<List<SecurityMeasuresModel>> getSecurityMeasures() async {
    if (this.securityMeasures != null) {
      return securityMeasures!;
    }

    this.securityMeasures = await _apiClient.getSecurityMeasures();
    notifyListeners();
    return securityMeasures!;
  }
}


/*
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:uts_reservat/api/restClient.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:uts_reservat/models/securityMeasuresModel.dart';
import 'package:uts_reservat/sessions/sessionManager.dart';

class SecurityMeasuresProvider extends ChangeNotifier{
  static Dio _dio = Dio();
  RestClient _apiClient = RestClient(_dio); 
  late List<SecurityMeasuresModel> securityMeasures;
  final SessionManager _prefs = SessionManager();

  Future<List<SecurityMeasuresModel>> getSecurityMeasures() async {
    if(this.securityMeasures.isNotEmpty){
      return securityMeasures;
    }

    this.securityMeasures = await _apiClient.getSecurityMeasures();//token: _prefs.token
    
    notifyListeners();
    return securityMeasures;
  }
}
*/