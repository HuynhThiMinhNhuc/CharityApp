import 'package:charityapp/core/interface/creatable_object.dart';
import 'package:charityapp/domain/entities/base_object.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_event.g.dart';

@JsonSerializable()
class BaseEvent extends BaseObject implements CreatableObject<BaseUser>{
  final String name;

  @override
  late BaseUser creator;

  BaseEvent({required this.name, BaseUser? creator}) {
    if (creator != null) this.creator = creator;
  }

  // factory BaseEvent.fromJson(Map<String, dynamic> json) => _$BaseEventFromJson(json);
  // Map<String, dynamic> toJson() => _$BaseEventToJson(this);

  factory BaseEvent.fromJson(Map<String, dynamic> json) => BaseEvent(
    name: json['name'] as String,
  );
  Map<String, dynamic> toJson() => <String, dynamic>{
      'name': this.name,
      'creatorId': this.creator.id,
  };
}