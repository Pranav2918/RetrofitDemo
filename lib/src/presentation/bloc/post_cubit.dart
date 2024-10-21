import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retrofitdemo/src/data/todos_model.dart';
import 'package:retrofitdemo/src/domain/network_service/network_client.dart';
import 'package:retrofitdemo/src/presentation/bloc/post_states.dart';

class PostCubit extends Cubit<PostStates> {
  final NetworkClient _networkClient;

  PostCubit(this._networkClient) : super(PostListLoading());

  Future<void> getPosts() async {
    emit(PostListLoading());
    try {
      List<PostsModel> postList = await _networkClient.getPosts();
      emit(PostListFetched(posts: postList));
    } catch (e) {
      emit(PostListFailed(errorMessage: e.toString()));
    }
  }
}
