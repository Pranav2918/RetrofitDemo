import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofitdemo/src/data/todos_model.dart';
part 'network_client.g.dart';

@RestApi(baseUrl: '') //Fill this if your domain is same for all APIs

abstract class NetworkClient {
  factory NetworkClient(Dio dio, {String? baseUrl}) = _NetworkClient;

  @GET('https://jsonplaceholder.typicode.com/posts')
  Future<List<PostsModel>> getPosts();

  @POST('https://reqres.in/api/users')
  Future<dynamic> createUser(
      @Field('name') String name, @Field('job') String job);
}
