import 'package:charityapp/domain/entities/base_post.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends BasePost {
  String description;
  final int numberComment;
  final int numberLike;
  final List<String> tags;

  Post({
    required String title,
    UserOverview? creator,
    required this.description,
    this.numberComment = 0,
    this.numberLike = 0,
    this.tags = const <String>[],
  }) : super(title: title, creator: creator);

  // factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  // Map<String, dynamic> toJson() => _$PostToJson(this);

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        title: json['title'] as String,
        description: json['description'] as String,
        numberComment: json['numberComment'] as int? ?? 0,
        numberLike: json['numberLike'] as int? ?? 0,
        tags: (json['tags'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const <String>[],
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': this.title,
        'creatorId': this.creator.id,
        'description': this.description,
        'numberComment': this.numberComment,
        'numberLike': this.numberLike,
        'tags': this.tags,
      };
}
