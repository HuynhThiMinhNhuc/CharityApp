import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_overview.g.dart';

@JsonSerializable()
class EventOverview extends BaseEvent{
  Uri? avatarUri;
  Uri? backgroundUri;

  EventOverview({required String name, required BaseUser creator, this.avatarUri, this.backgroundUri}) : super(name: name, creator: creator);

  factory EventOverview.fromJson(Map<String, dynamic> json) => _$EventOverviewFromJson(json);
  Map<String, dynamic> toJson() => _$EventOverviewToJson(this);
}