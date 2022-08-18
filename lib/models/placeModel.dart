import 'package:json_annotation/json_annotation.dart';
import 'package:uts_reservat/models/categoryModel.dart';
import 'package:uts_reservat/models/imageModel.dart';
import 'package:uts_reservat/models/ownerModel.dart';
import 'package:uts_reservat/models/reservationModel.dart';
import 'package:uts_reservat/models/securityMeasuresModel.dart';

part 'placeModel.g.dart';

@JsonSerializable()
class PlaceModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'capacidad')
  String? capacity;
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;
  @JsonKey(name: 'propietario')
  OwnerModel? owner;
  @JsonKey(name: 'price')
  String? price;
  @JsonKey(name: 'categoriaServicio')
  CategoryModel? category;
  @JsonKey(name: 'imagenes')
  List<ImageModel>? images;
  @JsonKey(name: 'medidasProteccionChildren')
  List<SecurityMeasuresModel>? securityMeasures;
  @JsonKey(name: 'reservas')
  List<ReservationModel>? reservations;

  PlaceModel(
      {this.id,
      this.name,
      this.description,
      this.category,
      this.capacity,
      this.images,
      this.latitude,
      this.longitude,
      this.owner,
      this.price,
      this.reservations,
      this.securityMeasures});

  PlaceModel.newPlace(
      {required this.name,
      required this.description,
      required this.latitude,
      required this.longitude,
      required this.capacity,
      required this.owner,
      required this.price,
      required this.category,
      required this.securityMeasures});

  PlaceModel.onlyId({this.id});

  factory PlaceModel.fromJson(Map<String, dynamic> json) => _$PlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);
}
