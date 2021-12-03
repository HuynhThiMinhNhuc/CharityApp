import 'dart:typed_data';
import 'package:charityapp/core/helper/uint8list_converter.dart';
import 'package:charityapp/domain/entities/base_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_overview.g.dart';

@JsonSerializable()
class UserOverview extends BaseObject{
  String name;

  @Uint8ListConverter()
  Uint8List? avatar;

  UserOverview({required this.name, required this.avatar});

  factory UserOverview.fromJson(Map<String, dynamic> json) => _$UserOverviewFromJson(json);
  Map<String, dynamic> toJson() => _$UserOverviewToJson(this);
}