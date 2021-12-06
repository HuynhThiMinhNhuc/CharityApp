import 'dart:typed_data';
import 'package:charityapp/core/helper/uint8list_converter.dart';
import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/base_object.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_overview.g.dart';

@JsonSerializable()
class EventOverview extends BaseEvent{
  @Uint8ListConverter()
  Uint8List? avatar;
  
  @Uint8ListConverter()
  Uint8List? background;

  EventOverview({required String name, required BaseUser creator, this.avatar, this.background}) : super(name: name, creator: creator);

  factory EventOverview.fromJson(Map<String, dynamic> json) => _$EventOverviewFromJson(json);
  Map<String, dynamic> toJson() => _$EventOverviewToJson(this);
}