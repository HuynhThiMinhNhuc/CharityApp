import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/event_overview_paticipant.dart';
import 'package:equatable/equatable.dart';

abstract class PostState extends Equatable {
  final bool isLoading;
  final String? error;
  const PostState({required this.isLoading, this.error = null});

  @override
  List<Object> get props => [this.isLoading, this.error ?? ""];
}

class PostsLoadSuccess extends PostState {
  final List<Post> posts;
  PostsLoadSuccess({
    required this.posts,
    required bool isLoading,
    String? error = null,
  }) : super(isLoading: isLoading, error: error);

  @override
  List<Object> get props => [posts];
}

class PostsLoadOverviewSuccess extends PostState {
  final List<EventOverviewPaticipants> eventsOverview;
  PostsLoadOverviewSuccess({
    required this.eventsOverview,
    required bool isLoading,
    String? error = null,
  }) : super(isLoading: isLoading, error: error);

  @override
  List<Object> get props => [eventsOverview];
}

// class PostLoadFailure extends PostState {}

// class PostLoadInProgress extends PostState {}

class PostUpdated extends PostState {
  final Post post;
  const PostUpdated({
    required this.post,
    required bool isLoading,
    String? error = null,
  }) : super(isLoading: isLoading, error: error);
  @override
  List<Object> get props => [post];
}
// class PostUpdateFail extends PostState {
  
// }
