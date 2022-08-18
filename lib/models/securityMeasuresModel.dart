import 'package:json_annotation/json_annotation.dart';

part 'securityMeasuresModel.g.dart';

@JsonSerializable()
class SecurityMeasuresModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'medida')
  String? name;

  SecurityMeasuresModel({this.id, this.name});

  SecurityMeasuresModel.newSecurityMeasureID({required int this.id});

  factory SecurityMeasuresModel.fromJson(Map<String, dynamic> json) => _$SecurityMeasuresModelFromJson(json);

  Map<String, dynamic> toJson() => _$SecurityMeasuresModelToJson(this);
}
