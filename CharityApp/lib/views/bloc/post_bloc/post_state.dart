abstract class PostState {
  const PostState();
}

class LoadingPostState extends PostState{}
class LoadedPostState extends PostState{}
class LoadingFailState extends PostState{}