import 'package:charityapp/core/interface/creatable_object.dart';
import 'package:charityapp/domain/entities/base_object.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_event.g.dart';

@CopyWith()
@JsonSerializable()
class BaseEvent extends BaseObject{
  final String name;
  final String creatorId;
  DateTime? timeCreate;

  BaseEvent({required this.name, required this.creatorId, String? id, this.timeCreate}) :super(id: id);

  // factory BaseEvent.fromJson(Map<String, dynamic> json) => _$BaseEventFromJson(json);
  // Map<String, dynamic> toJson() => _$BaseEventToJson(this);

  factory BaseEvent.fromJson(Map<String, dynamic> json) => BaseEvent(
    name: json['name'] as String,
    creatorId: json['creatorId'] as String,
    timeCreate: json['timeCreate'] == null
          ? null
          : (json['timeCreate'] as Timestamp).toDate(),
  );
  Map<String, dynamic> toJson() => <String, dynamic>{
      'name': this.name,
      'creatorId': this.creatorId,
      'timeCreate': this.timeCreate == null ? null : Timestamp.fromDate(this.timeCreate!),
  };

}