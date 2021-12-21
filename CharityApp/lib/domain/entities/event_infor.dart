import 'package:charityapp/domain/entities/base_user.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_infor.g.dart';

@CopyWith()
@JsonSerializable()
class EventInfor extends EventOverview {
  String? description;
  final String? timeStart;
  final int numberMember;
  final int numberPost;
  final List<String> tags;

  EventInfor({
    required String name,
    BaseUser? creator,
    Uri? avatarUri,
    Uri? backgroundUri,
    this.description,
    this.timeStart,
    this.numberMember = 0,
    this.numberPost = 0,
    this.tags = const [],
    String? id,
  }) : super(
            name: name,
            creator: creator,
            avatarUri: avatarUri,
            backgroundUri: backgroundUri,
            id: id);

  // factory EventInfor.fromJson(Map<String, dynamic> json) => _$EventInforFromJson(json);
  // Map<String, dynamic> toJson() => _$EventInforToJson(this);

  factory EventInfor.fromJson(Map<String, dynamic> json) => EventInfor(
        name: json['name'] as String,
        avatarUri: json['avatarUri'] == null
            ? null
            : Uri.parse(json['avatarUri'] as String),
        backgroundUri: json['backgroundUri'] == null
            ? null
            : Uri.parse(json['backgroundUri'] as String),
        description: json['description'] as String?,
        timeStart: json['timeStart'] as String?,
        numberMember: json['numberMember'] as int? ?? 0,
        numberPost: json['numberPost'] as int? ?? 0,
        tags: (json['tags'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
        'creatorId': this.creator.id,
        'avatarUri': this.avatarUri?.toString(),
        'backgroundUri': this.backgroundUri?.toString(),
        'description': this.description,
        'timeStart': this.timeStart,
        'numberMember': this.numberMember,
        'numberPost': this.numberPost,
        'tags': this.tags,
      };
}
