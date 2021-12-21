import 'package:charityapp/core/interface/creatable_object.dart';
import 'package:charityapp/domain/entities/base_object.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_event.g.dart';

@CopyWith()
@JsonSerializable()
class BaseEvent extends BaseObject implements CreatableObject<BaseUser>{
  final String name;

  @override
  late BaseUser creator;

  BaseEvent({required this.name, BaseUser? creator, String? id}) :super(id: id) {
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