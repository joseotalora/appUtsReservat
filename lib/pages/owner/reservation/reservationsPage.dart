import 'dart:developer';

import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:uts_reservat/api/restClient.dart';
import 'package:uts_reservat/helpers/serverError.dart';
import 'package:uts_reservat/helpers/ui.dart';
import 'package:uts_reservat/models/placeModel.dart';
import 'package:uts_reservat/res/colors.dart';
import 'package:uts_reservat/res/dimens.dart';
import 'package:uts_reservat/sessions/sessionManager.dart';
import 'package:uts_reservat/utils/util.dart';
import 'package:uts_reservat/widgets/appBar.dart';
import 'package:uts_reservat/widgets/card.dart';
import 'package:uts_reservat/widgets/others.dart';

class ReservationsPage extends StatefulWidget {
  final int placeId;

  @override
  createState() => _ReservationsPageState();
  ReservationsPage(this.placeId);
}

class _ReservationsPageState extends State<ReservationsPage> {
  static Dio _dio = Dio();
  RestClient _apiClient = RestClient(_dio);
  final SessionManager _prefs = SessionManager();
  Future<PlaceModel>? _future;
  int? _placeId;

  @override
  void initState() {
    super.initState();
    _placeId = widget.placeId;
    _future = _getReservations() as Future<PlaceModel>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: 'Reservaciones'),
        body: FutureBuilder<PlaceModel>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return _setView(snapshot.data!);
              } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
                return withoutItems(message: 'Sin informacion para mostrar');
              } else if (snapshot.hasError) {
                ServerError(context: context, error: snapshot.error as DioError);
                return Container(width: double.infinity, height: double.infinity);
              }
              return customLoading();
            }));
  }

  Future _getReservations() {
    return _apiClient.getOwnerReservations(token: _prefs.token, placeId: _placeId!);
  }

  Widget _setView(PlaceModel placeModel) {
    return Padding(
        padding: EdgeInsets.all(padding_16),
        child: ListView.builder(
            itemCount: placeModel.reservations!.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return _itemReservation(context, placeModel, index);
            }));
  }

  Widget _itemReservation(BuildContext context, PlaceModel placeModel, int index) {
    return customCardWithoutActions(
        context: context,
        textTag: placeModel.reservations![index].status == 'P'
            ? 'Pendiente'
            : placeModel.reservations![index].status == 'R'
                ? 'Rechazada'
                : 'Aceptada',
        backgroundTag: placeModel.reservations![index].status == 'P'
            ? shandyLady
            : placeModel.reservations![index].status == 'R'
                ? brandyPuch
                : gossip,
        date:
            '${applyDateFormatForUser(placeModel.reservations![index].startDate!)} a ${applyDateFormatForUser(placeModel.reservations![index].endDate!)}',
        time: '${placeModel.reservations![index].timeStart} a ${placeModel.reservations![index].timeEnd} ',
        price: placeModel.price!,
        namePlace: placeModel.name!,
        name: placeModel.reservations![index].client!.name!,
        phone: placeModel.reservations![index].client!.phone!,
        email: placeModel.reservations![index].client!.email!,
        actionsVisible: placeModel.reservations![index].status == 'P' ? true : false,
        actionNegative: () => _updateStatus(context, placeModel, index, 'R'),
        actionPositive: () => _updateStatus(context, placeModel, index, 'A'));
  }

  void _updateStatus(BuildContext context, PlaceModel placeModel, int index, String status) {
    showProgressDialog(context: context);
    _apiClient
        .updateStatusReservation(
          token: _prefs.token,
          reservationId: placeModel.reservations![index].id!,
          status: status,
        )
        .whenComplete(() => Navigator.of(context).pop())
        .then((value) {
          setState(() {
            _future = _getReservations() as Future<PlaceModel>?; 
          });
          showToast(message: 'Se ha cambiado el estatus a $status');
    }).catchError((error) {
      ServerError(context: context, error: error);
    });
  }
}
