import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/base_object.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:charityapp/domain/entities/tag_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_detail.g.dart';

@CopyWith()
@JsonSerializable()
class EventDetail extends BaseObject {
  late BaseUser creator;
  final DateTime? timeCreate;
  final DateTime? timeStart;
  late int numberMember;
  final String? description;
  final String? location;
  List<TagEvent> tags;

  EventDetail({
    BaseUser? creator,
    required this.description,
    String? id,
    this.tags = const [],
    required this.timeCreate,
    required this.timeStart,
    this.numberMember = 0,
    this.location,
  }) : super(id: id) {
    if (creator != null) this.creator = creator;
  }

  // factory EventOverview.fromJson(Map<String, dynamic> json) => _$EventOverviewFromJson(json);
  // Map<String, dynamic> toJson() => _$EventOverviewToJson(this);

  factory EventDetail.fromJson(Map<String, dynamic> json) => EventDetail(
        timeCreate: json['timeCreate'] == null
            ? null
            : (json['timeCreate'] as Timestamp).toDate(),
        description:
            json['description'] == null ? null : json['description'] as String,
        timeStart: json['timeStart'] == null
            ? null
            : (json['timeStart'] as Timestamp).toDate(),
        location: json['location'],
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'creatorId': this.creator.id,
        'tags': this.tags.map((tag) => tag.id!).toList(),
        'timeCreate': this.timeCreate == null
            ? null
            : Timestamp.fromDate(this.timeCreate!),
        'description': this.description,
        'timeStart':
            this.timeStart == null ? null : Timestamp.fromDate(this.timeStart!),
            'location': this.location,
      };
}
