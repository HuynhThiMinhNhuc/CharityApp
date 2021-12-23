import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:charityapp/domain/entities/tag_event.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_overview.g.dart';

@CopyWith()
@JsonSerializable()
class EventOverview extends BaseEvent {
  Uri? avatarUri;
  Uri? backgroundUri;
  late List<TagEvent> tags;

  EventOverview({
    required String name,
    BaseUser? creator,
    this.avatarUri,
    this.backgroundUri,
    String? id,
    List<TagEvent>? tags,
  }) : super(
          name: name,
          creator: creator,
          id: id,
        ) {
    if (tags != null) this.tags = tags;
  }

  // factory EventOverview.fromJson(Map<String, dynamic> json) => _$EventOverviewFromJson(json);
  // Map<String, dynamic> toJson() => _$EventOverviewToJson(this);

  factory EventOverview.fromJson(Map<String, dynamic> json) => EventOverview(
        name: json['name'] as String,
        creator: BaseUser.fromJson(json['creator'] as Map<String, dynamic>),
        avatarUri: json['avatarUri'] == null
            ? null
            : Uri.parse(json['avatarUri'] as String),
        backgroundUri: json['backgroundUri'] == null
            ? null
            : Uri.parse(json['backgroundUri'] as String),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
        'creatorId': this.creator.id,
        'avatarUri': this.avatarUri?.toString(),
        'backgroundUri': this.backgroundUri?.toString(),
        'tags': this.tags.map((tag) => tag.id),
      };
}
