import 'dart:typed_data';

import 'package:charityapp/core/uint8list_converter.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_comment.g.dart';

@JsonSerializable()
class UserComment extends UserOverview{
  String content; 
  final String timeComment;

  UserComment({required String name, 
      required Uint8List? avatar, 
      required this.content, 
      required this.timeComment
  }) : super(avatar: avatar, name: name);

  factory UserComment.fromJson(Map<String, dynamic> json) => _$UserCommentFromJson(json);
  Map<String, dynamic> toJson() => _$UserCommentToJson(this);
}