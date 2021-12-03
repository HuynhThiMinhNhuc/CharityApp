import 'dart:typed_data';
import 'package:charityapp/core/uint8list_converter.dart';
import 'package:charityapp/domain/entities/base_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_overview.g.dart';

@JsonSerializable()
class EventOverview extends BaseObject{
  final String name;

  @Uint8ListConverter()
  Uint8List? avatar;
  
  @Uint8ListConverter()
  Uint8List? background;

  EventOverview({required this.name, this.avatar, this.background});

  factory EventOverview.fromJson(Map<String, dynamic> json) => _$EventOverviewFromJson(json);
  Map<String, dynamic> toJson() => _$EventOverviewToJson(this);
}