import 'package:todo_app/utils/util.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  DateTime createdTime;
  String title;
  String id;
  String description;
  bool isDone;

  Todo(
      {required this.createdTime,
      required this.title,
      this.id = '',
      this.description = '',
      this.isDone = false});

  static Todo fromJson(Map<String, dynamic> json) => Todo(
        createdTime: Utils.toDateTime(json['createdTime'])!,
        title: json['title'],
        id: json['id'],
        description: json['description'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'title': title,
        'description': description,
        'id': id,
        'isDone': isDone,
      };
}
