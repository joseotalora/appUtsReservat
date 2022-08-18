import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:uts_reservat/api/restClient.dart';
import 'package:uts_reservat/helpers/serverError.dart';
import 'package:uts_reservat/helpers/ui.dart';
import 'package:uts_reservat/models/reservationModel.dart';
import 'package:uts_reservat/utils/constantsUtil.dart';
import 'package:uts_reservat/utils/util.dart';

class ReservationClientProvider extends ChangeNotifier {
  static Dio _dio = Dio();
  RestClient _apiClient = RestClient(_dio);

  void sendReservation({required BuildContext context, required ReservationModel reservationModel}) {
    showProgressDialog(context: context);
    _apiClient.newReservation(reservationModel: reservationModel).then((value) {
      showToast(message: 'Reserva enviada exitosamente');
      Navigator.pushReplacementNamed(context, placesHomeRoute);
    }).catchError((error) {
      ServerError(context: context, error: error);
    });
  }
}
