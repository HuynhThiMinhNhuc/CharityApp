import 'package:charityapp/domain/entities/base_post.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@CopyWith()
@JsonSerializable()
class Post extends BasePost {
  List<String> imagesUri;
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
    this.imagesUri = const <String>[],
    String? eventId,
    String? id,
  }) : super(title: title, creator: creator, eventId: eventId, id: id);

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
        imagesUri: (json['imagesUri'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const <String>[],
        eventId: json['eventId'] as String?,
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': this.title,
        'creatorId': this.creator.id,
        'eventId': this.eventId,
        'timeCreate': DateTime.now(),
        'description': this.description,
        'numberComment': this.numberComment,
        'numberLike': this.numberLike,
        'tags': this.tags,
        'imagesUri': this.imagesUri,
      };
}
