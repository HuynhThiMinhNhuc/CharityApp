import 'dart:io';

import 'package:charityapp/domain/entities/base_post.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class LoadEventPosts extends PostEvent {
  final String eventId;
  final int number;
  final int startIndex;
  const LoadEventPosts(
      {required this.eventId, required this.startIndex, required this.number});

  @override
  List<Object> get props => [startIndex, number, eventId];
}

class LoadOverViewEventsPaticipant extends PostEvent {
  final String creatorId;
  const LoadOverViewEventsPaticipant({required this.creatorId});

  @override
  List<Object> get props => [creatorId];
}

class DeletePost extends PostEvent {
  final BasePost post;
  const DeletePost({required String eventId, required this.post});

  @override
  List<Object> get props => [post];
}

class AddPost extends PostEvent {
  final Post post;
  final List<File> images;
  const AddPost({required this.post, this.images = const<File>[]});

  @override
  List<Object> get props => [post];
}
