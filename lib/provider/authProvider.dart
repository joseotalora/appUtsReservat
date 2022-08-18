import 'dart:developer';

import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:uts_reservat/api/restClient.dart';
import 'package:uts_reservat/helpers/serverError.dart';
import 'package:uts_reservat/helpers/ui.dart';
import 'package:uts_reservat/helpers/validations.dart';
import 'package:uts_reservat/models/ownerModel.dart';
import 'package:uts_reservat/sessions/sessionManager.dart';
import 'package:uts_reservat/utils/constantsUtil.dart';

class AuthProvider extends ChangeNotifier {
  static Dio _dio = Dio();
  RestClient _apiClient = RestClient(_dio);
  final SessionManager _prefs = SessionManager();
  OwnerModel ownerModel = OwnerModel();
  bool viewPasswordSignIn = false;
  bool viewPasswordSignUp = false;

  void seeOrHidePasswordSignIn(bool value) {
    viewPasswordSignIn = !value;
    notifyListeners();
  }

  void seeOrHidePasswordSignUp(bool value) {
    viewPasswordSignIn = !value;
    notifyListeners();
  }

  void setOwnerValues({int? id, String name = '', String phone = '', String email = '', String password = ''}) {
    if (id != null) {
      ownerModel.id = id;
    }

    if (name.isNotEmpty) {
      ownerModel.name = name;
    }

    if (phone.isNotEmpty) {
      ownerModel.phone = phone;
    }

    if (email.isNotEmpty) {
      ownerModel.email = email;
    }

    if (password.isNotEmpty) {
      ownerModel.password = password;
    }
    notifyListeners();
  }

  void validateSignIn(BuildContext context) {
    String response = Validations.validateSignIn(context, ownerModel);
    if (response == Validations.VALIDATION_OK) {
      _signIn(context: context, ownerModel: ownerModel);
    } else {
      showInfoDialog(context: context, title: 'Informacíon', message: response);
    }
  }

  void validateSignUp(BuildContext context, OwnerModel ownerModel) {
    String response = Validations.validateSignUp(context, ownerModel);
    if (response == Validations.VALIDATION_OK) {
      _signUp(context: context, ownerModel: ownerModel);
    } else {
      showInfoDialog(context: context, title: 'Informacíon', message: response);
    }
  }

  void _signIn({required BuildContext context, required OwnerModel ownerModel}) {
    showProgressDialog(context: context);
    _apiClient
        .signIn(ownerModel: ownerModel)
        .then((authModel) => {
          debugPrint('Token: ${authModel.token}'),
              _prefs.token = authModel.token!,
              _getProfile(context: context),
            })
        .catchError((error) {
      ServerError(context: context, error: error);
    });
  }

  void _signUp({required BuildContext context, required OwnerModel ownerModel}) {
    showProgressDialog(context: context);
    _apiClient.singnUp(ownerModel: ownerModel).whenComplete(() => Navigator.of(context).pop()).then((authModel) {
      _prefs.token = authModel.token!;
      Navigator.pushReplacementNamed(context, placesHomeRoute);
    }).catchError((error) {
      ServerError(context: context, error: error);
    });
  }

  void _getProfile({required BuildContext context}) {
    _apiClient.getInfoOwner(token: _prefs.token).whenComplete(() {
      Navigator.of(context).pop();
    }).then((value) {
      //_prefs.ownerId = ownerModel.id!;
      _prefs.ownerId = value.id!;
      Navigator.pushReplacementNamed(context, placesHomeRoute);
    }).catchError((error) {
      ServerError(context: context, error: error);
    });
  }
}
