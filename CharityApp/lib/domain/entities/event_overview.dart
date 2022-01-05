import 'package:charityapp/core/model/event_page_state.dart';
import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:charityapp/domain/entities/tag_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_overview.g.dart';

@CopyWith()
@JsonSerializable()
class EventOverview extends BaseEvent {
  final String? avatarUri;
  final String? backgroundUri;
  final List<TagEvent> tags;
  final int numberMember;
  final int numberPost;

  EventOverview({
    required String name,
    required String creatorId,
    this.avatarUri,
    this.backgroundUri,
    String? id,
    this.tags = const [],
    DateTime? timeCreate,
    this.numberMember = 0,
    this.numberPost = 0,
  }) : super(
          name: name,
          creatorId: creatorId,
          id: id,
          timeCreate: timeCreate,
        );

  // factory EventOverview.fromJson(Map<String, dynamic> json) => _$EventOverviewFromJson(json);
  // Map<String, dynamic> toJson() => _$EventOverviewToJson(this);

  factory EventOverview.fromJson(Map<String, dynamic> json) => EventOverview(
        name: json['name'] as String,
        creatorId: json['creatorId'],
        avatarUri: json['avatarUri'] as String?,
        backgroundUri: json['backgroundUri'] as String?,
        timeCreate: json['timeCreate'] == null
            ? null
            : (json['timeCreate'] as Timestamp).toDate(),
        numberMember: json['numberMember'] as int? ?? 0,
        numberPost: json['numberPost'] as int? ?? 0,
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
        'creatorId': this.creatorId,
        'avatarUri': this.avatarUri,
        'backgroundUri': this.backgroundUri,
        'tags': this.tags.map((tag) => tag.id).toList(),
        'timeCreate': this.timeCreate == null
            ? null
            : Timestamp.fromDate(this.timeCreate!),
      };
}
