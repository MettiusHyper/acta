import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:acta/servicies/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const url = 'api.actado.tk';

class ApiUser {
  late String id;
  late ApiList defaultList;
  late List<ApiList> lists;

  ApiUser.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    List<ApiList> listsobj = [];
    for (var list in json['lists']) {
      var listTasks = [];
      json['tasks'].sort((a, b) => a['date'].compareTo(b['date']) as int);
      for (var task in json['tasks']) {
        if (task['list'] == list['id']) {
          listTasks.add(task);
        }
      }

      if (list['id'] == json['default_list']) {
        defaultList = ApiList.fromJson(list, listTasks);
      }
      listsobj.add(ApiList.fromJson(list, listTasks));
    }
    lists = listsobj;
  }
}

class ApiTask {
  late String id;
  late String name;
  late Color color;
  late String description;
  late DateTime date;
  late String list;
  late bool check;

  ApiTask(this.name, this.color, this.description, this.date, this.list, this.check);

  ApiTask.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = HexColor.fromHex(json['color']);
    description = json['description'];
    date = DateTime.fromMillisecondsSinceEpoch(json['date']);
    list = json['list'];
    check = json['check'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'color': color.toHex(),
      'description': description,
      'date': date.millisecondsSinceEpoch.toString(),
      'list': list,
      'check': check.toString()
    };
  }
}

class ApiList {
  late String id;
  late String name;
  late Color color;
  late String emoji;
  late List<ApiTask> tasks;

  ApiList(this.name, this.color, this.emoji);

  ApiList.fromJson(Map<String, dynamic> json, List<dynamic> apitasks) {
    id = json['id'];
    name = json['name'];
    color = HexColor.fromHex(json['color']);
    emoji = json['emoji'];
    List<ApiTask> tasksobj = [];
    for (var element in apitasks) {
      tasksobj.add(ApiTask.fromJson(element));
    }
    tasks = tasksobj;
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'color': color.toHex(), 'emoji': emoji};
  }
}

Future<ApiUser> userinfo() async {
  var response = await http
      .get(Uri.https(url, '/v1/userinfo'), headers: {'token': await FirebaseAuth.instance.currentUser!.getIdToken()});
  return ApiUser.fromJson(convert.jsonDecode(response.body));
}

Future<ApiUser> addTask(ApiTask task) async {
  var response = await http.post(Uri.https(url, '/v1/task'),
      headers: {'token': await FirebaseAuth.instance.currentUser!.getIdToken()}, body: task.toJson());
  return ApiUser.fromJson(convert.jsonDecode(response.body));
}

Future<ApiUser> editTask(String taskId, ApiTask task) async {
  var response = await http.patch(Uri.https(url, '/v1/task/$taskId'),
      headers: {'token': await FirebaseAuth.instance.currentUser!.getIdToken()}, body: task.toJson());
  return ApiUser.fromJson(convert.jsonDecode(response.body));
}

Future<ApiUser> deleteTask(String taskId) async {
  var response = await http.delete(
    Uri.https(url, '/v1/task/$taskId'),
    headers: {'token': await FirebaseAuth.instance.currentUser!.getIdToken()},
  );
  return ApiUser.fromJson(convert.jsonDecode(response.body));
}

Future<ApiUser> addList(ApiList list) async {
  var response = await http.post(Uri.https(url, '/v1/list'),
      headers: {'token': await FirebaseAuth.instance.currentUser!.getIdToken()},
      body: {'name': list.name, 'color': list.color.toHex(), 'emoji': list.emoji});
  return ApiUser.fromJson(convert.jsonDecode(response.body));
}

Future<ApiUser> editList(String listId, ApiList list) async {
  var response = await http.patch(Uri.https(url, '/v1/list/$listId'),
      headers: {'token': await FirebaseAuth.instance.currentUser!.getIdToken()}, body: list.toJson());
  return ApiUser.fromJson(convert.jsonDecode(response.body));
}

Future<ApiUser> deletelist(String listId) async {
  var response = await http.delete(
    Uri.https(url, '/v1/list/$listId'),
    headers: {'token': await FirebaseAuth.instance.currentUser!.getIdToken()},
  );
  return ApiUser.fromJson(convert.jsonDecode(response.body));
}
