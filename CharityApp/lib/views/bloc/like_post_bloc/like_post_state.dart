import 'package:equatable/equatable.dart';

abstract class LikePostState extends Equatable {
  final String? id;
  const LikePostState({required this.id});

  @override
  List<Object> get props => [];
}

class PostNumberLike extends LikePostState {
  // final Post post;
  final int numberLike;
  final bool isLike;
  const PostNumberLike({required this.numberLike, required this.isLike, String? id}) :super(id: id);
  @override
  List<Object> get props => [isLike, numberLike];
}

// class LikePostUpdated extends LikePostState {
//   // final Post post;
//   final int numberLike;
//   final bool isLike;
//   const LikePostUpdated({required this.numberLike, required this.isLike});
//   @override
//   List<Object> get props => [];
// }

// class SinglePostUpdateFail extends LikePostState {
//   const SinglePostUpdateFail();
//   @override
//   List<Object> get props => [];
// }
