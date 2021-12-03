import 'dart:typed_data';

import 'package:charityapp/core/helper/uint8list_converter.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_infor.g.dart';

@JsonSerializable()
class EventInfor extends EventOverview{
  String? description;
  final String? timeStart;
  final int numberMember;
  final int numberPost;
  final List<String> tags;

  EventInfor({required String name, 
      required Uint8List? avatar, 
      required Uint8List? background, 
      this.description, 
      this.timeStart,
      this.numberMember = 0,
      this.numberPost = 0,
      this.tags = const [],
  }) : super(name: name, avatar: avatar, background: background);

  factory EventInfor.fromJson(Map<String, dynamic> json) => _$EventInforFromJson(json);
  Map<String, dynamic> toJson() => _$EventInforToJson(this);
}