import 'package:charityapp/domain/entities/base_object.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_comment.g.dart';

@CopyWith()
@JsonSerializable()
class UserComment extends BaseObject{
  final String name;
  final String? avatarUri;
  final String content;
  final DateTime timeComment;
  // final double nlp;

  UserComment({
    required this.name,
    required this.avatarUri,
    required this.content,
    required this.timeComment,
    // this.nlp = 0,
    String? id,
  }) : super(id: id);

  // factory UserComment.fromJson(Map<String, dynamic> json) => _$UserCommentFromJson(json);
  // Map<String, dynamic> toJson() => _$UserCommentToJson(this);

  factory UserComment.fromJson(Map<String, dynamic> json) => UserComment(
        name: json['name'] as String,
        avatarUri: json['avatarUri']?.toString(),
        content: json['content'] as String,
        timeComment: (json['timeComment'] as Timestamp).toDate(),
        // nlp: double.parse(json['nlp'] as String)
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'creatorId': this.id,
        'content': this.content,
        'timeComment': Timestamp.fromDate(this.timeComment),
      };
}
