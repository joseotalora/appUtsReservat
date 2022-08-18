import 'package:json_annotation/json_annotation.dart';

part 'clientModel.g.dart';

@JsonSerializable()
class ClientModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'email')
  String? email;

  ClientModel({this.id, this.name, this.phone, this.email});

  factory ClientModel.fromJson(Map<String, dynamic> json) => _$ClientModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClientModelToJson(this);
}
