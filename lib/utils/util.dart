import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uts_reservat/utils/constantsUtil.dart';

showToast({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM);
}

addLog({@required message}) {
  print('### UTS Reservat Log: $message ###');
}

String convertUrl(String path) {
  return '$URL_STORAGE$path$PARAMS_STORAGE$path';
}

String applyDateFormatForServer(String dateTime) {
  String df = DateFormat('yyyy-MM-dd').format(DateTime.parse(dateTime));
  return df;
}

String convertTime24HWithSeconds(String dateTime) {
  String tf = DateFormat('HH:mm:ss').format(DateTime.parse(dateTime));
  return tf;
}

String convertTime12H(String dateTime) {
  String tf = DateFormat('KK:mm aa').format(DateTime.parse(dateTime));
  return tf;
}

String newDateTime(String time){
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  return '$date $time';
}

String createDateTime(DateTime date, TimeOfDay time){
  DateTime dt = DateTime(DateTime.now().year, DateTime.now().month,  DateTime.now().day, time.hourOfPeriod, time.minute);
  return dt.toString();
}

String applyDateFormatForUser(String date) {
  String df = DateFormat('dd/MM/yyyy').format(DateTime.parse(date));
  return df;
}

String applyTimeFormatForUser(BuildContext context, TimeOfDay time) {
  String tf = time.format(context).toString();
  return tf;
}

String getTypeImage(String category) {
    String url = '';
    switch (category) {
      case 'FINCAS':
        url = 'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80';
        break;
      case 'HOTELES':
        url =  'https://images.unsplash.com/photo-1622041173930-3e72c82cb5a8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=686&q=80';
        break;
      case 'RESTAURANTES':
        url =  'https://images.unsplash.com/photo-1592861956120-e524fc739696?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80';
        break;
      default:
        url = '';        
    }
    return url;
  }