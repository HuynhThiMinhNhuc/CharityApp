import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/bloc/post_bloc/post_event.dart';
import 'package:charityapp/views/bloc/post_bloc/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PostBloc extends Bloc<PostEvent, PostState>{
  PostBloc() : super(LoadingPostState());

  List<Post> listPost = [];
  final _postreposibility = new UserRepositoryImp();

  Stream<PostState> mapEventToState(PostEvent event) async* {
   if ( event is LoadPostEvent)
   {
     yield* _maptopoststate();
   }
  }
  Stream<PostState> _maptopoststate() async*{
    // try{
    //   yield* LoadingPostState();
    //   final element = await _postreposibility.getListPost(GetIt.I.get<Authenticator>().idCurrentUser);


   // }
  }
}