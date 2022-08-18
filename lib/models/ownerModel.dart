import 'package:json_annotation/json_annotation.dart';

part 'ownerModel.g.dart';

@JsonSerializable()
class OwnerModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'nombres')
  String? name = '';
  @JsonKey(name: 'telefono')
  String? phone = '';
  @JsonKey(name: 'email')
  String? email = '';
  @JsonKey(name: 'password')
  String? password = '';

  OwnerModel({this.id, this.name, this.phone, this.email, this.password});

  OwnerModel.signIn({required this.email, required this.password});

  OwnerModel.signUp({required this.name, required this.phone, required this.email, required this.password});

  OwnerModel.onlyId({required this.id});

  OwnerModel.updateOwner({required this.name, required this.phone, required this.email, required this.password});

  factory OwnerModel.fromJson(Map<String, dynamic> json) => _$OwnerModelFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerModelToJson(this);
}
