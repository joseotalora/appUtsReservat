import 'package:flutter/material.dart';
import 'package:uts_reservat/models/placeModel.dart';
import 'package:uts_reservat/pages/client/places/placeDetailClientPage.dart';
import 'package:uts_reservat/pages/client/places/placesHomePage.dart';
import 'package:uts_reservat/pages/client/reservation/reservationCreationPage.dart';
import 'package:uts_reservat/pages/owner/auth/signInPage.dart';
import 'package:uts_reservat/pages/owner/auth/signUpPage.dart';
import 'package:uts_reservat/pages/owner/places/placeCreationPage.dart';
import 'package:uts_reservat/pages/owner/places/placeDetailOwnerPage.dart';
import 'package:uts_reservat/pages/owner/places/placesPage.dart';
import 'package:uts_reservat/pages/owner/profile/profilePage.dart';
import 'package:uts_reservat/pages/owner/reservation/reservationsPage.dart';
import 'package:uts_reservat/utils/constantsUtil.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    // Client routes
    placesHomeRoute: (context) => PlacesHomePage(),
    placeDetailClientRoute: (context) =>
        PlaceDetailClientPage(int.parse(ModalRoute.of(context)!.settings.arguments.toString())),
    reservationCreationRoute: (context) =>
        ReservationCreationPage(ModalRoute.of(context)!.settings.arguments as PlaceModel),
    // Owner routes
    signInRoute: (context) => SignInPage(),
    signUpRoute: (context) => SignUpPage(),
    placeCreationRoute: (context) => PlaceCreationPage(),
    placeDetailOwnerRoute: (context) =>
        PlaceDetailOwnerPage(int.parse(ModalRoute.of(context)!.settings.arguments.toString())),
    placesRoute: (context) => PlacesPage(),
    profileRoute: (context) => ProfilePage(),
    reservationsRoute: (context) => ReservationsPage(int.parse(ModalRoute.of(context)!.settings.arguments.toString()))
  };
}
