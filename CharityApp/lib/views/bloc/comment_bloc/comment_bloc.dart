import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/entities/user_comment.dart';
import 'package:charityapp/repositories/comment_repository_imp.dart';
import 'package:charityapp/views/bloc/comment_bloc/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final _repository = CommentRepositoryImp();
  final _commentStream = StreamController<QuerySnapshot>();
  Stream<QuerySnapshot> get commentStream => _commentStream.stream;

  CommentBloc() : super(CommentInitial()) {
    on<LoadComments>(_onLoadComments);
    on<AddComment>(_onAddComment);
  }

  getComments(postId) => _commentStream.addStream(_repository.getComments(postId));

  FutureOr<void> _onLoadComments(LoadComments event, Emitter<CommentState> emit) {
    _commentStream.addStream(_repository.getComments(event.postId));
  }

  FutureOr<void> _onAddComment(AddComment event, Emitter<CommentState> emit) {
    final userComment = UserComment(name: 'test', avatarUri: null, content: event.content, timeComment: DateTime.now());
    _repository.addComment(event.postId, userComment);
  }

  @override
  void dispose() {
    _commentStream.sink.close();
  }
}
