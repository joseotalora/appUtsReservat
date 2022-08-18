import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:uts_reservat/helpers/ui.dart';
import 'package:uts_reservat/utils/constantsUtil.dart';

class ServerError implements Exception {
  late int _errorCode;
  late String _errorMessage = "";
  late BuildContext _context;

  ServerError({required BuildContext context, required DioError error}) {
    _context = context;
    _handleError(error);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        _errorMessage = "Petición cancelada";
        break;

      case DioErrorType.connectTimeout:
        _errorMessage = "El tiempo de conexión expiro";
        break;

      case DioErrorType.other:
        _errorMessage = "Verifica tu conexión a internet";
        break;

      case DioErrorType.receiveTimeout:
        _errorMessage = "El tiempo de espera ha expirado";
        break;

      case DioErrorType.response:
        _errorCode = error.response!.statusCode!;
        switch (error.response!.statusCode) {
          case WITHOUT_AUTHORIZATION:
            _errorMessage = 'El usuario no tiene autorización';
            break;
          case WRONG_PASSWORD:
            _errorMessage = 'La contraseña ingresada es inconrrecta';
            break;
          case USER_NOT_EXIST:
            _errorMessage = 'El usuario no existe, aprovecha y registrate';
            break;
          case USER_ALREADY_EXIST:
            _errorMessage = 'Este correo electrónico ya se encuentra registrado, no te desanimes intenta con otro';
            break;
          case INTERNAL_ERROR_SERVER:
            _errorMessage = 'Presentamos problemas en el servidor, por favor intentelo mas tarde';
            break;
          case ERROR_SEARCH :
            _errorMessage = 'No se ha encontrado';
            break;
          case ERROR_SAVE :
            _errorMessage = 'Presentamos error al momento de crear o modificar el formulario';
            break;
          default: 
            _errorMessage = "Código de respuesta recibido: $_errorCode";
        }
        break;

      case DioErrorType.sendTimeout:
        _errorMessage = "El tiempo de espera al recibir la respuesta del servidor ha expirado";
        break;
    }
    
    showInfoDialog(
      context: _context, 
      title: 'Información', 
      message: _errorMessage
    );
  }
}

