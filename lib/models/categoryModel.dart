import 'package:json_annotation/json_annotation.dart';

part 'categoryModel.g.dart';

@JsonSerializable()
class CategoryModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'category')
  String? name;

  CategoryModel({this.id, this.name});

  CategoryModel.onlyId({required this.id});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
