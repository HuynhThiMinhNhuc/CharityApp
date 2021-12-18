import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_comment.g.dart';

@JsonSerializable()
class UserComment extends UserOverview {
  String content;
  final String timeComment;

  UserComment(
      {required String name,
      required Uri? avatarUri,
      required this.content,
      required this.timeComment})
      : super(avatarUri: avatarUri, name: name);

  // factory UserComment.fromJson(Map<String, dynamic> json) => _$UserCommentFromJson(json);
  // Map<String, dynamic> toJson() => _$UserCommentToJson(this);

  factory UserComment.fromJson(Map<String, dynamic> json) => UserComment(
        name: json['name'] as String,
        avatarUri: json['avatarUri'] == null
            ? null
            : Uri.parse(json['avatarUri'] as String),
        content: json['content'] as String,
        timeComment: json['timeComment'] as String,
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
        'avatarUri': this.avatarUri?.toString(),
        'content': this.content,
        'timeComment': this.timeComment,
      };
}
