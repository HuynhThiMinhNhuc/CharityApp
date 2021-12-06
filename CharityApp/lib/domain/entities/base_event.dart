import 'package:charityapp/core/interface/creatable_object.dart';
import 'package:charityapp/domain/entities/base_object.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_event.g.dart';

@JsonSerializable()
class BaseEvent extends BaseObject implements CreatableObject<BaseUser>{
  final String name;

  @override
  BaseUser creator;

  BaseEvent({required this.name, required this.creator});

  factory BaseEvent.fromJson(Map<String, dynamic> json) => _$BaseEventFromJson(json);
  Map<String, dynamic> toJson() => _$BaseEventToJson(this);


}