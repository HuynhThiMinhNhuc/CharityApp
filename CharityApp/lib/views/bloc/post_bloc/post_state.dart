import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/event_overview_paticipant.dart';
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

class PostsLoadOverviewSuccess extends PostState {
  final List<EventOverviewPaticipants> eventsOverview;
  PostsLoadOverviewSuccess({required this.eventsOverview});

  @override
  List<Object> get props => [eventsOverview];
}

class PostsLoadFailure extends PostState {}

class PostsLoadInProgress extends PostState {}

class LoadingPostState extends PostState {}

class LoadedPostState extends PostState {
  List<Post> listPost = [];

  LoadedPostState(this.listPost);
}


class LoadingDetailPostState extends PostState {}

class LoadedDetailPostState extends PostState {}

class LoadingFailDetailState extends PostState {}
