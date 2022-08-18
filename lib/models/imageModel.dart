import 'package:json_annotation/json_annotation.dart';

part 'imageModel.g.dart';

@JsonSerializable()
class ImageModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  ImageModel({this.id, this.name});

  factory ImageModel.fromJson(Map<String, dynamic> json) => _$ImageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}
