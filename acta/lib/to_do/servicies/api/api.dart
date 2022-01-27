import 'package:acta/to_do/servicies/api/models.dart';
import 'package:acta/to_do/servicies/api/utils.dart';
import 'package:acta/to_do/servicies/utils.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

Future<ApiUser> userinfo() async {
  Response response = await apiRequest('GET', '/v1/userinfo');
  return ApiUser.fromJson(convert.jsonDecode(response.body));
}

Future<ApiUser> addTask(ApiTask task) async {
  Response response = await apiRequest('POST', '/v1/task', body: task.toJson());
  return ApiUser.fromJson(convert.jsonDecode(response.body));
}

Future<ApiUser> editTask(String taskId, ApiTask task) async {
  Response response = await apiRequest('PATCH', '/v1/task/$taskId', body: task.toJson());
  return ApiUser.fromJson(convert.jsonDecode(response.body));
}

Future<ApiUser> deleteTask(String taskId) async {
  Response response = await apiRequest('DELETE', '/v1/task/$taskId');
  return ApiUser.fromJson(convert.jsonDecode(response.body));
}

Future<ApiUser> addList(ApiList list) async {
  Response response =
      await apiRequest('POST', '/v1/list', body: {'name': list.name, 'color': list.color.toHex(), 'emoji': list.emoji});
  return ApiUser.fromJson(convert.jsonDecode(response.body));
}

Future<ApiUser> editList(String listId, ApiList list) async {
  Response response = await apiRequest('PATCH', '/v1/list/$listId', body: list.toJson());
  return ApiUser.fromJson(convert.jsonDecode(response.body));
}

Future<ApiUser> deletelist(String listId) async {
  Response response = await apiRequest('DELETE', '/v1/list/$listId');
  return ApiUser.fromJson(convert.jsonDecode(response.body));
}
