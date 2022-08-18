import 'package:flutter/material.dart';
import 'package:uts_reservat/models/ownerModel.dart';

class Validations {
  static String _emailFormat =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp _regExp = RegExp(_emailFormat);

  static const String VALIDATION_OK = 'ok';

  static String validateSignIn(BuildContext context, OwnerModel ownerModel) {
    if (ownerModel.email == null && ownerModel.password == null) {
      return 'Datos vacios';
    } else if (ownerModel.email == null && ownerModel.password != null) {
      return 'El correo electrónico no puede estar vacio';
    } else if (!_regExp.hasMatch(ownerModel.email!)) {
      return 'El correo electrónico no es válido';
    } else if (ownerModel.email != null && ownerModel.password == null) {
      return 'La contraseña no puede esta vacia';
    } else if (ownerModel.password!.length < 3) {
      return 'La contraseña debe tener al menos 6 dígitos';
    } else {
      return VALIDATION_OK;
    }
  }

  static String validateSignUp(BuildContext context, OwnerModel ownerModel) {
    if (ownerModel.name == null &&
        ownerModel.phone == null &&
        ownerModel.email == null &&
        ownerModel.password == null) {
      return 'Datos vacios';
    } else if (ownerModel.name == null &&
        ownerModel.phone != null &&
        ownerModel.email != null &&
        ownerModel.password != null) {
      return 'El nombre no puede estar vacio';
    } else if (ownerModel.name != null &&
        ownerModel.phone == null &&
        ownerModel.email != null &&
        ownerModel.password != null) {
      return 'El telefono no puede estar vacia';
    } else if (ownerModel.name != null &&
        ownerModel.phone != null &&
        ownerModel.email == null &&
        ownerModel.password != null) {
      return 'El correo electrónico no puede estar vacio';
    } else if (!_regExp.hasMatch(ownerModel.email!)) {
      return 'El correo electrónico no es válido';
    } else if (ownerModel.name != null &&
        ownerModel.phone != null &&
        ownerModel.email != null &&
        ownerModel.password == null) {
      return 'La contraseña no puede estar vacia';
    } else if (ownerModel.password!.length < 3) {
      return 'La contraseña debe tener al menos 6 dígitos';
    } else {
      return VALIDATION_OK;
    }
  }
}
