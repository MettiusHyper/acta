import 'package:acta/to_do/servicies/utils.dart';
import 'package:flutter/material.dart';

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
