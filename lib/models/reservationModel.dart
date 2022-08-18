import 'package:json_annotation/json_annotation.dart';
import 'package:uts_reservat/models/clientModel.dart';
import 'package:uts_reservat/models/placeModel.dart';

part 'reservationModel.g.dart';

@JsonSerializable()
class ReservationModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'lugar')
  PlaceModel? place;
  @JsonKey(name: 'startDate')
  String? startDate;
  @JsonKey(name: 'endDate')
  String? endDate;
  @JsonKey(name: 'timeReservedStart')
  String? timeStart;
  @JsonKey(name: 'timeReservedEnd')
  String? timeEnd;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'cliente')
  ClientModel? client;

  ReservationModel(
      {this.id, this.client, this.endDate, this.place, this.startDate, this.status, this.timeEnd, this.timeStart});

  factory ReservationModel.fromJson(Map<String, dynamic> json) => _$ReservationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationModelToJson(this);
}
