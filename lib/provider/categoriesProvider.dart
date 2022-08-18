import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:uts_reservat/api/restClient.dart';
import 'package:uts_reservat/models/categoryModel.dart';

class CategoriesProvider extends ChangeNotifier {
  static Dio _dio = Dio();
  RestClient _apiClient = RestClient(_dio);
  List<CategoryModel>? categories;

  Future<List<CategoryModel>> getCategories() async {
    if (this.categories != null) {
      return categories!;
    }

    this.categories = await _apiClient.getCategories();
    notifyListeners();
    return categories!;
  }
}
