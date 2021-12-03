import 'package:charityapp/domain/entities/base_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends BaseObject{
  String title;
  String description;
  final int numberComment;
  final int numberLike;

  Post({
    required this.title,
    required this.description,
    this.numberComment = 0,
    this.numberLike = 0,
  });
  
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}