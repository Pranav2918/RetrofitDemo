import 'package:retrofitdemo/src/data/todos_model.dart';

abstract class PostStates {}

class PostListLoading extends PostStates {}

class PostListFailed extends PostStates {
  final String errorMessage;

  PostListFailed({required this.errorMessage});
}

class PostListFetched extends PostStates {
  final List<PostsModel> posts;

  PostListFetched({required this.posts});

}
