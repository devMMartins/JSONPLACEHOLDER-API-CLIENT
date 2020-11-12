import 'package:dio/dio.dart';
import 'package:dio_app/app/modules/shared/custom_dio/custom_dio.dart';
import 'package:dio_app/app/modules/shared/errors.dart';
import 'package:dio_app/app/modules/shared/models/post_model.dart';

class HomeRepository {
  final CustomDio _client;

  HomeRepository(this._client);

  Future<List<PostModel>> getPosts() async {
    try {
      var response = await _client.dio.get("/posts");
      return (response.data as List)
          .map((item) => PostModel.fromMap(item))
          .toList();
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<int> createPost(PostModel post) async {
    try {
      var response = await _client.dio.post("/posts", data: post.toMap());
      return response.statusCode;
    } on DioError catch (e) {
      throw PostError(e.response.statusCode);
    } 
  }

  Future<int> updatePost(PostModel post) async {
    try {
      var response = await _client.dio.put("/posts/${post.id}", data: post.toMap());
      return response.statusCode;
    } on DioError catch (e) {
      throw PostError(e.response.statusCode);
    } 
  }

  Future<int> deletePost(int id) async {
    try {
      var response = await _client.dio.delete("/posts/$id");
      return response.statusCode;
    } on DioError catch (e) {
      throw PostError(e.response.statusCode);
    } 
  }
}
