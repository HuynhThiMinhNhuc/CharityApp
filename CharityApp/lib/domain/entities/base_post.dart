import 'package:charityapp/domain/entities/base_object.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_post.g.dart';

@JsonSerializable()
class BasePost extends BaseObject {
  final String title;
  late UserOverview creator;

  BasePost({required this.title, UserOverview? creator}) {
    if (creator != null) this.creator = creator;
  }

  // factory BasePost.fromJson(Map<String, dynamic> json) => _$BasePostFromJson(json);
  // Map<String, dynamic> toJson() => _$BasePostToJson(this);
  factory BasePost.fromJson(Map<String, dynamic> json) => BasePost(
      title: json['title'] as String,
    );

Map<String, dynamic> toJson() => <String, dynamic>{
      'title': this.title,
      'creatorId': this.creator.id,
    };
}