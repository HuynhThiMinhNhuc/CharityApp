import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/entities/user_comment.dart';
import 'package:charityapp/repositories/comment_repository_imp.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/bloc/comment_bloc/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final _repository = CommentRepositoryImp();
  final _commentStream = StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get commentStream => _commentStream.stream;

  CommentBloc() : super(CommentInitial()) {
    // on<LoadComments>(_onLoadComments);
    on<AddComment>(_onAddComment);
  }

  getComments(postId) {
    final stream = _repository.getComments(postId);
    final customStream = stream.asyncMap((event) async {
      // final listNLP = await http.post(
      //     Uri.https('80e1-42-119-147-155.ap.ngrok.io', 'comment'),
      //     headers: {'Content-Type': 'application/json; charset=UTF-8'},
      //     body: jsonEncode({
      //       'comments': event.docs.map((i) => i['content']).toList(),
      //     }));

      print(event.docs.map((i) => i['content']).toList());
      // print('ListNLP');

      // final listNLPJson = jsonDecode(listNLP.body)['probabilities'];

      // print(listNLP.body);
      // return event;
      return event.docs.map((e) {
        final index = event.docs.indexWhere((i)=>i.id == e.id);
        final data = e.data();
        // data.addAll(
        //     {'nlp': listNLPJson[index][0]});
        return data;
      }).toList();
    });
    _commentStream.addStream(customStream);
  }

  // FutureOr<void> _onLoadComments(
  //     LoadComments event, Emitter<CommentState> emit) {
  //   final stream = _repository.getComments(event.postId);
  //   final customStream = stream.asyncMap((event) {
  //     return event.docs.map((e) {
  //       final data = e.data();
  //       data.addAll({'probabilities': ''});
  //       return data;
  //     }).toList();
  //   });
  //   _commentStream.addStream(customStream);
  // }

  FutureOr<void> _onAddComment(AddComment event, Emitter<CommentState> emit) {
    final userComment = UserComment(
        id: Authenticator.Id,
        name: Authenticator.profile.name,
        avatarUri: Authenticator.profile.avatarUri,
        content: event.content,
        timeComment: DateTime.now());
    _repository.addComment(event.postId, userComment);
  }

  Future<UserComment> getComment(Map<String, dynamic> json) {
    return _repository.getComment(json);
  }

  @override
  void dispose() {
    _commentStream.sink.close();
  }
}
