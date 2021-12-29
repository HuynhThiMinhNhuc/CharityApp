import 'package:equatable/equatable.dart';

abstract class LikePostEvent extends Equatable {
  final String postId;
  const LikePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}

class GetNumberLike extends LikePostEvent {
  const GetNumberLike({required String postId}) : super(postId: postId);
}

class LikePost extends LikePostEvent {
  final bool isLike;
  const LikePost({required this.isLike, required String postId})
      : super(postId: postId);

  @override
  List<Object> get props => [isLike];
}
