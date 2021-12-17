import 'package:charityapp/domain/entities/base_post.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  final String eventId;
  const PostEvent({required this.eventId});

  @override
  List<Object> get props => [eventId];
}

class LoadPosts extends PostEvent {
  final int number;
  final int startIndex;
  LoadPosts(
      {required String eventId, required this.startIndex, required this.number})
      : super(eventId: eventId);

  @override
  List<Object> get props => [startIndex, number];
}

class DeletePost extends PostEvent {
  final BasePost post;
  DeletePost({required String eventId, required this.post})
      : super(eventId: eventId);

  @override
  List<Object> get props => [post];
}

class AddPost extends PostEvent {
  final Post post;
  AddPost({required String eventId, required this.post}) : super(eventId: eventId);

  @override
  List<Object> get props => [post];
}

class PostsUpdated extends PostEvent {
  final List<Post> posts;
  PostsUpdated({required String eventId, required this.posts})
      : super(eventId: eventId);

  @override
  List<Object> get props => [posts];
}