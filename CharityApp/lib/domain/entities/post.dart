import 'package:charityapp/domain/entities/base_object.dart';
import 'package:charityapp/domain/entities/base_post.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends BasePost{
  String description;
  final int numberComment;
  final int numberLike;
  final List<String> tags;

  Post({
    required String title,
    required UserOverview creator,
    required this.description,
    this.numberComment = 0,
    this.numberLike = 0,
    this.tags = const <String>[],
  }) : super(title: title, creator: creator);
  
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}