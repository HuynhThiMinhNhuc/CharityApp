import 'package:charityapp/core/interface/creatable_object.dart';
import 'package:charityapp/domain/entities/base_object.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_post.g.dart';

@CopyWith()
@JsonSerializable()
class BasePost extends BaseObject implements CreatableObject<UserOverview> {
  final String title;
  late String? eventId;
  late UserOverview creator;

  BasePost({
    required this.title,
    UserOverview? creator,
    this.eventId,
    String? id,
  }) : super(id: id) {
    if (creator != null) this.creator = creator;
  }

  // factory BasePost.fromJson(Map<String, dynamic> json) => _$BasePostFromJson(json);
  // Map<String, dynamic> toJson() => _$BasePostToJson(this);
  factory BasePost.fromJson(Map<String, dynamic> json) => BasePost(
        title: json['title'] as String,
        eventId: json['eventId'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': this.title,
        'creatorId': this.creator.id,
        'eventId': this.eventId,
      };
}
