import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:charityapp/domain/entities/tag_event.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_overview.g.dart';

@CopyWith()
@JsonSerializable()
class EventOverview extends BaseEvent {
  final String? avatarUri;
  final String? backgroundUri;
  final List<TagEvent> tags;

  EventOverview({
    required String name,
    BaseUser? creator,
    this.avatarUri,
    this.backgroundUri,
    String? id,
    this.tags = const[],
  }) : super(
          name: name,
          creator: creator,
          id: id,
        );

  // factory EventOverview.fromJson(Map<String, dynamic> json) => _$EventOverviewFromJson(json);
  // Map<String, dynamic> toJson() => _$EventOverviewToJson(this);

  factory EventOverview.fromJson(Map<String, dynamic> json) => EventOverview(
        name: json['name'] as String,
        creator: BaseUser.fromJson(json['creator'] as Map<String, dynamic>),
        avatarUri: json['avatarUri'] as String?,
        backgroundUri: json['backgroundUri'] as String?,
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
        'creatorId': this.creator.id,
        'avatarUri': this.avatarUri,
        'backgroundUri': this.backgroundUri,
        'tags': this.tags.map((tag) => tag.id).toList(),
      };
}
