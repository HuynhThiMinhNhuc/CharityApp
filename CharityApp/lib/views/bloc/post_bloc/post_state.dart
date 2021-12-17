import 'package:charityapp/domain/entities/base_post.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:equatable/equatable.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostsLoadSuccess extends PostState {
  final List<Post> posts;
  PostsLoadSuccess({required this.posts});

  @override
  List<Object> get props => [posts];
}

class PostsLoadFailure extends PostState {}

class PostsLoadInProgress extends PostState {}
