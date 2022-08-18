import 'package:geolocator/geolocator.dart';

Future<Position> getLocation() async {
  bool _serviceEnabled;
  LocationPermission _permission;

  _serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if(!_serviceEnabled){
    return Future.error('La ubicación no esta activada');
  }else{
    _permission = await _validatePermission();
  }

  if(_permission == LocationPermission.always || _permission == LocationPermission.whileInUse){
    return await Geolocator.getCurrentPosition();
  }

  return Future.error('El permiso de ubicacion es necesario, aceptalo para poder continuar');
}

Future<LocationPermission> _validatePermission() async{
  LocationPermission _permission = await Geolocator.requestPermission();
  return _permission;
}