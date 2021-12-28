import 'package:charityapp/domain/entities/base_user.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/tag_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_infor.g.dart';

@CopyWith()
@JsonSerializable()
class EventInfor extends EventOverview {
  String? description;
  final DateTime? timeStart;
  final int numberMember;
  final int numberPost;

  EventInfor({
    required String name,
    BaseUser? creator,
    String? avatarUri,
    String? backgroundUri,
    this.description,
    this.timeStart,
    this.numberMember = 0,
    this.numberPost = 0,
    List<TagEvent> tags = const [],
    String? id,
    DateTime? timeCreate,
  }) : super(
          name: name,
          creator: creator,
          avatarUri: avatarUri,
          backgroundUri: backgroundUri,
          id: id,
          tags: tags,
          timeCreate: timeCreate,
        );

  // factory EventInfor.fromJson(Map<String, dynamic> json) => _$EventInforFromJson(json);
  // Map<String, dynamic> toJson() => _$EventInforToJson(this);

  factory EventInfor.fromJson(Map<String, dynamic> json) => EventInfor(
        name: json['name'] as String,
        avatarUri: json['avatarUri'] as String?,
        backgroundUri: json['backgroundUri'] as String?,
        description: json['description'] as String?,
        timeStart: json['timeStart'] == null
            ? null
            : (json['timeStart'] as Timestamp).toDate(),
        numberMember: json['numberMember'] as int? ?? 0,
        numberPost: json['numberPost'] as int? ?? 0,
        timeCreate: json['timeCreate'] == null
            ? null
            : (json['timeCreate'] as Timestamp).toDate(),

        // tags: (json['tags'] as List<dynamic>?)
        //         ?.map((e) => e as String)
        //         .toList() ??
        //     const [],
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
        'creatorId': this.creator.id,
        'avatarUri': this.avatarUri,
        'backgroundUri': this.backgroundUri,
        'description': this.description,
        'timeStart': this.timeStart == null
            ? null
            : Timestamp.fromDate(this.timeStart!),

        // 'numberMember': this.numberMember,
        // 'numberPost': this.numberPost,
        'tags': this.tags.map((tag) => tag.id).toList(),
        'timeCreate': this.timeCreate == null
            ? null
            : Timestamp.fromDate(this.timeCreate!),
      };
}
