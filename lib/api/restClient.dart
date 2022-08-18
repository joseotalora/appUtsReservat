import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uts_reservat/models/authModel.dart';
import 'package:uts_reservat/models/categoryModel.dart';
import 'package:uts_reservat/models/ownerModel.dart';
import 'package:uts_reservat/models/placeModel.dart';
import 'package:uts_reservat/models/reservationModel.dart';
import 'package:uts_reservat/models/securityMeasuresModel.dart';
import 'package:uts_reservat/res/dimens.dart';
import 'package:uts_reservat/utils/constantsUtil.dart';

part 'restClient.g.dart';

@RestApi(baseUrl: BASE_ADDRESS)
abstract class RestClient {
  factory RestClient(Dio dio) {
    dio.options = BaseOptions(receiveTimeout: time_20, connectTimeout: time_20);
    return _RestClient(dio);
  }

  // --------- ENDPOINTS ---------

  @POST('$ITEM_URL/authenticate')
  Future<AuthModel> signIn({@Body() required OwnerModel ownerModel});

  @POST('$ITEM_URL/propietario')
  Future<AuthModel> singnUp({@Body() required OwnerModel ownerModel});

  //@POST('$ITEM_URL/...')
  //Future<...> resetPassword({@Body() String email})

  @GET('$ITEM_URL/validarToken/infoPropietario')
  Future<OwnerModel> getInfoOwner(
      {@Header('Authorization') required String token});

  @PUT('$ITEM_URL/propietario/{id}')
  Future<OwnerModel> updateOwner(
      {@Header('Authorization') required String token,
      @Path('id') required int ownerId,
      @Body() required OwnerModel ownerModel});

  @GET('$ITEM_URL/medidasproteccion')
  Future<List<SecurityMeasuresModel>> getSecurityMeasures();
  //Future<List<SecurityMeasuresModel>> getSecurityMeasures({@Header('Authorization') required String token});

  @POST('$ITEM_URL/lugar')
  Future<PlaceModel> newPlace(
      {@Header('Authorization') required String token,
      @Body() required PlaceModel placeModel});

  @GET('$ITEM_URL/lugar/findAll')
  Future<List<PlaceModel>> getPlaces();

  @POST('$ITEM_URL/lugar/guardarImagen/{id}')
  @MultiPart()
  Future<String> uploadImage(
      {@Header('Authorization') required String token,
      @Path('id') required int placeId,
      @Part(name: 'file') required File image});

  @GET('$ITEM_URL/lugar/byPropietario/{id}')
  Future<List<PlaceModel>> getOwnerPlaces(
      {@Header('Authorization') required String token,
      @Path('id') required int ownerId});

  @GET('$ITEM_URL/categoriaServicio')
  Future<List<CategoryModel>> getCategories();

  @GET('$ITEM_URL/lugar/byId/{id}')
  Future<PlaceModel> getPlaceDetail({@Path('id') required int placeId});

  @POST('$ITEM_URL/reserva')
  Future<ReservationModel> newReservation(
      {@Body() required ReservationModel reservationModel});

  @GET('$ITEM_URL/lugar/findReservas/{id}')
  Future<PlaceModel> getOwnerReservations(
      {@Header('Authorization') required String token,
      @Path('id') required int placeId});

  @POST('$ITEM_URL/reserva/validarReserva/{id}/{status}')
  Future<ReservationModel> updateStatusReservation(
      {@Header('Authorization') required String token,
      @Path('id') required int reservationId,
      @Path('status') required String status});
}
