import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/views/bloc/comment_bloc/comment.dart';


class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial()) {
    on<LoadComments>(_onLoadComments);
    on<AddComment>(_onAddComment);
  }

  FutureOr<void> _onLoadComments(LoadComments event, Emitter<CommentState> emit) {
  }

  FutureOr<void> _onAddComment(AddComment event, Emitter<CommentState> emit) {
  }
}
