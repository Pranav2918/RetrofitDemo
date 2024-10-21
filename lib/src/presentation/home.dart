import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retrofitdemo/src/data/todos_model.dart';
import 'package:retrofitdemo/src/domain/network_service/dio_injector.dart';
import 'package:retrofitdemo/src/domain/network_service/network_client.dart';
import 'package:retrofitdemo/src/presentation/bloc/post_cubit.dart';
import 'package:retrofitdemo/src/presentation/bloc/post_states.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PostsModel> _posts = <PostsModel>[];
  late NetworkClient _networkClient;

  @override
  void initState() {
    _networkClient = NetworkClient(getDio());
    context.read<PostCubit>().getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Retrofit Demo"),
      ),
      body: BlocBuilder<PostCubit, PostStates>(
        builder: (context, state) {
          if (state is PostListFetched) {
            _posts = state.posts;
            return ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, postIndex) {
                return PostCard(
                    title: _posts[postIndex].title!,
                    body: _posts[postIndex].body!);
              },
            );
          } else if (state is PostListFailed) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _networkClient.createUser("Pranav", "DevOps");
        },
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final String title;
  final String body;
  const PostCard({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(body),
    );
  }
}
