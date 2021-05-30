import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/utils/util.dart';

class FirebaseApi {
  static Future<String> createTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc();
    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }

  static Future updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.delete();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> readTodos() =>
      FirebaseFirestore.instance.collection("todo").get();
}
